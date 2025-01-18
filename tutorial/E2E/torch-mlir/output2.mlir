module attributes {torch.debug_module_name = "LargeMatrixMultiplication"} {
  memref.global "private" @global_seed : memref<i64> = dense<0>
  func.func @forward(%arg0: memref<2x2xf32, strided<[?, ?], offset: ?>>, %arg1: memref<2x2xf32, strided<[?, ?], offset: ?>>, %arg2: memref<2x2xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %alloca = memref.alloca() {alignment = 64 : i64} : memref<2x2xf32>
    memref.store %cst, %alloca[%c0, %c0] : memref<2x2xf32>
    memref.store %cst, %alloca[%c1, %c0] : memref<2x2xf32>
    memref.store %cst, %alloca[%c0, %c1] : memref<2x2xf32>
    memref.store %cst, %alloca[%c1, %c1] : memref<2x2xf32>
    %alloc = memref.alloc() : memref<2x2xf32, 2>
    %alloc_0 = memref.alloc() : memref<2x2xf32, 2>
    %alloc_1 = memref.alloc() : memref<2x2xf32, 2>
    air.dma_memcpy_nd (%alloc[] [] [], %arg0[] [] []) {id = 1 : i32} : (memref<2x2xf32, 2>, memref<2x2xf32, strided<[?, ?], offset: ?>>)
    air.dma_memcpy_nd (%alloc_0[] [] [], %arg1[] [] []) {id = 2 : i32} : (memref<2x2xf32, 2>, memref<2x2xf32, strided<[?, ?], offset: ?>>)
    air.dma_memcpy_nd (%alloc_1[] [] [], %alloca[] [] []) {id = 3 : i32} : (memref<2x2xf32, 2>, memref<2x2xf32>)
    air.launch (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) args(%arg7=%alloc, %arg8=%alloc_0, %arg9=%alloc_1) : memref<2x2xf32, 2>, memref<2x2xf32, 2>, memref<2x2xf32, 2> {
      air.segment @forward_0  args(%arg10=%arg7, %arg11=%arg8, %arg12=%arg9) : memref<2x2xf32, 2>, memref<2x2xf32, 2>, memref<2x2xf32, 2> attributes {x_loc = 7 : i64, x_size = 10 : i64, y_loc = 2 : i64, y_size = 6 : i64} {
        %c2 = arith.constant 2 : index
        air.herd @herd_0  tile (%arg13, %arg14) in (%arg15=%c2, %arg16=%c2) args(%arg17=%arg10, %arg18=%arg11, %arg19=%arg12) : memref<2x2xf32, 2>, memref<2x2xf32, 2>, memref<2x2xf32, 2> attributes {x_loc = 7 : i64, y_loc = 2 : i64} {
          %c0_2 = arith.constant 0 : index
          %c2_3 = arith.constant 2 : index
          %c1_4 = arith.constant 1 : index
          scf.for %arg20 = %c0_2 to %c2_3 step %c1_4 {
            %0 = memref.load %arg17[%arg13, %arg20] : memref<2x2xf32, 2>
            %1 = memref.load %arg18[%arg20, %arg14] : memref<2x2xf32, 2>
            %2 = memref.load %arg19[%arg13, %arg14] : memref<2x2xf32, 2>
            %3 = arith.mulf %0, %1 : f32
            %4 = arith.addf %2, %3 : f32
            memref.store %4, %arg19[%arg13, %arg14] : memref<2x2xf32, 2>
          }
        }
      }
    }
    air.dma_memcpy_nd (%alloca[] [] [], %alloc_1[] [] []) {id = 4 : i32} : (memref<2x2xf32>, memref<2x2xf32, 2>)
    memref.dealloc %alloc : memref<2x2xf32, 2>
    memref.dealloc %alloc_0 : memref<2x2xf32, 2>
    memref.dealloc %alloc_1 : memref<2x2xf32, 2>
    memref.copy %alloca, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    return
  }
}

