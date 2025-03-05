module {
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c1 = arith.constant 1 : index
    %async_token, %results = air.execute -> (memref<2x2xf32>) {
      %alloc = memref.alloc() : memref<2x2xf32>
      air.execute_terminator %alloc : memref<2x2xf32>
    }
    %0 = air.launch async [%async_token] (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) args(%arg7=%arg0, %arg8=%arg1, %arg9=%results) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
      %1 = air.segment @matadd_0 async  args(%arg10=%arg7, %arg11=%arg8, %arg12=%arg9) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> attributes {x_loc = 7 : i64, x_size = 10 : i64, y_loc = 2 : i64, y_size = 6 : i64} {
        %c1_2 = arith.constant 1 : index
        %c4 = arith.constant 4 : index
        %2 = air.herd @herd_0 async  tile (%arg13, %arg14) in (%arg15=%c1_2, %arg16=%c4) args(%arg17=%arg10, %arg18=%arg11, %arg19=%arg12) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> attributes {x_loc = 7 : i64, y_loc = 2 : i64} {
          %c1_3 = arith.constant 1 : index
          %cst = arith.constant 0.000000e+00 : f32
          %c0 = arith.constant 0 : index
          %c2 = arith.constant 2 : index
          %3 = arith.remsi %arg14, %c2 : index
          %4 = arith.divsi %arg14, %c2 : index
          %async_token_4, %results_5 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_6 = air.execute [%async_token_4] {
            memref.store %cst, %results_5[%c0, %c0] : memref<1x1xf32, 2>
          }
          %async_token_7, %results_8 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_9, %results_10 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %5 = air.dma_memcpy_nd async [%async_token_7] (%results_8[] [] [], %arg17[%4, %3] [%c1_3, %c1_3] [%c2, %c1_3]) {id = 1 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
          %6 = air.dma_memcpy_nd async [%async_token_9] (%results_10[] [] [], %arg18[%4, %3] [%c1_3, %c1_3] [%c2, %c1_3]) {id = 2 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
          %async_token_11 = air.execute [%6, %5, %async_token_6] {
            %8 = memref.load %results_8[%c0, %c0] : memref<1x1xf32, 2>
            %9 = memref.load %results_10[%c0, %c0] : memref<1x1xf32, 2>
            %10 = arith.addf %8, %9 : f32
            memref.store %10, %results_5[%c0, %c0] : memref<1x1xf32, 2>
          }
          %async_token_12 = air.execute [%async_token_11] {
            memref.dealloc %results_8 : memref<1x1xf32, 2>
          }
          %async_token_13 = air.execute [%async_token_11] {
            memref.dealloc %results_10 : memref<1x1xf32, 2>
          }
          %7 = air.dma_memcpy_nd async [%async_token_11] (%arg19[%4, %3] [%c1_3, %c1_3] [%c2, %c1_3], %results_5[] [] []) {id = 3 : i32} : (memref<2x2xf32>, memref<1x1xf32, 2>)
          %async_token_14 = air.execute [%7] {
            memref.dealloc %results_5 : memref<1x1xf32, 2>
          }
        }
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
