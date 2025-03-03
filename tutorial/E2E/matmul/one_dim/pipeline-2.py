import air
import air.compiler.util
from air.dialects import linalg, tensor, arith, func, memref
from air.ir import *
import air.passmanager
from air.dialects import air as airdialect
from air.compiler.util import run_transform
import sys

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
    # Read the MLIR file
    air_source_code = read_mlir_file("input2-try.mlir")
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
    pm.run(air_module.operation)
    with open("air_herd.mlir", "w") as f:
        f.write(str(air_module))

    ################################################
    ## Place herd to segment
    ################################################

    air_async_module = Module.parse(str(air_module))
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
    pm.run(air_module.operation)
    with open("air_placed.mlir", "w") as f:
        f.write(str(air_module))

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
    pm = air.passmanager.PassManager.parse(pipeline)
    pm.run(air_module.operation)
    with open("aie.mlir", "w") as f:
        f.write(str(air_module))

    ################################################
    ## AIR runtime的处理
    ################################################
    runtime_pipeline = "builtin.module(" + ",".join([
        # "air-split-devices{output-prefix=air_project/}",
        "func.func(air-label-broadcast-channel-with-tile)",
        "lower-affine",
        "air-to-std",
        "air-lower-linalg-tensors",
        "canonicalize",
        "cse",
    ]) + ")"
    pm = air.passmanager.PassManager.parse(runtime_pipeline)
    pm.run(air_module.operation)
    with open("final_llvm.mlir", "w") as f:
        f.write(str(air_module))

    