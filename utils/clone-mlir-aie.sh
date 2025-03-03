#!/usr/bin/env bash

##===- utils/clone-mlir-aie.sh - Clone MLIR-AIE --------------*- Script -*-===##
#
# Copyright (C) 2022, Advanced Micro Devices, Inc.
# SPDX-License-Identifier: MIT

##===----------------------------------------------------------------------===##
#
# This script checks out MLIR-AIE.  We use this instead of a git submodule to 
# manage commithash synchronization with LLVM.
#
# This script is called from the github workflows.
#
##===----------------------------------------------------------------------===##

export HASH=e462815b878c761e7eb851efb532f342fb0ad340
target_dir=mlir-aie

if [[ ! -d $target_dir ]]; then
  git clone --depth 1 git@github.com:micropuma/mlir-aie-dly.git $target_dir
fi

pushd $target_dir
git fetch --depth=1 origin $HASH
git checkout $HASH

popd