module {
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c1 = arith.constant 1 : index
    %async_token, %results = air.execute -> (memref<2x2xf32>) {
      %alloc = memref.alloc() : memref<2x2xf32>
      air.execute_terminator %alloc : memref<2x2xf32>
    }
    %0 = air.launch async [%async_token] (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) args(%arg7=%arg0, %arg8=%arg1, %arg9=%results) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
      %1 = air.segment @matadd_0 async  args(%arg10=%arg7, %arg11=%arg8, %arg12=%arg9) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
        %c2 = arith.constant 2 : index
        %2 = air.herd @herd_0 async  tile (%arg13, %arg14) in (%arg15=%c2, %arg16=%c2) args(%arg17=%arg10, %arg18=%arg11, %arg19=%arg12) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
          %c0 = arith.constant 0 : index
          %cst = arith.constant 0.000000e+00 : f32
          %c1_2 = arith.constant 1 : index
          %c2_3 = arith.constant 2 : index
          %async_token_4, %results_5 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_6 = air.execute [%async_token_4] {
            scf.for %arg20 = %c0 to %c1_2 step %c1_2 {
              scf.for %arg21 = %c0 to %c1_2 step %c1_2 {
                memref.store %cst, %results_5[%arg20, %arg21] : memref<1x1xf32, 2>
              }
            }
          }
          %async_token_7, %results_8 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_9, %results_10 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %3 = air.dma_memcpy_nd async [%async_token_7] (%results_8[] [] [], %arg17[%arg13, %arg14] [%c1_2, %c1_2] [%c2_3, %c1_2]) {id = 1 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
          %4 = air.dma_memcpy_nd async [%async_token_9] (%results_10[] [] [], %arg18[%arg13, %arg14] [%c1_2, %c1_2] [%c2_3, %c1_2]) {id = 2 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
          %async_token_11 = air.execute [%4, %3, %async_token_6] {
            scf.for %arg20 = %c0 to %c1_2 step %c1_2 {
              scf.for %arg21 = %c0 to %c1_2 step %c1_2 {
                %6 = memref.load %results_8[%arg20, %arg21] : memref<1x1xf32, 2>
                %7 = memref.load %results_10[%arg20, %arg21] : memref<1x1xf32, 2>
                %8 = arith.addf %6, %7 : f32
                memref.store %8, %results_5[%arg20, %arg21] : memref<1x1xf32, 2>
              }
            }
          }
          %async_token_12 = air.execute [%async_token_11] {
            memref.dealloc %results_8 : memref<1x1xf32, 2>
          }
          %async_token_13 = air.execute [%async_token_11] {
            memref.dealloc %results_10 : memref<1x1xf32, 2>
          }
          %5 = air.dma_memcpy_nd async [%async_token_11] (%arg19[%arg13, %arg14] [%c1_2, %c1_2] [%c2_3, %c1_2], %results_5[] [] []) {id = 3 : i32} : (memref<2x2xf32>, memref<1x1xf32, 2>)
          %async_token_14 = air.execute [%5] {
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
