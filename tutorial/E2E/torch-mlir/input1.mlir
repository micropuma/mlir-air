module attributes {torch.debug_module_name = "LargeMatrixMultiplication"} {
  memref.global "private" @global_seed : memref<i64> = dense<0>
  func.func @forward(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %alloca = memref.alloca() {alignment = 64 : i64} : memref<2x2xf32>
    linalg.fill ins(%cst : f32) outs(%alloca : memref<2x2xf32>)
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c32 = arith.constant 32 : index
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c2, %c2) step (%c32, %c32) {
      scf.for %arg5 = %c0 to %c2 step %c32 {
        %subview = memref.subview %arg0[%arg3, %arg5] [%c2, %c2] [1, 1] : memref<2x2xf32> to memref<?x?xf32, strided<[2, 1], offset: ?>>
        %subview_0 = memref.subview %arg1[%arg5, %arg4] [%c2, %c2] [1, 1] : memref<2x2xf32> to memref<?x?xf32, strided<[2, 1], offset: ?>>
        %subview_1 = memref.subview %alloca[%arg3, %arg4] [%c2, %c2] [1, 1] : memref<2x2xf32> to memref<?x?xf32, strided<[2, 1], offset: ?>>
        %alloc = memref.alloc() : memref<2x2xf32, 2>
        %alloc_2 = memref.alloc() : memref<2x2xf32, 2>
        %alloc_3 = memref.alloc() : memref<2x2xf32, 2>
        memref.copy %subview, %alloc : memref<?x?xf32, strided<[2, 1], offset: ?>> to memref<2x2xf32, 2>
        memref.copy %subview_0, %alloc_2 : memref<?x?xf32, strided<[2, 1], offset: ?>> to memref<2x2xf32, 2>
        memref.copy %subview_1, %alloc_3 : memref<?x?xf32, strided<[2, 1], offset: ?>> to memref<2x2xf32, 2>
        linalg.matmul ins(%alloc, %alloc_2 : memref<2x2xf32, 2>, memref<2x2xf32, 2>) outs(%alloc_3 : memref<2x2xf32, 2>)
        memref.copy %alloc_3, %subview_1 : memref<2x2xf32, 2> to memref<?x?xf32, strided<[2, 1], offset: ?>>
        memref.dealloc %alloc : memref<2x2xf32, 2>
        memref.dealloc %alloc_2 : memref<2x2xf32, 2>
        memref.dealloc %alloc_3 : memref<2x2xf32, 2>
      }
      scf.reduce 
    }
    memref.copy %alloca, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    return
  }
}

