#!/bin/bash

./utils/build-mlir-air-pcie.sh ./llvm ./mlir-aie/cmake/modulesXilinx/ ./mlir-aie /home/douliyang/opt/aiengine ${ROCM_ROOT}/lib/cmake/hsa-runtime64/ ${ROCM_ROOT}/lib/cmake/hsakmt/
