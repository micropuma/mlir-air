# mlir-opt input.mlir --linalg-generalize-named-ops \
#                     --convert-linalg-to-parallel-loops \
#                     -o input1.mlir

 air-opt input.mlir --air-linalg-codegen \
                    -debug \
                    -o input1.mlir \
                    2>&1 | tee air-linalg-codegen.txt

# air-opt input1.mlir --convert-linalg-to-loops -o input1.mlir



