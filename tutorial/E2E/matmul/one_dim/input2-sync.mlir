module {
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c2 = arith.constant 2 : index
    %async_token, %results = air.execute -> (memref<2x2xf32>) {
      %alloc = memref.alloc() : memref<2x2xf32>
      air.execute_terminator %alloc : memref<2x2xf32>
    }
    %0 = air.herd @herd_0 async [%async_token]  tile (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%arg0, %arg8=%arg1, %arg9=%results) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> attributes {id = 1 : i32} {
      %cst = arith.constant 0.000000e+00 : f32
      %c1 = arith.constant 1 : index
      %c2_2 = arith.constant 2 : index
      %async_token_3, %results_4 = air.execute -> (memref<1x1xf32, 2>) {
        %alloc = memref.alloc() : memref<1x1xf32, 2>
        air.execute_terminator %alloc : memref<1x1xf32, 2>
      }
      %async_token_5 = air.execute [%async_token_3] {
        linalg.fill ins(%cst : f32) outs(%results_4 : memref<1x1xf32, 2>)
      }
      %async_token_6, %results_7 = air.execute -> (memref<1x1xf32, 2>) {
        %alloc = memref.alloc() : memref<1x1xf32, 2>
        air.execute_terminator %alloc : memref<1x1xf32, 2>
      }
      %async_token_8, %results_9 = air.execute -> (memref<1x1xf32, 2>) {
        %alloc = memref.alloc() : memref<1x1xf32, 2>
        air.execute_terminator %alloc : memref<1x1xf32, 2>
      }
      %1 = air.dma_memcpy_nd async [%async_token_6] (%results_7[] [] [], %arg7[%arg3, %arg4] [%c1, %c1] [%c2_2, %c1]) {id = 1 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
      %2 = air.dma_memcpy_nd async [%async_token_8] (%results_9[] [] [], %arg8[%arg3, %arg4] [%c1, %c1] [%c2_2, %c1]) {id = 2 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
      %async_token_10 = air.execute [%2, %1, %async_token_5] {
        linalg.add ins(%results_7, %results_9 : memref<1x1xf32, 2>, memref<1x1xf32, 2>) outs(%results_4 : memref<1x1xf32, 2>)
      }
      %async_token_11 = air.execute [%async_token_10] {
        memref.dealloc %results_7 : memref<1x1xf32, 2>
      }
      %async_token_12 = air.execute [%async_token_10] {
        memref.dealloc %results_4 : memref<1x1xf32, 2>
      }
      %3 = air.dma_memcpy_nd async [%async_token_12] (%arg9[%arg3, %arg4] [%c1, %c1] [%c2_2, %c1], %results_4[] [] []) {id = 3 : i32} : (memref<2x2xf32>, memref<1x1xf32, 2>)
      %async_token_13 = air.execute [%3] {
        memref.dealloc %results_4 : memref<1x1xf32, 2>
      }
    }
    %async_token_0 = air.execute [%0] {
      memref.copy %results, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    }
    %async_token_1 = air.execute [%async_token_0] {
      memref.dealloc %results : memref<2x2xf32>
    }
    return
  }
}
