import os
import subprocess
import air
import air.compiler.util
from air.dialects import linalg, tensor, arith, func, memref
from air.ir import Module, Context, Location
import air.passmanager
from air.dialects import air as airdialect
from air.compiler.util import run_transform
from air.passmanager import PassManager
import sys

# 显示处理runtime的代码
def lower_airrt_to_airhost(air_to_aie_module, air_placed_module, air_mlir_filename):
    # Split the input into one output per aie.device op 
    tmp = "tmp"
    pass_pipeline = "air-split-devices{"
    pass_pipeline = pass_pipeline + f"output-prefix={tmp}/" + "}"
    run_passes("builtin.module(" + pass_pipeline + ")", air_to_aie_module)

    # lower the airrt control program to llvm dialect

    # core pass is air-to-std
    # This pass converts AIR dialect herd launch operations into loop nests 
    # representing the host-side control program for the herd. 
    # It also converts AIR dialect memcpy operations into AIRRt memcpy operations.
    # This pass actually find host code from mlir and convert to airrt for further lowering.
    airrt_module = Module.parse(str(air_to_aie_module))
    aie_ctrl_airrt =  "tmp/airrt." + air_mlir_filename
    pass_pipeline = ",".join(
        [
            "convert-vector-to-llvm",
            "convert-math-to-llvm",
            "func.func(air-label-broadcast-channel-with-tile)",
            "lower-affine",
            "air-to-std",
            "air-lower-linalg-tensors",
            "canonicalize",
            "cse",
        ]
    )
    # write into aie_ctrl_airrt file.
    run_passes(
        "builtin.module(" + pass_pipeline + ")", airrt_module, aie_ctrl_airrt
    )

    # lower the airrt control program to llvm dialect
    # ==================================== airrt-to-llvm ====================================
    # This pass lowers AIRRt dialect to function calls and data structures matching those found in air_host.h.
    # AIRRt static metadata is transformed to LLVM dialect data structures. 
    # The data is generated as a number of globals with external linkage. 
    # The data layout is closely tied the AIR runtime and the definitions in air_host.h. 
    # Any changes to this pass must be reflected there. 

    # ==================================== one-shot-bufferize ====================================
    # refer to https://mlir.llvm.org/docs/Bufferization/
    # This pass performs bufferization in a single shot.
    aie_ctrl = "tmp/aie_ctrl." + air_mlir_filename
    pass_pipeline = ",".join(["airrt-to-llvm", "one-shot-bufferize"])

    # convert airrt.test.mlir to aie_ctrl.test.mlir
    run_passes("builtin.module(" + pass_pipeline + ")", airrt_module, aie_ctrl)

    # I guess this is to do rt in one pass
    aie_ctrl_refback = "tmp/refback." + air_mlir_filename
    pass_pipeline = ",".join(
        [
            "convert-vector-to-llvm",
            "convert-math-to-llvm",
            "func.func(air-label-broadcast-channel-with-tile)",
            "lower-affine",
            "air-to-std",
            "air-lower-linalg-tensors",
            "canonicalize",
            "cse",
            "airrt-to-llvm",
            "canonicalize",
            "cse",
        ]
    )
    run_passes(
        "builtin.module(" + pass_pipeline + ")",
        Module.parse(str(air_placed_module)),
        aie_ctrl_refback,
    )

    # lower previous llvm dialect to llvm code
    aie_ctrl_llvm = "tmp/llvm." + air_mlir_filename
    pass_pipeline = ",".join(
        [
            "expand-strided-metadata",
            "lower-affine",
            "convert-scf-to-cf",
            "finalize-memref-to-llvm",
            "convert-func-to-llvm",
            "convert-cf-to-llvm",
            "canonicalize",
            "cse",
        ]
    )
    run_passes(
        "builtin.module(" + pass_pipeline + ")", airrt_module, aie_ctrl_llvm
    )

    # compile the llvm dialect into a .o object file
    # now the kernel code is aie dialect, and the host code is all llvm code

    aie_ctrl_llvm_ir = "tmp/" + air_mlir_filename + ".ll"
    do_call(
        ["aie-translate", "--mlir-to-llvmir", aie_ctrl_llvm, "-o", aie_ctrl_llvm_ir]
    )

    # use llvm-opt to optimize the llvm code
    aie_ctrl_llvm_opt_bc = "tmp/" + air_mlir_filename + ".opt.bc"
    do_call(["opt", "-O3", aie_ctrl_llvm_ir, "-o", aie_ctrl_llvm_opt_bc])

    aie_ctrl_llvm_opt_ir = "tmp/" + air_mlir_filename + ".opt.ll"
    do_call(["llvm-dis", aie_ctrl_llvm_opt_bc, "-o", aie_ctrl_llvm_opt_ir])

    # compile the llvm dialect into a .o object file
    # with O3 optimization and pic relocation model
    aie_ctrl_obj = "tmp/" + air_mlir_filename + ".o"
    llc_target = None

    llc_target = "aarch64"
    do_call(
        ["llc", "-O3", "--filetype=obj", "--relocation-model=pic"]
        + (["-march=" + llc_target] if llc_target else [])
        + [aie_ctrl_llvm_opt_ir, "-o", aie_ctrl_obj]
    )

    # make aie elf files and host .o files for each herd in the program

    t = do_run(["air-translate", "--airrt-generate-json", aie_ctrl_airrt])
    module_meta = eval(t.stdout)
    segments = [module_meta[segment]["sym_name"] for segment in module_meta]
    obj_files = [aie_ctrl_obj]
    for segment in segments:
        print("Compiling segment:", segment)

        # build the elf files for the segment

        # herd_file = opts.tmpdir+'/aie.'+herd+'.mlir'
        segment_file = "tmp/aie." + segment + ".mlir"
        aiecc_file = "tmp/aiecc." + segment + ".mlir"

        do_call(
            [
                "air-opt",
                segment_file,
                "-air-lower-linalg-tensors",
                "-lower-affine",
                "-canonicalize",
                "-cse",
                "-o",
                aiecc_file,
            ]
        )

