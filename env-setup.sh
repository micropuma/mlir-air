export PYTHONPATH=/home/douliyang/large/mlir-workspace/mlir-air/install-pcie/python:${PYTHONPATH}
export PATH=/home/douliyang/large/mlir-workspace/mlir-air/install-pcie/bin:${PATH}
unset CPLUS_INCLUDE_PATH
cd mlir-aie
source utils/env_setup.sh install/ ../llvm/install/ /home/douliyang/app/llvm-aie-source/llvm-aie/build/
cd ..

source /usr/xilinx/Environment_Bash/AIE.sh 2023.2