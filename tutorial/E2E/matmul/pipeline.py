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
    ################################################

    pipeline = (
        "builtin.module("
        + ",".join(
            [
                "buffer-results-to-out-params",
                "air-linalg-to-func{link-with=mm.o}",
                "air-par-to-herd{depth=1}",
                "air-par-to-launch{has-air-segment=true}",
                "air-copy-to-dma",
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