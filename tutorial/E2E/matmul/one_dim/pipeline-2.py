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

    