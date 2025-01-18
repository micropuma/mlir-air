module {
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c2 = arith.constant 2 : index

    // Allocate temporary memory for result
    %alloc = memref.alloc() : memref<2x2xf32>

    air.herd @herd_0  tile (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%arg0, %arg8=%arg1, %arg9=%alloc) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
      // Allocate result buffer for each tile and init it
      %c0 = arith.constant 0.0 : f32
      %c1 = arith.constant 1 : index
      %c2_2 = arith.constant 2 : index
      %alloc_1 = memref.alloc() : memref<1x1xf32, 2>
      linalg.fill ins(%c0 : f32) outs(%alloc_1 : memref<1x1xf32, 2>)

      // Get operand1 and operand2 buffer through dma
      %alloc_2 = memref.alloc() : memref<1x1xf32, 2>
      %alloc_3 = memref.alloc() : memref<1x1xf32, 2>
      air.dma_memcpy_nd (%alloc_2[] [] [], %arg7[%arg3, %arg4] [%c1, %c1] [%c2_2, %c1]) {id = 1 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
      air.dma_memcpy_nd (%alloc_3[] [] [], %arg8[%arg3, %arg4] [%c1, %c1] [%c2_2, %c1]) {id = 2 : i32} : (memref<1x1xf32, 2>, memref<2x2xf32>)
      linalg.add ins(%alloc_2, %alloc_3 : memref<1x1xf32, 2>, memref<1x1xf32, 2>) outs(%alloc_1 : memref<1x1xf32, 2>)
      memref.dealloc %alloc_2 : memref<1x1xf32, 2>
      memref.dealloc %alloc_1 : memref<1x1xf32, 2>

      // do calculation
      air.dma_memcpy_nd (%arg9[%arg3, %arg4] [%c1, %c1] [%c2_2, %c1], %alloc_1[] [] []) {id = 3 : i32} : (memref<2x2xf32>, memref<1x1xf32, 2>) 
      memref.dealloc %alloc_1 : memref<1x1xf32, 2>
    }

    // Copy temporary memory back to %arg2
    // and then deallocate temporary memory
    memref.copy %alloc, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    memref.dealloc %alloc : memref<2x2xf32>
    return
  }
}