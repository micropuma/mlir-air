#!/usr/bin/env bash
##===- utils/setup_python_packages.sh - Setup python packages for mlir-air build --*- Script -*-===##
# 
# This file licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# 
##===----------------------------------------------------------------------===##
#
# This script sets up and installs the required python packages to build mlir-air.
#
# source ./setup_python_packages.sh
#
##===----------------------------------------------------------------------===##

virtualenv sandbox
source sandbox/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -r utils/requirements.txt
HOST_MLIR_PYTHON_PACKAGE_PREFIX=aie python3 -m pip install -r utils/requirements_extras.txt
