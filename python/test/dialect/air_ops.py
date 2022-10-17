# ./python/test/dialect/air_ops.py -*- Python -*-

# Copyright (C) 2021-2022, Xilinx Inc.
# Copyright (C) 2022, Advanced Micro Devices, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

# RUN: %PYTHON %s | FileCheck %s

import air
from air.mlir.ir import *
from air.dialects import air as airdialect
from air.mlir.dialects import arith
from air.mlir.dialects import func

def constructAndPrintInFunc(f):
  print("\nTEST:", f.__name__)
  with Context() as ctx, Location.unknown():
    airdialect.register_dialect(ctx)
    module = Module.create()
    with InsertionPoint(module.body):
      ftype = FunctionType.get(
          [IntegerType.get_signless(32),
           IntegerType.get_signless(32)], [])
      fop = func.FuncOp(f.__name__, ftype)
      bb = fop.add_entry_block()
      with InsertionPoint(bb):
        f()
        func.ReturnOp([])
  print(module)

# CHECK-LABEL: TEST: launchOp
# CHECK: air.launch @pyLaunch () in () {
# CHECK:   %{{.*}} = arith.constant 1 : index
# CHECK:   air.launch_terminator
@constructAndPrintInFunc
def launchOp():
  l = airdialect.LaunchOp("pyLaunch")
  with InsertionPoint(l.body):
    idx_ty = IndexType.get()
    arith.ConstantOp(idx_ty, IntegerAttr.get(idx_ty, 1))
    airdialect.LaunchTerminatorOp()

# CHECK-LABEL: TEST: partitionOp
# CHECK: air.partition @pyPartition {
# CHECK:   %{{.*}} = arith.constant 1 : index
# CHECK:   air.partition_terminator
@constructAndPrintInFunc
def partitionOp():
  P = airdialect.PartitionOp("pyPartition")
  with InsertionPoint(P.body):
    idx_ty = IndexType.get()
    arith.ConstantOp(idx_ty, IntegerAttr.get(idx_ty, 1))
    airdialect.PartitionTerminatorOp()

# CHECK-LABEL: TEST: herdOp
# CHECK: %[[C0:.*]] = arith.constant 2 : index
# CHECK: %[[C1:.*]] = arith.constant 2 : index
# CHECK: air.herd @pyHerd tile (%{{.*}}, %{{.*}}) in (%{{.*}}=%[[C0]], %{{.*}}=%[[C1]]) {
# CHECK:   %{{.*}} = arith.constant 1 : index
# CHECK:   air.herd_terminator
@constructAndPrintInFunc
def herdOp():
  idx_ty = IndexType.get()
  size_x = arith.ConstantOp(idx_ty, IntegerAttr.get(idx_ty, 2))
  size_y = arith.ConstantOp(idx_ty, IntegerAttr.get(idx_ty, 2))
  sizes = [size_x.result, size_y.result]
  H = airdialect.HerdOp("pyHerd", sizes, [])
  with InsertionPoint(H.body):
    arith.ConstantOp(idx_ty, IntegerAttr.get(idx_ty, 1))
    airdialect.HerdTerminatorOp()

# CHECK-LABEL: TEST: waitallOp
# CHECK: %0 = air.wait_all async
# CHECK: air.wait_all [%0]
@constructAndPrintInFunc
def waitallOp():
  token_type = airdialect.AsyncTokenType.get()
  e = airdialect.WaitAllOp(token_type,[]).result
  airdialect.WaitAllOp(None,[e])
