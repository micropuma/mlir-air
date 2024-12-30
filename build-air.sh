#!/bin/bash

./utils/build-mlir-air-pcie.sh ./llvm ./mlir-aie/cmake/modulesXilinx/ ./mlir-air ./mlir-aie/build/aie-rt-x86_64-hsa ${ROCM_ROOT}/lib/cmake/hsa-runtime64/ ${ROCM_ROOT}/lib/cmake/hsakmt/
