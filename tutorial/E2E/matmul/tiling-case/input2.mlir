#map = affine_map<()[s0] -> (s0 * 32)>
module {
  func.func private @linalg_fill_i32_view32x32xi32as2(i32, memref<32x32xi32, 2>) attributes {link_with = "mm.o", llvm.emit_c_interface}
  func.func private @linalg_matmul_view32x32xi32as2_view32x32xi32as2_view32x32xi32as2(memref<32x32xi32, 2>, memref<32x32xi32, 2>, memref<32x32xi32, 2>) attributes {link_with = "mm.o", llvm.emit_c_interface}
  func.func @forward(%arg0: memref<64x64xi32>, %arg1: memref<64x64xi32>, %arg2: memref<64x64xi32>) {
    %c1 = arith.constant 1 : index
    %alloc = memref.alloc() : memref<64x64xi32>
    air.launch (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) args(%arg7=%alloc, %arg8=%arg0, %arg9=%arg1) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> {
      air.segment @segment_0  args(%arg10=%arg7, %arg11=%arg8, %arg12=%arg9) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> {
        %c2 = arith.constant 2 : index
        air.herd @herd_0  tile (%arg13, %arg14) in (%arg15=%c2, %arg16=%c2) args(%arg17=%arg10, %arg18=%arg11, %arg19=%arg12) : memref<64x64xi32>, memref<64x64xi32>, memref<64x64xi32> {
          %c1_0 = arith.constant 1 : index
          %c0_i32 = arith.constant 0 : i32
          %c0 = arith.constant 0 : index
          %c64 = arith.constant 64 : index
          %c32 = arith.constant 32 : index
          %0 = affine.apply #map()[%arg13]
          %1 = affine.apply #map()[%arg14]
          %alloc_1 = memref.alloc() : memref<32x32xi32, 2>
          func.call @linalg_fill_i32_view32x32xi32as2(%c0_i32, %alloc_1) : (i32, memref<32x32xi32, 2>) -> ()
          scf.for %arg20 = %c0 to %c64 step %c32 {
            %alloc_2 = memref.alloc() : memref<32x32xi32, 2>
            %alloc_3 = memref.alloc() : memref<32x32xi32, 2>
            air.dma_memcpy_nd (%alloc_2[] [] [], %arg18[%0, %arg20] [%c32, %c32] [%c64, %c1_0]) {id = 1 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
            air.dma_memcpy_nd (%alloc_3[] [] [], %arg19[%arg20, %1] [%c32, %c32] [%c64, %c1_0]) {id = 2 : i32} : (memref<32x32xi32, 2>, memref<64x64xi32>)
            func.call @linalg_matmul_view32x32xi32as2_view32x32xi32as2_view32x32xi32as2(%alloc_2, %alloc_3, %alloc_1) : (memref<32x32xi32, 2>, memref<32x32xi32, 2>, memref<32x32xi32, 2>) -> ()
            memref.dealloc %alloc_2 : memref<32x32xi32, 2>
            memref.dealloc %alloc_3 : memref<32x32xi32, 2>
          }
          air.dma_memcpy_nd (%arg17[%0, %1] [%c32, %c32] [%c64, %c1_0], %alloc_1[] [] []) {id = 3 : i32} : (memref<64x64xi32>, memref<32x32xi32, 2>)
          memref.dealloc %alloc_1 : memref<32x32xi32, 2>
        }
      }
    }
    memref.copy %alloc, %arg2 : memref<64x64xi32> to memref<64x64xi32>
    return
  }
}
