module {
  air.channel @channel_0 [2, 2]
  air.channel @channel_1 [2, 2]
  air.channel @channel_2 [2, 2]
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %async_token, %results = air.execute -> (memref<2x2xf32>) {
      %alloc = memref.alloc() : memref<2x2xf32>
      air.execute_terminator %alloc : memref<2x2xf32>
    }
    %0 = air.wait_all async 
    %1 = scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c2, %c2) step (%c1, %c1) init (%0) -> !air.async.token {
      %6 = air.channel.put async  @channel_0[%arg3, %arg4] (%arg0[%arg3, %arg4] [%c1, %c1] [%c2, %c1]) {id = 1 : i32} : (memref<2x2xf32>)
      scf.reduce(%6 : !air.async.token) {
      ^bb0(%arg5: !air.async.token, %arg6: !air.async.token):
        %7 = air.wait_all async [%arg5, %arg6] 
        scf.reduce.return %7 : !air.async.token
      }
    }
    %2 = air.wait_all async 
    %3 = scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c2, %c2) step (%c1, %c1) init (%2) -> !air.async.token {
      %6 = air.channel.put async  @channel_1[%arg3, %arg4] (%arg1[%arg3, %arg4] [%c1, %c1] [%c2, %c1]) {id = 2 : i32} : (memref<2x2xf32>)
      scf.reduce(%6 : !air.async.token) {
      ^bb0(%arg5: !air.async.token, %arg6: !air.async.token):
        %7 = air.wait_all async [%arg5, %arg6] 
        scf.reduce.return %7 : !air.async.token
      }
    }
    %4 = scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c2, %c2) step (%c1, %c1) init (%async_token) -> !air.async.token {
      %6 = air.channel.get async [%async_token]  @channel_2[%arg3, %arg4] (%results[%arg3, %arg4] [%c1, %c1] [%c2, %c1]) {id = 3 : i32} : (memref<2x2xf32>)
      scf.reduce(%6 : !air.async.token) {
      ^bb0(%arg5: !air.async.token, %arg6: !air.async.token):
        %7 = air.wait_all async [%arg5, %arg6] 
        scf.reduce.return %7 : !air.async.token
      }
    }
    %5 = air.launch async [%async_token] (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) {
      %6 = air.segment @matadd_0 async  attributes {x_loc = 7 : i64, x_size = 10 : i64, y_loc = 2 : i64, y_size = 6 : i64} {
        %c1_2 = arith.constant 1 : index
        %c4 = arith.constant 4 : index
        %7 = air.herd @herd_0 async  tile (%arg7, %arg8) in (%arg9=%c1_2, %arg10=%c4) attributes {x_loc = 7 : i64, y_loc = 2 : i64} {
          %cst = arith.constant 0.000000e+00 : f32
          %c0_3 = arith.constant 0 : index
          %c2_4 = arith.constant 2 : index
          %8 = arith.remsi %arg8, %c2_4 : index
          %9 = arith.divsi %arg8, %c2_4 : index
          %async_token_5, %results_6 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_7 = air.execute [%async_token_5] {
            memref.store %cst, %results_6[%c0_3, %c0_3] : memref<1x1xf32, 2>
          }
          %async_token_8, %results_9 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_10, %results_11 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %10 = air.channel.get async [%async_token_8]  @channel_0[%9, %8] (%results_9[] [] []) {id = 4 : i32} : (memref<1x1xf32, 2>)
          %11 = air.channel.get async [%async_token_10]  @channel_1[%9, %8] (%results_11[] [] []) {id = 5 : i32} : (memref<1x1xf32, 2>)
          %async_token_12 = air.execute [%11, %10, %async_token_7] {
            %13 = memref.load %results_9[%c0_3, %c0_3] : memref<1x1xf32, 2>
            %14 = memref.load %results_11[%c0_3, %c0_3] : memref<1x1xf32, 2>
            %15 = arith.addf %13, %14 : f32
            memref.store %15, %results_6[%c0_3, %c0_3] : memref<1x1xf32, 2>
          }
          %async_token_13 = air.execute [%async_token_12] {
            memref.dealloc %results_9 : memref<1x1xf32, 2>
          }
          %async_token_14 = air.execute [%async_token_12] {
            memref.dealloc %results_11 : memref<1x1xf32, 2>
          }
          %12 = air.channel.put async [%async_token_12]  @channel_2[%9, %8] (%results_6[] [] []) {id = 6 : i32} : (memref<1x1xf32, 2>)
          %async_token_15 = air.execute [%12] {
            memref.dealloc %results_6 : memref<1x1xf32, 2>
          }
        }
      }
    }
    %async_token_0 = air.execute [%5] {
      memref.copy %results, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    }
    %async_token_1 = air.execute [%async_token_0] {
      memref.dealloc %results : memref<2x2xf32>
    }
    return
  }
}
