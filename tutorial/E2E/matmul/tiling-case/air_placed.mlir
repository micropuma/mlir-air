#map = affine_map<()[s0] -> (s0 * 32)>
#set = affine_set<()[s0, s1] : (s0 == 0, s1 >= 0, -s1 + 1 >= 0)>
#set1 = affine_set<()[s0, s1] : (s0 - 1 == 0, s1 >= 0, -s1 + 1 >= 0)>
#set2 = affine_set<()[s0, s1] : (s0 >= 0, -s0 + 1 >= 0, s1 == 0)>
#set3 = affine_set<()[s0, s1] : (s0 >= 0, -s0 + 1 >= 0, s1 - 1 == 0)>
module {
  func.func private @linalg_fill_i32_view32x32xi32as2(i32, memref<32x32xi32, 2>) attributes {link_with = "mm.o", llvm.emit_c_interface}
  func.func private @linalg_matmul_view32x32xi32as2_view32x32xi32as2_view32x32xi32as2(memref<32x32xi32, 2>, memref<32x32xi32, 2>, memref<32x32xi32, 2>) attributes {link_with = "mm.o", llvm.emit_c_interface}
  func.func @forward(%arg0: memref<64x64xi32>, %arg1: memref<64x64xi32>, %arg2: memref<64x64xi32>) {
    %c1 = arith.constant 1 : index
    %async_token, %results = air.execute -> (memref<64x64xi32>) {
      %alloc = memref.alloc() : memref<64x64xi32>
      air.execute_terminator %alloc : memref<64x64xi32>
    }
    %0 = air.launch async [%async_token] (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) args(%arg7=%results, %arg8=%arg0, %arg9=%arg1) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> attributes {id = 1 : i32} {
      %1 = air.segment @segment_0 async  args(%arg10=%arg7, %arg11=%arg8, %arg12=%arg9) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> attributes {id = 2 : i32, x_loc = 7 : i64, x_size = 10 : i64, y_loc = 2 : i64, y_size = 6 : i64} {
        %c1_1 = arith.constant 1 : index
        %c4 = arith.constant 4 : index
        %2 = air.herd @herd_0 async  tile (%arg13, %arg14) in (%arg15=%c1_1, %arg16=%c4) args(%arg17=%arg10, %arg18=%arg11, %arg19=%arg12) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> attributes {id = 3 : i32, x_loc = 7 : i64, y_loc = 2 : i64} {
          %c32 = arith.constant 32 : index
          %c64 = arith.constant 64 : index
          %c0 = arith.constant 0 : index
          %c0_i32 = arith.constant 0 : i32
          %c1_2 = arith.constant 1 : index
          %c2 = arith.constant 2 : index
          %3 = arith.remsi %arg14, %c2 : index
          %4 = arith.divsi %arg14, %c2 : index
          %async_token_3, %results_4 = air.execute -> (index) {
            %8 = affine.apply #map()[%4]
            air.execute_terminator %8 : index
          }
          %async_token_5, %results_6 = air.execute -> (index) {
            %8 = affine.apply #map()[%3]
            air.execute_terminator %8 : index
          }
          %async_token_7, %results_8 = air.execute -> (memref<32x32xi32, 2>) {
            %alloc = memref.alloc() : memref<32x32xi32, 2>
            air.execute_terminator %alloc : memref<32x32xi32, 2>
          }
          %async_token_9 = air.execute [%async_token_7] {
            func.call @linalg_fill_i32_view32x32xi32as2(%c0_i32, %results_8) : (i32, memref<32x32xi32, 2>) -> ()
          }
          %5 = air.wait_all async [%async_token_3, %async_token_5, %async_token_9] 
          %6 = scf.for %arg20 = %c0 to %c64 step %c32 iter_args(%arg21 = %5) -> (!air.async.token) {
            %async_token_11, %results_12 = air.execute -> (memref<32x32xi32, 2>) {
              %alloc = memref.alloc() : memref<32x32xi32, 2>
              air.execute_terminator %alloc : memref<32x32xi32, 2>
            }
            %async_token_13, %results_14 = air.execute -> (memref<32x32xi32, 2>) {
              %alloc = memref.alloc() : memref<32x32xi32, 2>
              air.execute_terminator %alloc : memref<32x32xi32, 2>
            }
            %8 = affine.if #set()[%4, %3] -> !air.async.token {
              %10 = air.dma_memcpy_nd async [%arg21, %async_token_11] (%results_12[] [] [], %arg18[%c0, %arg20] [%c32, %c32] [%c64, %c1_2]) {broadcast_set = #set, id = 1 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
              affine.yield %10 : !air.async.token
            } else {
              %10 = air.dma_memcpy_nd async [%arg21, %async_token_11] (%results_12[] [] [], %arg18[%c32, %arg20] [%c32, %c32] [%c64, %c1_2]) {broadcast_set = #set1, id = 2 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
              affine.yield %10 : !air.async.token
            }
            %9 = affine.if #set2()[%4, %3] -> !air.async.token {
              %10 = air.dma_memcpy_nd async [%arg21, %async_token_13] (%results_14[] [] [], %arg19[%arg20, %c0] [%c32, %c32] [%c64, %c1_2]) {broadcast_set = #set2, id = 3 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
              affine.yield %10 : !air.async.token
            } else {
              %10 = air.dma_memcpy_nd async [%arg21, %async_token_13] (%results_14[] [] [], %arg19[%arg20, %c32] [%c32, %c32] [%c64, %c1_2]) {broadcast_set = #set3, id = 4 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
              affine.yield %10 : !air.async.token
            }
            %async_token_15 = air.execute [%9, %8] {
              func.call @linalg_matmul_view32x32xi32as2_view32x32xi32as2_view32x32xi32as2(%results_12, %results_14, %results_8) : (memref<32x32xi32, 2>, memref<32x32xi32, 2>, memref<32x32xi32, 2>) -> ()
            }
            %async_token_16 = air.execute [%async_token_15] {
              memref.dealloc %results_12 : memref<32x32xi32, 2>
            }
            %async_token_17 = air.execute [%async_token_15] {
              memref.dealloc %results_14 : memref<32x32xi32, 2>
            }
            scf.yield %async_token_15 : !air.async.token
          }
          %7 = air.dma_memcpy_nd async [%6] (%arg17[%results_4, %results_6] [%c32, %c32] [%c64, %c1_2], %results_8[] [] []) {id = 5 : i32} : (memref<64x64xi32>, memref<32x32xi32, 2>)
          %async_token_10 = air.execute [%7] {
            memref.dealloc %results_8 : memref<32x32xi32, 2>
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
