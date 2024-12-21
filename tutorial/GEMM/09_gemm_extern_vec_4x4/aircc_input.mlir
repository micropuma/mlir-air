#map = affine_map<()[s0] -> (s0 * 256)>
#map1 = affine_map<()[s0] -> (s0 * 256 + 64)>
#map2 = affine_map<()[s0] -> (s0 * 256 + 128)>
#map3 = affine_map<()[s0] -> (s0 * 256 + 192)>
#set = affine_set<()[s0, s1] : (s0 == 0, s1 >= 0, -s1 + 3 >= 0)>
#set1 = affine_set<()[s0, s1] : (s0 - 1 == 0, s1 >= 0, -s1 + 3 >= 0)>
#set2 = affine_set<()[s0, s1] : (s0 - 2 == 0, s1 >= 0, -s1 + 3 >= 0)>
#set3 = affine_set<()[s0, s1] : (s0 >= 0, -s0 + 3 >= 0, s1 == 0)>
#set4 = affine_set<()[s0, s1] : (s0 >= 0, -s0 + 3 >= 0, s1 - 1 == 0)>
#set5 = affine_set<()[s0, s1] : (s0 >= 0, -s0 + 3 >= 0, s1 - 2 == 0)>
module {
  air.channel @channel_0 [1, 1] {broadcast_shape = [1, 4]}
  air.channel @channel_1 [1, 1] {broadcast_shape = [1, 4]}
  air.channel @channel_2 [1, 1] {broadcast_shape = [1, 4]}
  air.channel @channel_3 [1, 1] {broadcast_shape = [1, 4]}
  air.channel @channel_4 [1, 1] {broadcast_shape = [4, 1]}
  air.channel @channel_5 [1, 1] {broadcast_shape = [4, 1]}
  air.channel @channel_6 [1, 1] {broadcast_shape = [4, 1]}
  air.channel @channel_7 [1, 1] {broadcast_shape = [4, 1]}
  air.channel @channel_10 [4, 4]
  air.channel @channel_12 [4, 1]
  air.channel @channel_13 [4, 1]
  air.channel @channel_14 [4, 1]
  func.func private @linalg_fill_bf16_view16x16x4x4xbf16as2(bf16, memref<16x16x4x4xbf16, 2>) attributes {link_with = "mm.o", llvm.emit_c_interface}
  func.func private @matmul_bf16_bf16(memref<8x16x4x8xbf16, 2>, memref<16x8x8x4xbf16, 2>, memref<16x16x4x4xbf16, 2>) attributes {link_with = "mm.o", llvm.emit_c_interface}
  func.func @matmul_bf16(%arg0: memref<512x1024xbf16>, %arg1: memref<1024x512xbf16>, %arg2: memref<512x512xbf16>) {
    %c2 = arith.constant 2 : index
    %0 = air.launch async (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%arg2, %arg8=%arg0, %arg9=%arg1) : memref<512x512xbf16>, memref<512x1024xbf16>, memref<1024x512xbf16> attributes {id = 1 : i32} {
      %c4 = arith.constant 4 : index
      %c3 = arith.constant 3 : index
      %c2_0 = arith.constant 2 : index
      %c64 = arith.constant 64 : index
      %c512 = arith.constant 512 : index
      %c1 = arith.constant 1 : index
      %c0 = arith.constant 0 : index
      %c1024 = arith.constant 1024 : index
      %c256 = arith.constant 256 : index
      %1 = affine.apply #map()[%arg3]
      %2 = affine.apply #map1()[%arg3]
      %3 = affine.apply #map2()[%arg3]
      %4 = affine.apply #map3()[%arg3]
      %5 = air.channel.put async  @channel_12[%c0, %c0] (%arg8[%c0, %1, %c0] [%c4, %c64, %c256] [%c256, %c1024, %c1]) : (memref<512x1024xbf16>)
      %6 = air.channel.put async  @channel_12[%c1, %c0] (%arg8[%c0, %2, %c0] [%c4, %c64, %c256] [%c256, %c1024, %c1]) : (memref<512x1024xbf16>)
      %7 = air.channel.put async  @channel_12[%c2_0, %c0] (%arg8[%c0, %3, %c0] [%c4, %c64, %c256] [%c256, %c1024, %c1]) : (memref<512x1024xbf16>)
      %8 = air.channel.put async  @channel_12[%c3, %c0] (%arg8[%c0, %4, %c0] [%c4, %c64, %c256] [%c256, %c1024, %c1]) : (memref<512x1024xbf16>)
      %9 = affine.apply #map()[%arg4]
      %10 = affine.apply #map1()[%arg4]
      %11 = affine.apply #map2()[%arg4]
      %12 = affine.apply #map3()[%arg4]
      %13 = air.channel.put async  @channel_13[%c0, %c0] (%arg9[%c0, %9] [%c1024, %c64] [%c512, %c1]) : (memref<1024x512xbf16>)
      %14 = air.channel.put async  @channel_13[%c1, %c0] (%arg9[%c0, %10] [%c1024, %c64] [%c512, %c1]) : (memref<1024x512xbf16>)
      %15 = air.channel.put async  @channel_13[%c2_0, %c0] (%arg9[%c0, %11] [%c1024, %c64] [%c512, %c1]) : (memref<1024x512xbf16>)
      %16 = air.channel.put async  @channel_13[%c3, %c0] (%arg9[%c0, %12] [%c1024, %c64] [%c512, %c1]) : (memref<1024x512xbf16>)
      %17 = air.channel.get async  @channel_14[%c0, %c0] (%arg7[%1, %9] [%c64, %c256] [%c512, %c1]) {id = 9 : i32} : (memref<512x512xbf16>)
      %18 = air.channel.get async  @channel_14[%c1, %c0] (%arg7[%2, %9] [%c64, %c256] [%c512, %c1]) {id = 10 : i32} : (memref<512x512xbf16>)
      %19 = air.channel.get async  @channel_14[%c2_0, %c0] (%arg7[%3, %9] [%c64, %c256] [%c512, %c1]) {id = 11 : i32} : (memref<512x512xbf16>)
      %20 = air.channel.get async  @channel_14[%c3, %c0] (%arg7[%4, %9] [%c64, %c256] [%c512, %c1]) {id = 12 : i32} : (memref<512x512xbf16>)
      %21 = air.wait_all async [%17, %18, %19, %20] 
      %22 = air.segment @matmul_bf16_0 async  attributes {id = 2 : i32} {
        %c4096 = arith.constant 4096 : index
        %c32 = arith.constant 32 : index
        %c512_1 = arith.constant 512 : index
        %c3_2 = arith.constant 3 : index
        %c2_3 = arith.constant 2 : index
        %c192 = arith.constant 192 : index
        %c64_4 = arith.constant 64 : index
        %c8 = arith.constant 8 : index
        %c128 = arith.constant 128 : index
        %c16 = arith.constant 16 : index
        %c1_5 = arith.constant 1 : index
        %c4_6 = arith.constant 4 : index
        %c0_7 = arith.constant 0 : index
        %c1024_8 = arith.constant 1024 : index
        %c256_9 = arith.constant 256 : index
        %async_token, %results = air.execute -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_10, %results_11 = air.execute -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_12, %results_13 = air.execute -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_14, %results_15 = air.execute -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_16, %results_17 = air.execute -> (memref<256x64xbf16, 1>) {
          %alloc = memref.alloc() : memref<256x64xbf16, 1>
          air.execute_terminator %alloc : memref<256x64xbf16, 1>
        }
        %async_token_18, %results_19 = air.execute [%async_token_16] -> (memref<256x64xbf16, 1>) {
          %alloc = memref.alloc() : memref<256x64xbf16, 1>
          air.execute_terminator %alloc : memref<256x64xbf16, 1>
        }
        %async_token_20, %results_21 = air.execute [%async_token_18] -> (memref<256x64xbf16, 1>) {
          %alloc = memref.alloc() : memref<256x64xbf16, 1>
          air.execute_terminator %alloc : memref<256x64xbf16, 1>
        }
        %async_token_22, %results_23 = air.execute [%async_token_20] -> (memref<256x64xbf16, 1>) {
          %alloc = memref.alloc() : memref<256x64xbf16, 1>
          air.execute_terminator %alloc : memref<256x64xbf16, 1>
        }
        %async_token_24, %results_25 = air.execute [%async_token_22] -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_26, %results_27 = air.execute [%async_token_24] -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_28, %results_29 = air.execute [%async_token_26] -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_30, %results_31 = air.execute [%async_token_28] -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_32, %results_33 = air.execute [%async_token_30] -> (memref<256x64xbf16, 1>) {
          %alloc = memref.alloc() : memref<256x64xbf16, 1>
          air.execute_terminator %alloc : memref<256x64xbf16, 1>
        }
        %async_token_34, %results_35 = air.execute [%async_token_32] -> (memref<256x64xbf16, 1>) {
          %alloc = memref.alloc() : memref<256x64xbf16, 1>
          air.execute_terminator %alloc : memref<256x64xbf16, 1>
        }
        %async_token_36, %results_37 = air.execute [%async_token_34] -> (memref<256x64xbf16, 1>) {
          %alloc = memref.alloc() : memref<256x64xbf16, 1>
          air.execute_terminator %alloc : memref<256x64xbf16, 1>
        }
        %async_token_38, %results_39 = air.execute [%async_token_36] -> (memref<256x64xbf16, 1>) {
          %alloc = memref.alloc() : memref<256x64xbf16, 1>
          air.execute_terminator %alloc : memref<256x64xbf16, 1>
        }
        %async_token_40, %results_41 = air.execute [%async_token_38] -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_42, %results_43 = air.execute [%async_token_40] -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_44, %results_45 = air.execute [%async_token_42] -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %async_token_46, %results_47 = air.execute [%async_token_42] -> (memref<64x256xbf16, 1>) {
          %alloc = memref.alloc() : memref<64x256xbf16, 1>
          air.execute_terminator %alloc : memref<64x256xbf16, 1>
        }
        %23:4 = scf.for %arg10 = %c0_7 to %c1024_8 step %c512_1 iter_args(%arg11 = %async_token_44, %arg12 = %async_token_46, %arg13 = %async_token_46, %arg14 = %async_token_46) -> (!air.async.token, !air.async.token, !air.async.token, !air.async.token) {
          %46 = air.channel.get async [%arg14, %arg11, %async_token_44]  @channel_12[%c0_7, %c0_7] (%results_45[%c0_7, %arg10] [%c64_4, %c256_9] [%c256_9, %c1_5]) {id = 13 : i32} : (memref<64x256xbf16, 1>)
          %47 = air.channel.get async [%arg14, %arg11, %async_token_46]  @channel_12[%c1_5, %c0_7] (%results_47[%c0_7, %arg10] [%c64_4, %c256_9] [%c256_9, %c1_5]) {id = 14 : i32} : (memref<64x256xbf16, 1>)
          %48 = air.channel.get async [%arg14, %arg11, %async_token_42]  @channel_12[%c2_3, %c0_7] (%results_43[%c0_7, %arg10] [%c64_4, %c256_9] [%c256_9, %c1_5]) {id = 15 : i32} : (memref<64x256xbf16, 1>)
          %49 = air.channel.get async [%arg14, %arg11, %async_token_40]  @channel_12[%c3_2, %c0_7] (%results_41[%c0_7, %arg10] [%c64_4, %c256_9] [%c256_9, %c1_5]) {id = 16 : i32} : (memref<64x256xbf16, 1>)
          %50 = air.channel.get async [%arg14, %arg11, %async_token_38]  @channel_13[%c0_7, %c0_7] (%results_39[%arg10, %c0_7] [%c256_9, %c64_4] [%c64_4, %c1_5]) {id = 17 : i32} : (memref<256x64xbf16, 1>)
          %51 = air.channel.get async [%arg14, %arg11, %async_token_36]  @channel_13[%c1_5, %c0_7] (%results_37[%arg10, %c0_7] [%c256_9, %c64_4] [%c64_4, %c1_5]) {id = 18 : i32} : (memref<256x64xbf16, 1>)
          %52 = air.channel.get async [%arg14, %arg11, %async_token_34]  @channel_13[%c2_3, %c0_7] (%results_35[%arg10, %c0_7] [%c256_9, %c64_4] [%c64_4, %c1_5]) {id = 19 : i32} : (memref<256x64xbf16, 1>)
          %53 = air.channel.get async [%arg14, %arg11, %async_token_32]  @channel_13[%c3_2, %c0_7] (%results_33[%arg10, %c0_7] [%c256_9, %c64_4] [%c64_4, %c1_5]) {id = 20 : i32} : (memref<256x64xbf16, 1>)
          %54 = air.wait_all async [%arg13, %46] 
          %55 = air.channel.put async [%54]  @channel_0[] (%results_45[%c0_7, %c0_7, %c0_7] [%c32, %c64_4, %c8] [%c8, %c256_9, %c1_5]) : (memref<64x256xbf16, 1>)
          %56 = air.wait_all async [%arg13, %47] 
          %57 = air.channel.put async [%56]  @channel_1[] (%results_47[%c0_7, %c0_7, %c0_7] [%c32, %c64_4, %c8] [%c8, %c256_9, %c1_5]) : (memref<64x256xbf16, 1>)
          %58 = air.wait_all async [%arg13, %48] 
          %59 = air.channel.put async [%58]  @channel_2[] (%results_43[%c0_7, %c0_7, %c0_7] [%c32, %c64_4, %c8] [%c8, %c256_9, %c1_5]) : (memref<64x256xbf16, 1>)
          %60 = air.wait_all async [%arg13, %49] 
          %61 = air.channel.put async [%60]  @channel_3[] (%results_41[%c0_7, %c0_7, %c0_7] [%c32, %c64_4, %c8] [%c8, %c256_9, %c1_5]) : (memref<64x256xbf16, 1>)
          %62 = air.wait_all async [%arg13, %50] 
          %63 = air.channel.put async [%62]  @channel_4[] (%results_39[%c0_7, %c0_7, %c0_7, %c0_7] [%c4_6, %c16, %c64_4, %c4_6] [%c4096, %c4_6, %c64_4, %c1_5]) : (memref<256x64xbf16, 1>)
          %64 = air.wait_all async [%arg13, %51] 
          %65 = air.channel.put async [%64]  @channel_5[] (%results_37[%c0_7, %c0_7, %c0_7, %c0_7] [%c4_6, %c16, %c64_4, %c4_6] [%c4096, %c4_6, %c64_4, %c1_5]) : (memref<256x64xbf16, 1>)
          %66 = air.wait_all async [%arg13, %52] 
          %67 = air.channel.put async [%66]  @channel_6[] (%results_35[%c0_7, %c0_7, %c0_7, %c0_7] [%c4_6, %c16, %c64_4, %c4_6] [%c4096, %c4_6, %c64_4, %c1_5]) : (memref<256x64xbf16, 1>)
          %68 = air.wait_all async [%arg13, %53] 
          %69 = air.channel.put async [%68]  @channel_7[] (%results_33[%c0_7, %c0_7, %c0_7, %c0_7] [%c4_6, %c16, %c64_4, %c4_6] [%c4096, %c4_6, %c64_4, %c1_5]) : (memref<256x64xbf16, 1>)
          %async_token_52 = air.execute [%arg14, %arg11] {
            memref.dealloc %results_45 : memref<64x256xbf16, 1>
          }
          %async_token_53 = air.execute [%arg14, %arg11] {
            memref.dealloc %results_47 : memref<64x256xbf16, 1>
          }
          %async_token_54 = air.execute [%arg14, %arg11] {
            memref.dealloc %results_43 : memref<64x256xbf16, 1>
          }
          %async_token_55 = air.execute [%arg14, %arg11] {
            memref.dealloc %results_41 : memref<64x256xbf16, 1>
          }
          %async_token_56 = air.execute [%arg14, %arg11] {
            memref.dealloc %results_39 : memref<256x64xbf16, 1>
          }
          %async_token_57 = air.execute [%arg14, %arg11] {
            memref.dealloc %results_37 : memref<256x64xbf16, 1>
          }
          %async_token_58 = air.execute [%arg14, %arg11] {
            memref.dealloc %results_35 : memref<256x64xbf16, 1>
          }
          %async_token_59 = air.execute [%arg14, %arg11] {
            memref.dealloc %results_33 : memref<256x64xbf16, 1>
          }
          %70 = air.wait_all async [%46, %47, %48, %49, %50, %51, %52, %53, %55, %57, %59, %61, %63, %65, %67, %69, %async_token_52, %async_token_53, %async_token_54, %async_token_55, %async_token_56, %async_token_57, %async_token_58, %async_token_59] 
          %71 = arith.addi %arg10, %c256_9 : index
          %72 = air.channel.get async [%53, %52, %51, %50, %49, %48, %47, %46, %arg12]  @channel_12[%c0_7, %c0_7] (%results_31[%c0_7, %71] [%c64_4, %c256_9] [%c256_9, %c1_5]) {id = 13 : i32} : (memref<64x256xbf16, 1>)
          %73 = air.channel.get async [%53, %52, %51, %50, %49, %48, %47, %46, %arg12]  @channel_12[%c1_5, %c0_7] (%results_29[%c0_7, %71] [%c64_4, %c256_9] [%c256_9, %c1_5]) {id = 14 : i32} : (memref<64x256xbf16, 1>)
          %74 = air.channel.get async [%53, %52, %51, %50, %49, %48, %47, %46, %arg12]  @channel_12[%c2_3, %c0_7] (%results_27[%c0_7, %71] [%c64_4, %c256_9] [%c256_9, %c1_5]) {id = 15 : i32} : (memref<64x256xbf16, 1>)
          %75 = air.channel.get async [%53, %52, %51, %50, %49, %48, %47, %46, %arg12]  @channel_12[%c3_2, %c0_7] (%results_25[%c0_7, %71] [%c64_4, %c256_9] [%c256_9, %c1_5]) {id = 16 : i32} : (memref<64x256xbf16, 1>)
          %76 = air.channel.get async [%53, %52, %51, %50, %49, %48, %47, %46, %arg12]  @channel_13[%c0_7, %c0_7] (%results_23[%71, %c0_7] [%c256_9, %c64_4] [%c64_4, %c1_5]) {id = 17 : i32} : (memref<256x64xbf16, 1>)
          %77 = air.channel.get async [%53, %52, %51, %50, %49, %48, %47, %46, %arg12]  @channel_13[%c1_5, %c0_7] (%results_21[%71, %c0_7] [%c256_9, %c64_4] [%c64_4, %c1_5]) {id = 18 : i32} : (memref<256x64xbf16, 1>)
          %78 = air.channel.get async [%53, %52, %51, %50, %49, %48, %47, %46, %arg12]  @channel_13[%c2_3, %c0_7] (%results_19[%71, %c0_7] [%c256_9, %c64_4] [%c64_4, %c1_5]) {id = 19 : i32} : (memref<256x64xbf16, 1>)
          %79 = air.channel.get async [%53, %52, %51, %50, %49, %48, %47, %46, %arg12]  @channel_13[%c3_2, %c0_7] (%results_17[%71, %c0_7] [%c256_9, %c64_4] [%c64_4, %c1_5]) {id = 20 : i32} : (memref<256x64xbf16, 1>)
          %80 = air.wait_all async [%70, %72] 
          %81 = air.channel.put async [%80]  @channel_0[] (%results_31[%c0_7, %c0_7, %c0_7] [%c32, %c64_4, %c8] [%c8, %c256_9, %c1_5]) : (memref<64x256xbf16, 1>)
          %82 = air.wait_all async [%70, %73] 
          %83 = air.channel.put async [%82]  @channel_1[] (%results_29[%c0_7, %c0_7, %c0_7] [%c32, %c64_4, %c8] [%c8, %c256_9, %c1_5]) : (memref<64x256xbf16, 1>)
          %84 = air.wait_all async [%70, %74] 
          %85 = air.channel.put async [%84]  @channel_2[] (%results_27[%c0_7, %c0_7, %c0_7] [%c32, %c64_4, %c8] [%c8, %c256_9, %c1_5]) : (memref<64x256xbf16, 1>)
          %86 = air.wait_all async [%70, %75] 
          %87 = air.channel.put async [%86]  @channel_3[] (%results_25[%c0_7, %c0_7, %c0_7] [%c32, %c64_4, %c8] [%c8, %c256_9, %c1_5]) : (memref<64x256xbf16, 1>)
          %88 = air.wait_all async [%70, %76] 
          %89 = air.channel.put async [%88]  @channel_4[] (%results_23[%c0_7, %c0_7, %c0_7, %c0_7] [%c4_6, %c16, %c64_4, %c4_6] [%c4096, %c4_6, %c64_4, %c1_5]) : (memref<256x64xbf16, 1>)
          %90 = air.wait_all async [%70, %77] 
          %91 = air.channel.put async [%90]  @channel_5[] (%results_21[%c0_7, %c0_7, %c0_7, %c0_7] [%c4_6, %c16, %c64_4, %c4_6] [%c4096, %c4_6, %c64_4, %c1_5]) : (memref<256x64xbf16, 1>)
          %92 = air.wait_all async [%70, %78] 
          %93 = air.channel.put async [%92]  @channel_6[] (%results_19[%c0_7, %c0_7, %c0_7, %c0_7] [%c4_6, %c16, %c64_4, %c4_6] [%c4096, %c4_6, %c64_4, %c1_5]) : (memref<256x64xbf16, 1>)
          %94 = air.wait_all async [%70, %79] 
          %95 = air.channel.put async [%94]  @channel_7[] (%results_17[%c0_7, %c0_7, %c0_7, %c0_7] [%c4_6, %c16, %c64_4, %c4_6] [%c4096, %c4_6, %c64_4, %c1_5]) : (memref<256x64xbf16, 1>)
          %async_token_60 = air.execute [%53, %52, %51, %50, %49, %48, %47, %46, %arg12] {
            memref.dealloc %results_31 : memref<64x256xbf16, 1>
          }
          %async_token_61 = air.execute [%53, %52, %51, %50, %49, %48, %47, %46, %arg12] {
            memref.dealloc %results_29 : memref<64x256xbf16, 1>
          }
          %async_token_62 = air.execute [%53, %52, %51, %50, %49, %48, %47, %46, %arg12] {
            memref.dealloc %results_27 : memref<64x256xbf16, 1>
          }
          %async_token_63 = air.execute [%53, %52, %51, %50, %49, %48, %47, %46, %arg12] {
            memref.dealloc %results_25 : memref<64x256xbf16, 1>
          }
          %async_token_64 = air.execute [%53, %52, %51, %50, %49, %48, %47, %46, %arg12] {
            memref.dealloc %results_23 : memref<256x64xbf16, 1>
          }
          %async_token_65 = air.execute [%53, %52, %51, %50, %49, %48, %47, %46, %arg12] {
            memref.dealloc %results_21 : memref<256x64xbf16, 1>
          }
          %async_token_66 = air.execute [%53, %52, %51, %50, %49, %48, %47, %46, %arg12] {
            memref.dealloc %results_19 : memref<256x64xbf16, 1>
          }
          %async_token_67 = air.execute [%53, %52, %51, %50, %49, %48, %47, %46, %arg12] {
            memref.dealloc %results_17 : memref<256x64xbf16, 1>
          }
          %96 = air.wait_all async [%72, %73, %74, %75, %76, %77, %78, %79, %81, %83, %85, %87, %89, %91, %93, %95, %async_token_60, %async_token_61, %async_token_62, %async_token_63, %async_token_64, %async_token_65, %async_token_66, %async_token_67] 
          %97 = air.wait_all async [%72, %73, %74, %75, %76, %77, %78, %79] 
          scf.yield %70, %96, %96, %97 : !air.async.token, !air.async.token, !air.async.token, !air.async.token
        }
        %24 = air.channel.get async  @channel_10[%c0_7, %c0_7] (%results[%c0_7, %c0_7] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 29 : i32} : (memref<64x256xbf16, 1>)
        %25 = air.channel.get async  @channel_10[%c1_5, %c0_7] (%results_11[%c0_7, %c0_7] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 30 : i32} : (memref<64x256xbf16, 1>)
        %26 = air.channel.get async  @channel_10[%c2_3, %c0_7] (%results_13[%c0_7, %c0_7] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 31 : i32} : (memref<64x256xbf16, 1>)
        %27 = air.channel.get async  @channel_10[%c3_2, %c0_7] (%results_15[%c0_7, %c0_7] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 32 : i32} : (memref<64x256xbf16, 1>)
        %28 = air.channel.get async  @channel_10[%c0_7, %c1_5] (%results[%c0_7, %c64_4] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 33 : i32} : (memref<64x256xbf16, 1>)
        %29 = air.channel.get async  @channel_10[%c1_5, %c1_5] (%results_11[%c0_7, %c64_4] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 34 : i32} : (memref<64x256xbf16, 1>)
        %30 = air.channel.get async  @channel_10[%c2_3, %c1_5] (%results_13[%c0_7, %c64_4] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 35 : i32} : (memref<64x256xbf16, 1>)
        %31 = air.channel.get async  @channel_10[%c3_2, %c1_5] (%results_15[%c0_7, %c64_4] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 36 : i32} : (memref<64x256xbf16, 1>)
        %32 = air.channel.get async  @channel_10[%c0_7, %c2_3] (%results[%c0_7, %c128] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 37 : i32} : (memref<64x256xbf16, 1>)
        %33 = air.channel.get async  @channel_10[%c1_5, %c2_3] (%results_11[%c0_7, %c128] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 38 : i32} : (memref<64x256xbf16, 1>)
        %34 = air.channel.get async  @channel_10[%c2_3, %c2_3] (%results_13[%c0_7, %c128] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 39 : i32} : (memref<64x256xbf16, 1>)
        %35 = air.channel.get async  @channel_10[%c3_2, %c2_3] (%results_15[%c0_7, %c128] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 40 : i32} : (memref<64x256xbf16, 1>)
        %36 = air.channel.get async  @channel_10[%c0_7, %c3_2] (%results[%c0_7, %c192] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 41 : i32} : (memref<64x256xbf16, 1>)
        %37 = air.channel.get async  @channel_10[%c1_5, %c3_2] (%results_11[%c0_7, %c192] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 42 : i32} : (memref<64x256xbf16, 1>)
        %38 = air.channel.get async  @channel_10[%c2_3, %c3_2] (%results_13[%c0_7, %c192] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 43 : i32} : (memref<64x256xbf16, 1>)
        %39 = air.channel.get async  @channel_10[%c3_2, %c3_2] (%results_15[%c0_7, %c192] [%c64_4, %c64_4] [%c256_9, %c1_5]) {id = 44 : i32} : (memref<64x256xbf16, 1>)
        %40 = air.herd @herd_0 async [%23#1]  tile (%arg10, %arg11) in (%arg12=%c4_6, %arg13=%c4_6) attributes {id = 3 : i32, link_with = "mm.o"} {
          %c64_52 = arith.constant 64 : index
          %c256_53 = arith.constant 256 : index
          %c4_54 = arith.constant 4 : index
          %c16_55 = arith.constant 16 : index
          %c1_56 = arith.constant 1 : index
          %cst = arith.constant 0.000000e+00 : bf16
          %c0_57 = arith.constant 0 : index
          %c128_58 = arith.constant 128 : index
          %async_token_59, %results_60 = air.execute -> (memref<16x16x4x4xbf16, 2>) {
            %alloc = memref.alloc() : memref<16x16x4x4xbf16, 2>
            air.execute_terminator %alloc : memref<16x16x4x4xbf16, 2>
          }
          %async_token_61 = air.execute [%async_token_59] {
            func.call @linalg_fill_bf16_view16x16x4x4xbf16as2(%cst, %results_60) : (bf16, memref<16x16x4x4xbf16, 2>) -> ()
          }
          %async_token_62, %results_63 = air.execute [%async_token_61] -> (memref<16x8x8x4xbf16, 2>) {
            %alloc = memref.alloc() : memref<16x8x8x4xbf16, 2>
            air.execute_terminator %alloc : memref<16x8x8x4xbf16, 2>
          }
          %async_token_64, %results_65 = air.execute [%async_token_62] -> (memref<8x16x4x8xbf16, 2>) {
            %alloc = memref.alloc() : memref<8x16x4x8xbf16, 2>
            air.execute_terminator %alloc : memref<8x16x4x8xbf16, 2>
          }
          %async_token_66, %results_67 = air.execute [%async_token_64] -> (memref<8x16x4x8xbf16, 2>) {
            %alloc = memref.alloc() : memref<8x16x4x8xbf16, 2>
            air.execute_terminator %alloc : memref<8x16x4x8xbf16, 2>
          }
          %async_token_68, %results_69 = air.execute [%async_token_64] -> (memref<16x8x8x4xbf16, 2>) {
            %alloc = memref.alloc() : memref<16x8x8x4xbf16, 2>
            air.execute_terminator %alloc : memref<16x8x8x4xbf16, 2>
          }
          %46:3 = scf.for %arg14 = %c0_57 to %c128_58 step %c16_55 iter_args(%arg15 = %async_token_66, %arg16 = %async_token_68, %arg17 = %async_token_68) -> (!air.async.token, !air.async.token, !air.async.token) {
            %48 = affine.if #set()[%arg10, %arg11] -> !air.async.token {
              %53 = air.channel.get async [%arg17, %arg15, %async_token_66]  @channel_0[%arg10, %arg11] (%results_67[] [] []) {id = 45 : i32} : (memref<8x16x4x8xbf16, 2>)
              affine.yield %53 : !air.async.token
            } else {
              %53 = affine.if #set1()[%arg10, %arg11] -> !air.async.token {
                %54 = air.channel.get async [%arg17, %arg15, %async_token_66]  @channel_1[%arg10, %arg11] (%results_67[] [] []) {id = 46 : i32} : (memref<8x16x4x8xbf16, 2>)
                affine.yield %54 : !air.async.token
              } else {
                %54 = affine.if #set2()[%arg10, %arg11] -> !air.async.token {
                  %55 = air.channel.get async [%arg17, %arg15, %async_token_66]  @channel_2[%arg10, %arg11] (%results_67[] [] []) {id = 47 : i32} : (memref<8x16x4x8xbf16, 2>)
                  affine.yield %55 : !air.async.token
                } else {
                  %55 = air.channel.get async [%arg17, %arg15, %async_token_66]  @channel_3[%arg10, %arg11] (%results_67[] [] []) {id = 48 : i32} : (memref<8x16x4x8xbf16, 2>)
                  affine.yield %55 : !air.async.token
                }
                affine.yield %54 : !air.async.token
              }
              affine.yield %53 : !air.async.token
            }
            %49 = affine.if #set3()[%arg10, %arg11] -> !air.async.token {
              %53 = air.channel.get async [%arg17, %arg15, %async_token_68]  @channel_4[%arg10, %arg11] (%results_69[] [] []) {id = 49 : i32} : (memref<16x8x8x4xbf16, 2>)
              affine.yield %53 : !air.async.token
            } else {
              %53 = affine.if #set4()[%arg10, %arg11] -> !air.async.token {
                %54 = air.channel.get async [%arg17, %arg15, %async_token_68]  @channel_5[%arg10, %arg11] (%results_69[] [] []) {id = 50 : i32} : (memref<16x8x8x4xbf16, 2>)
                affine.yield %54 : !air.async.token
              } else {
                %54 = affine.if #set5()[%arg10, %arg11] -> !air.async.token {
                  %55 = air.channel.get async [%arg17, %arg15, %async_token_68]  @channel_6[%arg10, %arg11] (%results_69[] [] []) {id = 51 : i32} : (memref<16x8x8x4xbf16, 2>)
                  affine.yield %55 : !air.async.token
                } else {
                  %55 = air.channel.get async [%arg17, %arg15, %async_token_68]  @channel_7[%arg10, %arg11] (%results_69[] [] []) {id = 52 : i32} : (memref<16x8x8x4xbf16, 2>)
                  affine.yield %55 : !air.async.token
                }
                affine.yield %54 : !air.async.token
              }
              affine.yield %53 : !air.async.token
            }
            %async_token_71 = air.execute [%49, %48] {
              func.call @matmul_bf16_bf16(%results_67, %results_69, %results_60) : (memref<8x16x4x8xbf16, 2>, memref<16x8x8x4xbf16, 2>, memref<16x16x4x4xbf16, 2>) -> ()
            }
            %async_token_72 = air.execute {
              memref.dealloc %results_67 : memref<8x16x4x8xbf16, 2>
            }
            %async_token_73 = air.execute {
              memref.dealloc %results_69 : memref<16x8x8x4xbf16, 2>
            }
            %50 = affine.if #set()[%arg10, %arg11] -> !air.async.token {
              %53 = air.channel.get async [%49, %48, %arg16]  @channel_0[%arg10, %arg11] (%results_65[] [] []) {id = 45 : i32} : (memref<8x16x4x8xbf16, 2>)
              affine.yield %53 : !air.async.token
            } else {
              %53 = affine.if #set1()[%arg10, %arg11] -> !air.async.token {
                %54 = air.channel.get async [%49, %48, %arg16]  @channel_1[%arg10, %arg11] (%results_65[] [] []) {id = 46 : i32} : (memref<8x16x4x8xbf16, 2>)
                affine.yield %54 : !air.async.token
              } else {
                %54 = affine.if #set2()[%arg10, %arg11] -> !air.async.token {
                  %55 = air.channel.get async [%49, %48, %arg16]  @channel_2[%arg10, %arg11] (%results_65[] [] []) {id = 47 : i32} : (memref<8x16x4x8xbf16, 2>)
                  affine.yield %55 : !air.async.token
                } else {
                  %55 = air.channel.get async [%49, %48, %arg16]  @channel_3[%arg10, %arg11] (%results_65[] [] []) {id = 48 : i32} : (memref<8x16x4x8xbf16, 2>)
                  affine.yield %55 : !air.async.token
                }
                affine.yield %54 : !air.async.token
              }
              affine.yield %53 : !air.async.token
            }
            %51 = affine.if #set3()[%arg10, %arg11] -> !air.async.token {
              %53 = air.channel.get async [%49, %48, %arg16]  @channel_4[%arg10, %arg11] (%results_63[] [] []) {id = 49 : i32} : (memref<16x8x8x4xbf16, 2>)
              affine.yield %53 : !air.async.token
            } else {
              %53 = affine.if #set4()[%arg10, %arg11] -> !air.async.token {
                %54 = air.channel.get async [%49, %48, %arg16]  @channel_5[%arg10, %arg11] (%results_63[] [] []) {id = 50 : i32} : (memref<16x8x8x4xbf16, 2>)
                affine.yield %54 : !air.async.token
              } else {
                %54 = affine.if #set5()[%arg10, %arg11] -> !air.async.token {
                  %55 = air.channel.get async [%49, %48, %arg16]  @channel_6[%arg10, %arg11] (%results_63[] [] []) {id = 51 : i32} : (memref<16x8x8x4xbf16, 2>)
                  affine.yield %55 : !air.async.token
                } else {
                  %55 = air.channel.get async [%49, %48, %arg16]  @channel_7[%arg10, %arg11] (%results_63[] [] []) {id = 52 : i32} : (memref<16x8x8x4xbf16, 2>)
                  affine.yield %55 : !air.async.token
                }
                affine.yield %54 : !air.async.token
              }
              affine.yield %53 : !air.async.token
            }
            %async_token_74 = air.execute [%51, %50] {
              func.call @matmul_bf16_bf16(%results_65, %results_63, %results_60) : (memref<8x16x4x8xbf16, 2>, memref<16x8x8x4xbf16, 2>, memref<16x16x4x4xbf16, 2>) -> ()
            }
            %async_token_75 = air.execute {
              memref.dealloc %results_65 : memref<8x16x4x8xbf16, 2>
            }
            %async_token_76 = air.execute {
              memref.dealloc %results_63 : memref<16x8x8x4xbf16, 2>
            }
            %52 = air.wait_all async [%50, %51] 
            scf.yield %async_token_71, %async_token_74, %52 : !air.async.token, !air.async.token, !air.async.token
          }
          %47 = air.channel.put async [%46#1]  @channel_10[%arg10, %arg11] (%results_60[%c0_57, %c0_57, %c0_57] [%c64_52, %c16_55, %c4_54] [%c4_54, %c256_53, %c1_56]) : (memref<16x16x4x4xbf16, 2>)
          %async_token_70 = air.execute [%47] {
            memref.dealloc %results_60 : memref<16x16x4x4xbf16, 2>
          }
        }
        %41 = air.channel.put async [%40]  @channel_14[%c0_7, %c0_7] (%results[] [] []) : (memref<64x256xbf16, 1>)
        %42 = air.channel.put async [%40]  @channel_14[%c1_5, %c0_7] (%results_11[] [] []) : (memref<64x256xbf16, 1>)
        %43 = air.channel.put async [%40]  @channel_14[%c2_3, %c0_7] (%results_13[] [] []) : (memref<64x256xbf16, 1>)
        %44 = air.channel.put async [%40]  @channel_14[%c3_2, %c0_7] (%results_15[] [] []) : (memref<64x256xbf16, 1>)
        %45 = air.wait_all async [%41, %42, %43, %44] 
        %async_token_48 = air.execute [%45] {
          memref.dealloc %results_15 : memref<64x256xbf16, 1>
        }
        %async_token_49 = air.execute [%45] {
          memref.dealloc %results_13 : memref<64x256xbf16, 1>
        }
        %async_token_50 = air.execute [%45] {
          memref.dealloc %results_11 : memref<64x256xbf16, 1>
        }
        %async_token_51 = air.execute [%45] {
          memref.dealloc %results : memref<64x256xbf16, 1>
        }
      }
    }
    return
  }
}
