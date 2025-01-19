module {
  func.func @test(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c2 = arith.constant 2 : index
    %async_token, %results = air.execute -> (memref<2x2xf32>) {
      %alloc = memref.alloc() : memref<2x2xf32>
      air.execute_terminator %alloc : memref<2x2xf32>
    }
    %c1 = arith.constant 1 : index
    %c1_0 = arith.constant 1 : index
    %0 = air.launch async [%async_token] (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1_0) args(%arg7=%arg0, %arg8=%arg1, %arg9=%results) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
      %1 = air.segment @matadd_0 async  args(%arg10=%arg3, %arg11=%arg4, %arg12=%arg5, %arg13=%arg6, %arg14=%arg7, %arg15=%arg8, %arg16=%arg9) : index, index, index, index, memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
        %c2_3 = arith.constant 2 : index
        %c2_4 = arith.constant 2 : index
        %2 = air.herd @herd_0 async  tile (%arg17, %arg18) in (%arg19=%c2_3, %arg20=%c2_4) args(%arg21=%arg10, %arg22=%arg11, %arg23=%arg12, %arg24=%arg13, %arg25=%arg14, %arg26=%arg15, %arg27=%arg16) : index, index, index, index, memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
          %cst = arith.constant 0.000000e+00 : f32
          %c1_5 = arith.constant 1 : index
          %c2_6 = arith.constant 2 : index
          %async_token_7, %results_8 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_9 = air.execute [%async_token_7] {
            linalg.fill ins(%cst : f32) outs(%results_8 : memref<1x1xf32, 2>)
          }
          %async_token_10, %results_11 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_12, %results_13 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %3 = air.dma_memcpy_nd async [%async_token_10] (%results_11[] [] [], %arg25[%arg17, %arg18] [%c1_5, %c1_5] [%c2_6, %c1_5]) {id = 1 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
          %4 = air.dma_memcpy_nd async [%async_token_12] (%results_13[] [] [], %arg26[%arg17, %arg18] [%c1_5, %c1_5] [%c2_6, %c1_5]) {id = 2 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
          %async_token_14 = air.execute [%4, %3, %async_token_9] {
            linalg.add ins(%results_11, %results_13 : memref<1x1xf32, 2>, memref<1x1xf32, 2>) outs(%results_8 : memref<1x1xf32, 2>)
          }
          %async_token_15 = air.execute [%async_token_14] {
            memref.dealloc %results_11 : memref<1x1xf32, 2>
          }
          %async_token_16 = air.execute [%async_token_14] {
            memref.dealloc %results_8 : memref<1x1xf32, 2>
          }
          %5 = air.dma_memcpy_nd async [%async_token_16] (%arg27[%arg17, %arg18] [%c1_5, %c1_5] [%c2_6, %c1_5], %results_8[] [] []) {id = 3 : i32} : (memref<2x2xf32>, memref<1x1xf32, 2>)
          %async_token_17 = air.execute [%5] {
            memref.dealloc %results_8 : memref<1x1xf32, 2>
          }
        }
      }
    }
    %async_token_1 = air.execute [%0] {
      memref.copy %results, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    }
    %async_token_2 = air.execute [%async_token_1] {
      memref.dealloc %results : memref<2x2xf32>
    }
    return
  }
}
