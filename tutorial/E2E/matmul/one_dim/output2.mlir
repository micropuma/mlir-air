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
    %0 = air.channel.put async  @channel_0[%c0, %c0] (%arg0[%c0, %c0] [%c1, %c1] [%c2, %c1]) {id = 1 : i32} : (memref<2x2xf32>)
    %1 = air.channel.put async  @channel_0[%c1, %c0] (%arg0[%c1, %c0] [%c1, %c1] [%c2, %c1]) {id = 2 : i32} : (memref<2x2xf32>)
    %2 = air.channel.put async  @channel_0[%c0, %c1] (%arg0[%c0, %c1] [%c1, %c1] [%c2, %c1]) {id = 3 : i32} : (memref<2x2xf32>)
    %3 = air.channel.put async  @channel_0[%c1, %c1] (%arg0[%c1, %c1] [%c1, %c1] [%c2, %c1]) {id = 4 : i32} : (memref<2x2xf32>)
    %4 = air.channel.put async  @channel_1[%c0, %c0] (%arg1[%c0, %c0] [%c1, %c1] [%c2, %c1]) {id = 5 : i32} : (memref<2x2xf32>)
    %5 = air.channel.put async  @channel_1[%c1, %c0] (%arg1[%c1, %c0] [%c1, %c1] [%c2, %c1]) {id = 6 : i32} : (memref<2x2xf32>)
    %6 = air.channel.put async  @channel_1[%c0, %c1] (%arg1[%c0, %c1] [%c1, %c1] [%c2, %c1]) {id = 7 : i32} : (memref<2x2xf32>)
    %7 = air.channel.put async  @channel_1[%c1, %c1] (%arg1[%c1, %c1] [%c1, %c1] [%c2, %c1]) {id = 8 : i32} : (memref<2x2xf32>)
    %8 = air.channel.get async [%async_token]  @channel_2[%c0, %c0] (%results[%c0, %c0] [%c1, %c1] [%c2, %c1]) {id = 9 : i32} : (memref<2x2xf32>)
    %9 = air.channel.get async [%async_token]  @channel_2[%c1, %c0] (%results[%c1, %c0] [%c1, %c1] [%c2, %c1]) {id = 10 : i32} : (memref<2x2xf32>)
    %10 = air.channel.get async [%async_token]  @channel_2[%c0, %c1] (%results[%c0, %c1] [%c1, %c1] [%c2, %c1]) {id = 11 : i32} : (memref<2x2xf32>)
    %11 = air.channel.get async [%async_token]  @channel_2[%c1, %c1] (%results[%c1, %c1] [%c1, %c1] [%c2, %c1]) {id = 12 : i32} : (memref<2x2xf32>)
    %12 = air.launch async [%async_token] (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) {
      %13 = air.segment @matadd_0 async  attributes {x_loc = 7 : i64, x_size = 10 : i64, y_loc = 2 : i64, y_size = 6 : i64} {
        %c2_2 = arith.constant 2 : index
        %14 = air.herd @herd_0 async  tile (%arg7, %arg8) in (%arg9=%c2_2, %arg10=%c2_2) attributes {x_loc = 7 : i64, y_loc = 2 : i64} {
          %c1_3 = arith.constant 1 : index
          %c0_4 = arith.constant 0 : index
          %cst = arith.constant 0.000000e+00 : f32
          %async_token_5, %results_6 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_7 = air.execute [%async_token_5] {
            scf.for %arg11 = %c0_4 to %c1_3 step %c1_3 {
              scf.for %arg12 = %c0_4 to %c1_3 step %c1_3 {
                memref.store %cst, %results_6[%arg11, %arg12] : memref<1x1xf32, 2>
              }
            }
          }
          %async_token_8, %results_9 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %async_token_10, %results_11 = air.execute -> (memref<1x1xf32, 2>) {
            %alloc = memref.alloc() : memref<1x1xf32, 2>
            air.execute_terminator %alloc : memref<1x1xf32, 2>
          }
          %15 = air.channel.get async [%async_token_8]  @channel_0[%arg7, %arg8] (%results_9[] [] []) {id = 13 : i32} : (memref<1x1xf32, 2>)
          %16 = air.channel.get async [%async_token_10]  @channel_1[%arg7, %arg8] (%results_11[] [] []) {id = 14 : i32} : (memref<1x1xf32, 2>)
          %async_token_12 = air.execute [%16, %15, %async_token_7] {
            scf.for %arg11 = %c0_4 to %c1_3 step %c1_3 {
              scf.for %arg12 = %c0_4 to %c1_3 step %c1_3 {
                %18 = memref.load %results_9[%arg11, %arg12] : memref<1x1xf32, 2>
                %19 = memref.load %results_11[%arg11, %arg12] : memref<1x1xf32, 2>
                %20 = arith.addf %18, %19 : f32
                memref.store %20, %results_6[%arg11, %arg12] : memref<1x1xf32, 2>
              }
            }
          }
          %async_token_13 = air.execute [%async_token_12] {
            memref.dealloc %results_9 : memref<1x1xf32, 2>
          }
          %async_token_14 = air.execute [%async_token_12] {
            memref.dealloc %results_6 : memref<1x1xf32, 2>
          }
          %17 = air.channel.put async [%async_token_14]  @channel_2[%arg7, %arg8] (%results_6[] [] []) {id = 15 : i32} : (memref<1x1xf32, 2>)
          %async_token_15 = air.execute [%17] {
            memref.dealloc %results_6 : memref<1x1xf32, 2>
          }
        }
      }
    }
    %async_token_0 = air.execute [%async_token] {
      memref.copy %results, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    }
    %async_token_1 = air.execute [%async_token_0] {
      memref.dealloc %results : memref<2x2xf32>
    }
    return
  }
}

