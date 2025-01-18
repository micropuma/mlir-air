module attributes {torch.debug_module_name = "LargeMatrixMultiplication"} {
  memref.global "private" @global_seed : memref<i64> = dense<0>
  func.func @forward(%arg0: memref<1024x1024xf32, strided<[?, ?], offset: ?>>, %arg1: memref<1024x1024xf32, strided<[?, ?], offset: ?>>, %arg2: memref<1024x1024xf32>) {
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c1024 = arith.constant 1024 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<1024x1024xf32>
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c1024, %c1024) step (%c1, %c1) {
      memref.store %cst, %alloc[%arg3, %arg4] : memref<1024x1024xf32>
      scf.reduce 
    }
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c1024, %c1024) step (%c32, %c32) {
      scf.for %arg5 = %c0 to %c1024 step %c32 {
        %subview = memref.subview %arg0[%arg3, %arg5] [32, 32] [1, 1] : memref<1024x1024xf32, strided<[?, ?], offset: ?>> to memref<32x32xf32, strided<[?, ?], offset: ?>>
        %subview_0 = memref.subview %arg1[%arg5, %arg4] [32, 32] [1, 1] : memref<1024x1024xf32, strided<[?, ?], offset: ?>> to memref<32x32xf32, strided<[?, ?], offset: ?>>
        %subview_1 = memref.subview %alloc[%arg3, %arg4] [32, 32] [1, 1] : memref<1024x1024xf32> to memref<32x32xf32, strided<[1024, 1], offset: ?>>
        %alloc_2 = memref.alloc() : memref<32x32xf32, 2>
        %alloc_3 = memref.alloc() : memref<32x32xf32, 2>
        %alloc_4 = memref.alloc() : memref<32x32xf32, 2>
        memref.copy %subview, %alloc_2 : memref<32x32xf32, strided<[?, ?], offset: ?>> to memref<32x32xf32, 2>
        memref.copy %subview_0, %alloc_3 : memref<32x32xf32, strided<[?, ?], offset: ?>> to memref<32x32xf32, 2>
        memref.copy %subview_1, %alloc_4 : memref<32x32xf32, strided<[1024, 1], offset: ?>> to memref<32x32xf32, 2>
        scf.parallel (%arg6, %arg7) = (%c0, %c0) to (%c32, %c32) step (%c1, %c1) {
          scf.for %arg8 = %c0 to %c32 step %c1 {
            %0 = memref.load %alloc_2[%arg6, %arg8] : memref<32x32xf32, 2>
            %1 = memref.load %alloc_3[%arg8, %arg7] : memref<32x32xf32, 2>
            %2 = memref.load %alloc_4[%arg6, %arg7] : memref<32x32xf32, 2>
            %3 = arith.mulf %0, %1 : f32
            %4 = arith.addf %2, %3 : f32
            memref.store %4, %alloc_4[%arg6, %arg7] : memref<32x32xf32, 2>
          }
          scf.reduce 
        }
        memref.copy %alloc_4, %subview_1 : memref<32x32xf32, 2> to memref<32x32xf32, strided<[1024, 1], offset: ?>>
        memref.dealloc %alloc_2 : memref<32x32xf32, 2>
        memref.dealloc %alloc_3 : memref<32x32xf32, 2>
        memref.dealloc %alloc_4 : memref<32x32xf32, 2>
      }
      scf.reduce 
    }
    memref.copy %alloc, %arg2 : memref<1024x1024xf32> to memref<1024x1024xf32>
    memref.dealloc %alloc : memref<1024x1024xf32>
    return
  }
}

