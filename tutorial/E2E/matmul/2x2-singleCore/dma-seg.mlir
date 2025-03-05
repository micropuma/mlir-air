#map = affine_map<()[s0] -> (s0 * 32)>
#set = affine_set<()[s0, s1] : (s0 == 0, s1 >= 0, -s1 + 1 >= 0)>
#set1 = affine_set<()[s0, s1] : (s0 - 1 == 0, s1 >= 0, -s1 + 1 >= 0)>
#set2 = affine_set<()[s0, s1] : (s0 >= 0, -s0 + 1 >= 0, s1 == 0)>
#set3 = affine_set<()[s0, s1] : (s0 >= 0, -s0 + 1 >= 0, s1 - 1 == 0)>
module {
  func.func @forward(%arg0: memref<64x64xi32>, %arg1: memref<64x64xi32>, %arg2: memref<64x64xi32>) {
    %c1 = arith.constant 1 : index
    %async_token, %results = air.execute -> (memref<64x64xi32>) {
      %alloc = memref.alloc() : memref<64x64xi32>
      air.execute_terminator %alloc : memref<64x64xi32>
    }
    %0 = air.launch async [%async_token] (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) args(%arg7=%results, %arg8=%arg0, %arg9=%arg1) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> attributes {id = 1 : i32} {
      %1 = air.segment @segment_0 async  args(%arg10=%arg7, %arg11=%arg8, %arg12=%arg9) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> attributes {id = 2 : i32} {
        %c2 = arith.constant 2 : index
        %2 = air.herd @herd_0 async  tile (%arg13, %arg14) in (%arg15=%c2, %arg16=%c2) args(%arg17=%arg10, %arg18=%arg11, %arg19=%arg12) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> attributes {id = 3 : i32} {
          %c1_1 = arith.constant 1 : index
          %c0_i32 = arith.constant 0 : i32
          %c0 = arith.constant 0 : index
          %c64 = arith.constant 64 : index
          %c32 = arith.constant 32 : index
          %async_token_2, %results_3 = air.execute -> (index) {
            %6 = affine.apply #map()[%arg13]
            air.execute_terminator %6 : index
          }
          %async_token_4, %results_5 = air.execute -> (index) {
            %6 = affine.apply #map()[%arg14]
            air.execute_terminator %6 : index
          }
          %async_token_6, %results_7 = air.execute -> (memref<32x32xi32, 2>) {
            %alloc = memref.alloc() : memref<32x32xi32, 2>
            air.execute_terminator %alloc : memref<32x32xi32, 2>
          }
          %async_token_8 = air.execute [%async_token_6] {
            scf.for %arg20 = %c0 to %c32 step %c1_1 {
              scf.for %arg21 = %c0 to %c32 step %c1_1 {
                memref.store %c0_i32, %results_7[%arg20, %arg21] : memref<32x32xi32, 2>
              }
            }
          }
          %3 = air.wait_all async [%async_token_2, %async_token_4, %async_token_8] 
          %4 = scf.for %arg20 = %c0 to %c64 step %c32 iter_args(%arg21 = %3) -> (!air.async.token) {
            %async_token_10, %results_11 = air.execute -> (memref<32x32xi32, 2>) {
              %alloc = memref.alloc() : memref<32x32xi32, 2>
              air.execute_terminator %alloc : memref<32x32xi32, 2>
            }
            %async_token_12, %results_13 = air.execute -> (memref<32x32xi32, 2>) {
              %alloc = memref.alloc() : memref<32x32xi32, 2>
              air.execute_terminator %alloc : memref<32x32xi32, 2>
            }
            %6 = affine.if #set()[%arg13, %arg14] -> !air.async.token {
              %8 = air.dma_memcpy_nd async [%arg21, %async_token_10] (%results_11[] [] [], %arg18[%c0, %arg20] [%c32, %c32] [%c64, %c1_1]) {broadcast_set = #set, id = 1 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
              affine.yield %8 : !air.async.token
            } else {
              %8 = air.dma_memcpy_nd async [%arg21, %async_token_10] (%results_11[] [] [], %arg18[%c32, %arg20] [%c32, %c32] [%c64, %c1_1]) {broadcast_set = #set1, id = 2 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
              affine.yield %8 : !air.async.token
            }
            %7 = affine.if #set2()[%arg13, %arg14] -> !air.async.token {
              %8 = air.dma_memcpy_nd async [%arg21, %async_token_12] (%results_13[] [] [], %arg19[%arg20, %c0] [%c32, %c32] [%c64, %c1_1]) {broadcast_set = #set2, id = 3 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
              affine.yield %8 : !air.async.token
            } else {
              %8 = air.dma_memcpy_nd async [%arg21, %async_token_12] (%results_13[] [] [], %arg19[%arg20, %c32] [%c32, %c32] [%c64, %c1_1]) {broadcast_set = #set3, id = 4 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
              affine.yield %8 : !air.async.token
            }
            %async_token_14 = air.execute [%7, %6] {
              scf.for %arg22 = %c0 to %c32 step %c1_1 {
                scf.for %arg23 = %c0 to %c32 step %c1_1 {
                  scf.for %arg24 = %c0 to %c32 step %c1_1 {
                    %8 = memref.load %results_11[%arg22, %arg24] : memref<32x32xi32, 2>
                    %9 = memref.load %results_13[%arg24, %arg23] : memref<32x32xi32, 2>
                    %10 = memref.load %results_7[%arg22, %arg23] : memref<32x32xi32, 2>
                    %11 = arith.muli %8, %9 : i32
                    %12 = arith.addi %10, %11 : i32
                    memref.store %12, %results_7[%arg22, %arg23] : memref<32x32xi32, 2>
                  }
                }
              }
            }
            %async_token_15 = air.execute [%async_token_14] {
              memref.dealloc %results_11 : memref<32x32xi32, 2>
            }
            %async_token_16 = air.execute [%async_token_14] {
              memref.dealloc %results_13 : memref<32x32xi32, 2>
            }
            scf.yield %async_token_14 : !air.async.token
          }
          %5 = air.dma_memcpy_nd async [%4] (%arg17[%results_3, %results_5] [%c32, %c32] [%c64, %c1_1], %results_7[] [] []) {id = 5 : i32} : (memref<64x64xi32>, memref<32x32xi32, 2>)
          %async_token_9 = air.execute [%5] {
            memref.dealloc %results_7 : memref<32x32xi32, 2>
          }
        }
      }
    }
    %async_token_0 = air.execute [%0] {
      memref.copy %results, %arg2 : memref<64x64xi32> to memref<64x64xi32>
    }
    return
  }
}
