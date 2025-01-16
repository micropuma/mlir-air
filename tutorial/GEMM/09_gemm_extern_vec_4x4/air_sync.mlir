#map = affine_map<()[s0] -> (s0 * 256)>
#map1 = affine_map<()[s0] -> (s0 * 64)>
#map2 = affine_map<()[s0] -> (s0 * 8)>
module {
  func.func private @linalg_fill_bf16_view16x16x4x4xbf16as2(bf16, memref<16x16x4x4xbf16, 2>) attributes {link_with = "mm.o", llvm.emit_c_interface}
  func.func private @matmul_bf16_bf16(memref<8x16x4x8xbf16, 2>, memref<16x8x8x4xbf16, 2>, memref<16x16x4x4xbf16, 2>) attributes {link_with = "mm.o", llvm.emit_c_interface}
  func.func @matmul_bf16(%arg0: memref<512x1024xbf16>, %arg1: memref<1024x512xbf16>, %arg2: memref<512x512xbf16>) {
    %c2 = arith.constant 2 : index
    air.launch (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%arg2, %arg8=%arg0, %arg9=%arg1) : memref<512x512xbf16>, memref<512x1024xbf16>, memref<1024x512xbf16> {
      air.segment @matmul_bf16_0  args(%arg10=%arg3, %arg11=%arg4, %arg12=%arg7, %arg13=%arg8, %arg14=%arg9) : index, index, memref<512x512xbf16>, memref<512x1024xbf16>, memref<1024x512xbf16> {
        %c512 = arith.constant 512 : index
        %c1 = arith.constant 1 : index
        %c4 = arith.constant 4 : index
        %c0 = arith.constant 0 : index
        %c1024 = arith.constant 1024 : index
        %c256 = arith.constant 256 : index
        %0 = affine.apply #map()[%arg10]
        %1 = affine.apply #map()[%arg11]
        %alloc = memref.alloc() : memref<256x1024xbf16, 1>
        scf.for %arg15 = %c0 to %c1024 step %c256 {
          air.dma_memcpy_nd (%alloc[%c0, %arg15] [%c256, %c256] [%c1024, %c1], %arg13[%0, %arg15] [%c256, %c256] [%c1024, %c1]) {id = 1 : i32} : (memref<256x1024xbf16, 1>, memref<512x1024xbf16>)
        }
        %alloc_0 = memref.alloc() : memref<1024x256xbf16, 1>
        scf.for %arg15 = %c0 to %c1024 step %c256 {
          air.dma_memcpy_nd (%alloc_0[%arg15, %c0] [%c256, %c256] [%c256, %c1], %arg14[%arg15, %1] [%c256, %c256] [%c512, %c1]) {id = 2 : i32} : (memref<1024x256xbf16, 1>, memref<1024x512xbf16>)
        }
        %alloc_1 = memref.alloc() : memref<256x256xbf16, 1>
        air.herd @herd_0  tile (%arg15, %arg16) in (%arg17=%c4, %arg18=%c4) args(%arg19=%alloc_1, %arg20=%alloc, %arg21=%alloc_0) : memref<256x256xbf16, 1>, memref<256x1024xbf16, 1>, memref<1024x256xbf16, 1> attributes {link_with = "mm.o"} {
          %c64 = arith.constant 64 : index
          %c256_2 = arith.constant 256 : index
          %c2048 = arith.constant 2048 : index
          %c4_3 = arith.constant 4 : index
          %c16 = arith.constant 16 : index
          %c1_4 = arith.constant 1 : index
          %c1024_5 = arith.constant 1024 : index
          %c4096 = arith.constant 4096 : index
          %cst = arith.constant 0.000000e+00 : bf16
          %c0_6 = arith.constant 0 : index
          %c128 = arith.constant 128 : index
          %c8 = arith.constant 8 : index
          %2 = affine.apply #map1()[%arg15]
          %3 = affine.apply #map1()[%arg16]
          %alloc_7 = memref.alloc() : memref<16x16x4x4xbf16, 2>
          func.call @linalg_fill_bf16_view16x16x4x4xbf16as2(%cst, %alloc_7) : (bf16, memref<16x16x4x4xbf16, 2>) -> ()
          scf.for %arg22 = %c0_6 to %c128 step %c8 {
            %4 = affine.apply #map2()[%arg22]
            %alloc_8 = memref.alloc() : memref<8x16x4x8xbf16, 2>
            air.dma_memcpy_nd (%alloc_8[] [] [], %arg20[%c0_6, %c0_6, %2, %4] [%c8, %c16, %c4_3, %c8] [%c8, %c4096, %c1024_5, %c1_4]) : (memref<8x16x4x8xbf16, 2>, memref<256x1024xbf16, 1>)
            %alloc_9 = memref.alloc() : memref<16x8x8x4xbf16, 2>
            air.dma_memcpy_nd (%alloc_9[] [] [], %arg21[%c0_6, %c0_6, %4, %3] [%c16, %c8, %c8, %c4_3] [%c4_3, %c2048, %c256_2, %c1_4]) : (memref<16x8x8x4xbf16, 2>, memref<1024x256xbf16, 1>)
            func.call @matmul_bf16_bf16(%alloc_8, %alloc_9, %alloc_7) : (memref<8x16x4x8xbf16, 2>, memref<16x8x8x4xbf16, 2>, memref<16x16x4x4xbf16, 2>) -> ()
            memref.dealloc %alloc_8 : memref<8x16x4x8xbf16, 2>
            memref.dealloc %alloc_9 : memref<16x8x8x4xbf16, 2>
          }
          air.dma_memcpy_nd (%arg19[%2, %3] [%c64, %c64] [%c256_2, %c1_4], %alloc_7[%c0_6, %c0_6, %c0_6, %c0_6] [%c16, %c4_3, %c16, %c4_3] [%c16, %c4_3, %c256_2, %c1_4]) : (memref<256x256xbf16, 1>, memref<16x16x4x4xbf16, 2>)
          memref.dealloc %alloc_7 : memref<16x16x4x4xbf16, 2>
        }
        air.dma_memcpy_nd (%arg12[%0, %1] [%c256, %c256] [%c512, %c1], %alloc_1[] [] []) {id = 3 : i32} : (memref<512x512xbf16>, memref<256x256xbf16, 1>)
        memref.dealloc %alloc : memref<256x1024xbf16, 1>
        memref.dealloc %alloc_0 : memref<1024x256xbf16, 1>
        memref.dealloc %alloc_1 : memref<256x256xbf16, 1>
      }
    }
    return
  }
}
