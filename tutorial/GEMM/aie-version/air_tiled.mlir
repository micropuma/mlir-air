#map = affine_map<()[s0] -> (s0 * 256)>
#map1 = affine_map<()[s0] -> (s0 * 64)>
#map2 = affine_map<()[s0] -> (s0 * 8)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d2, d0, d3, d5)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d1, d2, d5, d4)>
#map5 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d1, d0, d3, d4)>
module {
  func.func @matmul_bf16(%arg0: memref<512x1024xbf16>, %arg1: memref<1024x512xbf16>, %arg2: memref<512x512xbf16>) {
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c8 = arith.constant 8 : index
    %c128 = arith.constant 128 : index
    %c256 = arith.constant 256 : index
    %c1024 = arith.constant 1024 : index
    %cst = arith.constant 0.000000e+00 : bf16
    %c0 = arith.constant 0 : index
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c2, %c2) step (%c1, %c1) {
      %0 = affine.apply #map()[%arg3]
      %1 = affine.apply #map()[%arg4]
      %subview = memref.subview %arg2[%0, %1] [256, 256] [1, 1] : memref<512x512xbf16> to memref<256x256xbf16, strided<[512, 1], offset: ?>>
      %alloc = memref.alloc() : memref<256x1024xbf16, 1>
      scf.for %arg5 = %c0 to %c1024 step %c256 {
        %2 = affine.apply #map()[%arg3]
        %subview_2 = memref.subview %arg0[%2, %arg5] [256, 256] [1, 1] : memref<512x1024xbf16> to memref<256x256xbf16, strided<[1024, 1], offset: ?>>
        %subview_3 = memref.subview %alloc[0, %arg5] [256, 256] [1, 1] : memref<256x1024xbf16, 1> to memref<256x256xbf16, strided<[1024, 1], offset: ?>, 1>
        memref.copy %subview_2, %subview_3 : memref<256x256xbf16, strided<[1024, 1], offset: ?>> to memref<256x256xbf16, strided<[1024, 1], offset: ?>, 1>
      }
      %alloc_0 = memref.alloc() : memref<1024x256xbf16, 1>
      scf.for %arg5 = %c0 to %c1024 step %c256 {
        %2 = affine.apply #map()[%arg4]
        %subview_2 = memref.subview %arg1[%arg5, %2] [256, 256] [1, 1] : memref<1024x512xbf16> to memref<256x256xbf16, strided<[512, 1], offset: ?>>
        %subview_3 = memref.subview %alloc_0[%arg5, 0] [256, 256] [1, 1] : memref<1024x256xbf16, 1> to memref<256x256xbf16, strided<[256, 1], offset: ?>, 1>
        memref.copy %subview_2, %subview_3 : memref<256x256xbf16, strided<[512, 1], offset: ?>> to memref<256x256xbf16, strided<[256, 1], offset: ?>, 1>
      }
      %alloc_1 = memref.alloc() : memref<256x256xbf16, 1>
      scf.parallel (%arg5, %arg6) = (%c0, %c0) to (%c4, %c4) step (%c1, %c1) {
        %2 = affine.apply #map1()[%arg5]
        %3 = affine.apply #map1()[%arg6]
        %subview_2 = memref.subview %alloc_1[%2, %3] [64, 64] [1, 1] : memref<256x256xbf16, 1> to memref<64x64xbf16, strided<[256, 1], offset: ?>, 1>
        %alloc_3 = memref.alloc() : memref<16x16x4x4xbf16, 2>
        linalg.fill ins(%cst : bf16) outs(%alloc_3 : memref<16x16x4x4xbf16, 2>)
        scf.for %arg7 = %c0 to %c128 step %c8 {
          %4 = affine.apply #map1()[%arg5]
          %5 = affine.apply #map2()[%arg7]
          %subview_4 = memref.subview %alloc[%4, %5] [64, 64] [1, 1] : memref<256x1024xbf16, 1> to memref<64x64xbf16, strided<[1024, 1], offset: ?>, 1>
          %alloc_5 = memref.alloc() : memref<8x16x4x8xbf16, 2>
          %expand_shape = memref.expand_shape %subview_4 [[0, 1], [2, 3]] output_shape [16, 4, 8, 8] : memref<64x64xbf16, strided<[1024, 1], offset: ?>, 1> into memref<16x4x8x8xbf16, strided<[4096, 1024, 8, 1], offset: ?>, 1>
          %transpose_6 = memref.transpose %expand_shape (d0, d1, d2, d3) -> (d2, d0, d1, d3) : memref<16x4x8x8xbf16, strided<[4096, 1024, 8, 1], offset: ?>, 1> to memref<8x16x4x8xbf16, strided<[8, 4096, 1024, 1], offset: ?>, 1>
          air.dma_memcpy_nd (%alloc_5[] [] [], %transpose_6[] [] []) : (memref<8x16x4x8xbf16, 2>, memref<8x16x4x8xbf16, strided<[8, 4096, 1024, 1], offset: ?>, 1>)
          %6 = affine.apply #map2()[%arg7]
          %7 = affine.apply #map1()[%arg6]
          %subview_7 = memref.subview %alloc_0[%6, %7] [64, 64] [1, 1] : memref<1024x256xbf16, 1> to memref<64x64xbf16, strided<[256, 1], offset: ?>, 1>
          %alloc_8 = memref.alloc() : memref<16x8x8x4xbf16, 2>
          %expand_shape_9 = memref.expand_shape %subview_7 [[0, 1], [2, 3]] output_shape [8, 8, 16, 4] : memref<64x64xbf16, strided<[256, 1], offset: ?>, 1> into memref<8x8x16x4xbf16, strided<[2048, 256, 4, 1], offset: ?>, 1>
          %transpose_10 = memref.transpose %expand_shape_9 (d0, d1, d2, d3) -> (d2, d0, d1, d3) : memref<8x8x16x4xbf16, strided<[2048, 256, 4, 1], offset: ?>, 1> to memref<16x8x8x4xbf16, strided<[4, 2048, 256, 1], offset: ?>, 1>
          air.dma_memcpy_nd (%alloc_8[] [] [], %transpose_10[] [] []) : (memref<16x8x8x4xbf16, 2>, memref<16x8x8x4xbf16, strided<[4, 2048, 256, 1], offset: ?>, 1>)
          linalg.generic {indexing_maps = [#map3, #map4, #map5], iterator_types = ["parallel", "parallel", "reduction", "parallel", "parallel", "reduction"], library_call = "matmul_bf16_bf16"} ins(%alloc_5, %alloc_8 : memref<8x16x4x8xbf16, 2>, memref<16x8x8x4xbf16, 2>) outs(%alloc_3 : memref<16x16x4x4xbf16, 2>) {
          ^bb0(%in: bf16, %in_11: bf16, %out: bf16):
            %8 = arith.mulf %in, %in_11 : bf16
            %9 = arith.addf %out, %8 : bf16
            linalg.yield %9 : bf16
          }
          memref.dealloc %alloc_5 : memref<8x16x4x8xbf16, 2>
          memref.dealloc %alloc_8 : memref<16x8x8x4xbf16, 2>
        }
        %transpose = memref.transpose %alloc_3 (d0, d1, d2, d3) -> (d1, d2, d0, d3) : memref<16x16x4x4xbf16, 2> to memref<16x4x16x4xbf16, strided<[16, 4, 256, 1]>, 2>
        air.dma_memcpy_nd (%subview_2[] [] [], %transpose[] [] []) : (memref<64x64xbf16, strided<[256, 1], offset: ?>, 1>, memref<16x4x16x4xbf16, strided<[16, 4, 256, 1]>, 2>)
        memref.dealloc %alloc_3 : memref<16x16x4x4xbf16, 2>
        scf.reduce 
      }
      memref.copy %alloc_1, %subview : memref<256x256xbf16, 1> to memref<256x256xbf16, strided<[512, 1], offset: ?>>
      memref.dealloc %alloc : memref<256x1024xbf16, 1>
      memref.dealloc %alloc_0 : memref<1024x256xbf16, 1>
      memref.dealloc %alloc_1 : memref<256x256xbf16, 1>
      scf.reduce 
    }
    return
  }
}
