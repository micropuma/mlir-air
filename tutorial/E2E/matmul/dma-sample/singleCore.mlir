//===- air.mlir ------------------------------------------------*- MLIR -*-===//
//
// Copyright (C) 2020-2022, Xilinx Inc.
// Copyright (C) 2022, Advanced Micro Devices, Inc.
// SPDX-License-Identifier: MIT
//
//===----------------------------------------------------------------------===//

module {

func.func @graph(%arg0 : memref<256xi32>, %arg1 : memref<256xi32>) -> () {
  %herd_cols = arith.constant 1 : index
  %herd_rows = arith.constant 1 : index
  air.herd tile(%tx, %ty) in (%size_x = %herd_cols, %size_y = %herd_rows) args(%ext0 = %arg0, %ext1 = %arg1) : memref<256xi32>, memref<256xi32> attributes { sym_name="copyherd"} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c256 = arith.constant 256 : index
    %buf0 = memref.alloc() {sym_name = "scratch"}: memref<256xi32, 2>
    %buf1 = memref.alloc() {sym_name = "scratch_copy"}: memref<256xi32, 2>
    air.dma_memcpy_nd (%buf0[][][], %ext0[][][]) {id = 1 : i32} : (memref<256xi32, 2>, memref<256xi32>)
    affine.for %i = 0 to 256 {
      %0 = affine.load %buf0[%i] : memref<256xi32, 2>
      affine.store %0, %buf1[%i] : memref<256xi32, 2>
    }
    air.dma_memcpy_nd (%ext1[][][], %buf0[][][]) {id = 2 : i32} : (memref<256xi32>, memref<256xi32, 2>)
    memref.dealloc %buf1 : memref<256xi32, 2>
    memref.dealloc %buf0 : memref<256xi32, 2>
    air.herd_terminator
  }
  return
}

}
