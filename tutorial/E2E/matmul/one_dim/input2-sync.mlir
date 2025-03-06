module {
  air.channel @channel_0 [2, 2]
  air.channel @channel_1 [2, 2]
  air.channel @channel_2 [2, 2]
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c2 = arith.constant 2 : index
    %async_token, %results = air.execute -> (memref<2x2xf32>) {
      %alloc = memref.alloc() : memref<2x2xf32>
      air.execute_terminator %alloc : memref<2x2xf32>
    }
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    %c2_1 = arith.constant 2 : index
    %c2_2 = arith.constant 2 : index
    %0 = air.wait_all async 
    %1 = scf.parallel (%arg3, %arg4) = (%c0, %c0_0) to (%c2_1, %c2_2) step (%c1, %c1) init (%0) -> !air.async.token {
      %c1_15 = arith.constant 1 : index
      %c2_16 = arith.constant 2 : index
      %7 = air.wait_all async 
      %8 = air.wait_all async 
      %9 = air.wait_all async 
      %10 = air.wait_all async 
      %11 = air.wait_all async 
      %12 = air.channel.put async [%0]  @channel_0[%arg3, %arg4] (%arg0[%arg3, %arg4] [%c1_15, %c1_15] [%c2_16, %c1_15]) : (memref<2x2xf32>)
      %13 = air.wait_all async 
      %14 = air.wait_all async 
      %15 = air.wait_all async 
      %16 = air.wait_all async 
      %17 = air.wait_all async 
      %18 = air.wait_all async 
      %19 = air.wait_all async 
      %20 = air.wait_all async [%12] 
      scf.reduce(%20 : !air.async.token) {
      ^bb0(%arg5: !air.async.token, %arg6: !air.async.token):
        %21 = air.wait_all async [%arg5, %arg6] 
        scf.reduce.return %21 : !air.async.token
      }
    }
    %c1_3 = arith.constant 1 : index
    %c0_4 = arith.constant 0 : index
    %c0_5 = arith.constant 0 : index
    %c2_6 = arith.constant 2 : index
    %c2_7 = arith.constant 2 : index
    %2 = air.wait_all async 
    %3 = scf.parallel (%arg3, %arg4) = (%c0_4, %c0_5) to (%c2_6, %c2_7) step (%c1_3, %c1_3) init (%2) -> !air.async.token {
      %c1_15 = arith.constant 1 : index
      %c2_16 = arith.constant 2 : index
      %7 = air.wait_all async 
      %8 = air.wait_all async 
      %9 = air.wait_all async 
      %10 = air.wait_all async 
      %11 = air.wait_all async 
      %12 = air.wait_all async 
      %13 = air.wait_all async 
      %14 = air.wait_all async 
      %15 = air.wait_all async 
      %16 = air.wait_all async 
      %17 = air.channel.put async [%2]  @channel_1[%arg3, %arg4] (%arg1[%arg3, %arg4] [%c1_15, %c1_15] [%c2_16, %c1_15]) : (memref<2x2xf32>)
      %18 = air.wait_all async 
      %19 = air.wait_all async 
      %20 = air.wait_all async 
      %21 = air.wait_all async 
      %22 = air.wait_all async 
      %23 = air.wait_all async 
      %24 = air.wait_all async [%17] 
      scf.reduce(%24 : !air.async.token) {
      ^bb0(%arg5: !air.async.token, %arg6: !air.async.token):
        %25 = air.wait_all async [%arg5, %arg6] 
        scf.reduce.return %25 : !air.async.token
      }
    }
    %c1_8 = arith.constant 1 : index
    %c0_9 = arith.constant 0 : index
    %c0_10 = arith.constant 0 : index
    %c2_11 = arith.constant 2 : index
    %c2_12 = arith.constant 2 : index
    %4 = air.wait_all async [%async_token] 
    %5 = scf.parallel (%arg3, %arg4) = (%c0_9, %c0_10) to (%c2_11, %c2_12) step (%c1_8, %c1_8) init (%4) -> !air.async.token {
      %c1_15 = arith.constant 1 : index
      %c2_16 = arith.constant 2 : index
      %7 = air.wait_all async 
      %8 = air.wait_all async 
      %9 = air.wait_all async 
      %10 = air.wait_all async 
      %11 = air.wait_all async 
      %12 = air.wait_all async 
      %13 = air.wait_all async 
      %14 = air.wait_all async 
      %15 = air.wait_all async 
      %16 = air.wait_all async 
      %17 = air.wait_all async 
      %18 = air.wait_all async 
      %19 = air.wait_all async 
      %20 = air.wait_all async 
      %21 = air.wait_all async 
      %22 = air.wait_all async 
      %23 = air.wait_all async 
      %24 = air.channel.get async [%async_token, %4]  @channel_2[%arg3, %arg4] (%results[%arg3, %arg4] [%c1_15, %c1_15] [%c2_16, %c1_15]) : (memref<2x2xf32>)
      %25 = air.wait_all async 
      %26 = air.wait_all async 
      %27 = air.wait_all async 
      %28 = air.wait_all async [%24] 
      scf.reduce(%28 : !air.async.token) {
      ^bb0(%arg5: !air.async.token, %arg6: !air.async.token):
        %29 = air.wait_all async [%arg5, %arg6] 
        scf.reduce.return %29 : !air.async.token
      }
    }
    %6 = air.herd @herd_0 async [%async_token]  tile (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%arg0, %arg8=%arg1, %arg9=%results) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> attributes {id = 1 : i32} {
      %cst = arith.constant 0.000000e+00 : f32
      %c1_15 = arith.constant 1 : index
      %c2_16 = arith.constant 2 : index
      %async_token_17, %results_18 = air.execute -> (memref<1x1xf32, 2>) {
        %alloc = memref.alloc() : memref<1x1xf32, 2>
        air.execute_terminator %alloc : memref<1x1xf32, 2>
      }
      %async_token_19 = air.execute [%async_token_17] {
        linalg.fill ins(%cst : f32) outs(%results_18 : memref<1x1xf32, 2>)
      }
      %async_token_20, %results_21 = air.execute -> (memref<1x1xf32, 2>) {
        %alloc = memref.alloc() : memref<1x1xf32, 2>
        air.execute_terminator %alloc : memref<1x1xf32, 2>
      }
      %async_token_22, %results_23 = air.execute -> (memref<1x1xf32, 2>) {
        %alloc = memref.alloc() : memref<1x1xf32, 2>
        air.execute_terminator %alloc : memref<1x1xf32, 2>
      }
      %7 = air.channel.get async [%async_token_20]  @channel_0[%arg3, %arg4] (%results_21[] [] []) : (memref<1x1xf32, 2>)
      %8 = air.channel.get async [%async_token_22]  @channel_1[%arg3, %arg4] (%results_23[] [] []) : (memref<1x1xf32, 2>)
      %async_token_24 = air.execute [%8, %7, %async_token_19] {
        linalg.add ins(%results_21, %results_23 : memref<1x1xf32, 2>, memref<1x1xf32, 2>) outs(%results_18 : memref<1x1xf32, 2>)
      }
      %async_token_25 = air.execute [%async_token_24] {
        memref.dealloc %results_21 : memref<1x1xf32, 2>
      }
      %async_token_26 = air.execute [%async_token_24] {
        memref.dealloc %results_23 : memref<1x1xf32, 2>
      }
      %9 = air.channel.put async [%async_token_24]  @channel_2[%arg3, %arg4] (%results_18[] [] []) : (memref<1x1xf32, 2>)
      %async_token_27 = air.execute [%9] {
        memref.dealloc %results_18 : memref<1x1xf32, 2>
      }
    }
    %async_token_13 = air.execute [%6] {
      memref.copy %results, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    }
    %async_token_14 = air.execute [%async_token_13] {
      memref.dealloc %results : memref<2x2xf32>
    }
    return
  }
}
