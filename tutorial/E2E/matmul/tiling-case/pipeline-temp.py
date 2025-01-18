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
    air_source_code = read_mlir_file("input.mlir")
    air_module = Module.parse(air_source_code)

    with open("input-check.mlir", "w") as f:
        f.write(str(air_module))

    ################################################
    ## Binding scf.paralell to air hierarchies
    ## 这个pass的作用是将scf.parallel转换为air hierarchies。
    ################################################

    # 下述pipeline的重点是air-par-to-herd
    pipeline = (
        "builtin.module("
        + ",".join(
            [
                # air-copy-to-dma 触发了scf.parallel的merge nest pass
                "air-copy-to-dma",
                "buffer-results-to-out-params",
                "air-linalg-to-func{link-with=mm.o}",
                "air-par-to-herd{depth=0}",
                # "air-par-to-launch{has-air-segment=true}",
                "canonicalize",
                "cse",
            ]
        )
        + ")"
    )
    pm = air.passmanager.PassManager.parse(pipeline)
    pm.run(air_module.operation)

    with open("input2.mlir", "w") as f:
        f.write(str(air_module))

    # # ################################################
    # # ## 做place-herd操作
    # # ################################################

    # # 设定默认值
    # # 设定默认值
    # num_cols = 10
    # col_offset = 7
    # num_rows = 6
    # row_offset = 2

    # # 构造 air-place-herds 的 pass
    # air_place_pass = (
    #     "air-place-herds{"
    #     + f"num-rows={num_rows} "
    #     + f"num-cols={num_cols} "
    #     + f"row-anchor={row_offset} "
    #     + f"col-anchor={col_offset}"
    #     + "}"
    # )

    # # 构造 pass pipeline
    # pass_pipeline = ",".join(
    #     [
    #         "air-insert-launch-and-segment-around-herd",
    #         "func.func(air-lower-herd-parallel)",
    #     ]
    #     + [
    #         "canonicalize",
    #         "cse",
    #         "air-specialize-channel-wrap-and-stride",
    #         "func.func(air-renumber-dma)",
    #         "func.func(convert-linalg-to-loops)",
    #         air_place_pass,
    #     ]
    # )

    # # 生成最终的 pipeline 字符串
    # pipeline = "builtin.module(" + pass_pipeline + ")"

    # # 打印生成的 pipeline（可选，供调试使用）
    # print(pipeline)

    # pm = air.passmanager.PassManager.parse(pipeline)
    # pm.run(air_module.operation)

    # with open("input-place-herd.mlir", "w") as f:
    #     f.write(str(air_module))

    # ################################################
    # ## 做air-to-aie操作
    # ################################################

    # # 构造 pass pipeline
    # air_aie_pass = (
    #     "air-to-aie{"
    #     + f"emit-while-loop=true "
    #     + f"row-offset={row_offset} "
    #     + f"col-offset={col_offset} "
    #     + f"device=xcvc1902"
    #     + "}"
    # )

    # # 生成最终的 pipeline 字符串
    # pipeline = "builtin.module(" + air_aie_pass + ")"

    # # 打印生成的 pipeline（可选，供调试使用）
    # print(pipeline)

    # pm = air.passmanager.PassManager.parse(pipeline)
    # pm.run(air_module.operation)

    # with open("input-air-aie.mlir", "w") as f:
    #     f.write(str(air_module))