# helper function for run process
def get_experimental_passes(omit_pingpong=True):
    EXPERIMENTAL_PASSES = [
        "air-dependency",
        "air-dependency-schedule-opt",
        "air-specialize-dma-broadcast",
        "air-dma-to-channel",
        "canonicalize",
        "cse",
        "air-dependency-canonicalize",
        "canonicalize",
        "cse",
    ]
    if not omit_pingpong:
        EXPERIMENTAL_PASSES += [
            "func.func(air-loop-fusion)",
            "air-label-scf-for-to-ping-pong",
            "air-ping-pong-transform{keep-memref-dealloc=true}",
        ]
    EXPERIMENTAL_PASSES += [
        "air-isolate-async-dma-loop-nests",
        "air-linalg-to-func",
        "canonicalize",
        "cse",
    ]
    return EXPERIMENTAL_PASSES

def do_call(command):
    print(" ".join(command))
    ret = subprocess.call(command)
    if ret != 0:
        print("Error encountered while running: " + " ".join(command))
        sys.exit(1)


def do_run(command):
    print(" ".join(command))
    ret = subprocess.run(
        command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True
    )
    return ret


def run_passes(pass_pipeline, mlir_module, outputfile=None):
    print("Running:", pass_pipeline)
    PassManager.parse(pass_pipeline).run(mlir_module.operation)
    if outputfile:
        with open(outputfile, "w") as g:
            g.write(str(mlir_module))

# helper function for reading MLIR files
def read_mlir_file(file_path):
    """
    Reads the content of an MLIR file and returns it as a string.

    :param file_path: Path to the input MLIR file
    :return: Content of the file as a string
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            mlir_content = file.read()
        return mlir_content
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
        return None
    except Exception as e:
        print(f"An error occurred: {e}")
        return None

with air.ir.Context() as ctx, Location.unknown():
    # Ensure tmp directory exists
    tmp_dir = "tmp"
    if not os.path.exists(tmp_dir):
        os.makedirs(tmp_dir)

    # Read the MLIR file
    air_source_code = read_mlir_file("input2.mlir")
    air_module = Module.parse(air_source_code)

    pipeline = (
        "builtin.module("
        + ",".join(
            [
                "air-dependency",
                "air-dependency-schedule-opt",
                "air-specialize-dma-broadcast",
                "canonicalize",
                "cse",
                "air-dependency-canonicalize",
                "canonicalize",
                "cse",
                "func.func(air-split-l2-memref)",
                "air-isolate-async-dma-loop-nests",
                "canonicalize",
                "cse",
                "func.func(air-loop-fusion)",
                "air-insert-launch-and-segment-around-herd",
            ]
        )
        + ")"
    )

    pm = air.passmanager.PassManager.parse(pipeline)
    pm.run(air_module.operation)

    with open("input2-sync.mlir", "w") as f:
        f.write(str(air_module))

    air_async_module = Module.parse(str(air_module))
    pipeline = (
        "builtin.module("
        + ",".join(
            [
                "air-insert-launch-and-segment-around-herd",
                "func.func(air-lower-herd-parallel)",  # 这里修正，包裹在 func.func 里
                "canonicalize",
                "cse", 
                "func.func(air-renumber-dma)",  # 这个 Pass 也是 function 级别的，修正
                "func.func(convert-linalg-to-loops)",  # 修正
            ]
        )
        + ")"
    )
    pm = air.passmanager.PassManager.parse(pipeline)
    pm.run(air_async_module.operation)
    with open("air_herd.mlir", "w") as f:
        f.write(str(air_async_module))

    ################################################
    ## Place herd to segment
    ################################################

    air_placed_module = Module.parse(str(air_async_module))
    pipeline = (
        "builtin.module("
        + ",".join(
            [
                "func.func(air-collapse-herd{max-col-size=10})",
                "canonicalize",
                "cse",
                "air-place-herds{num-rows=6 num-cols=10 row-anchor=2 col-anchor=7}",
                "canonicalize",
                "cse",
                "func.func(air-renumber-dma)",
            ]
        )
        + ")"
    )
    
    pm = air.passmanager.PassManager.parse(pipeline)
    pm.run(air_placed_module.operation)
    with open("air_placed.mlir", "w") as f:
        f.write(str(air_placed_module))

    ################################################
    ## MLIR-AIR to MLIR-AIE
    ################################################
    
    pipeline = (
        "builtin.module("
        + ",".join(
            [
                "canonicalize",
                "cse",
                "air-to-aie{emit-while-loop=true row-offset=2 col-offset=7 device=xcvc1902 generate-shim-dma=true}",
                "canonicalize",
            ]
        )
        + ")"
    )
    air_aie_module = Module.parse(str(air_placed_module))
    pm = air.passmanager.PassManager.parse(pipeline)
    pm.run(air_aie_module.operation)
    with open("aie.mlir", "w") as f:
        f.write(str(air_aie_module))

    ################################################
    ## AIR runtime的处理
    ################################################ 

    lower_airrt_to_airhost(air_aie_module, air_placed_module, "onedim")

