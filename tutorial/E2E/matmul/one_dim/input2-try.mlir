module {
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c2 = arith.constant 2 : index
    air.herd @herd_0  tile (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%arg0, %arg8=%arg1, %arg9=%arg2) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c4 = arith.constant 2 : index
      %buf1 = memref.alloc() : memref<2x2xf32, 2>
      %buf2 = memref.alloc() : memref<2x2xf32, 2>
      %buf3 = memref.alloc() : memref<2x2xf32, 2>

      air.dma_memcpy_nd (%buf1[][][], %arg7[%c0, %c0][%c4, %c4][%c4, %c1]) {id = 1 : i32}  : (memref<2x2xf32, 2>, memref<2x2xf32>)
      air.dma_memcpy_nd (%buf2[][][], %arg8[%c0, %c0][%c4, %c4][%c4, %c1]) {id = 2 : i32}  : (memref<2x2xf32, 2>, memref<2x2xf32>)

      %0 = memref.load %buf1[%arg3, %arg4] : memref<2x2xf32, 2>
      %1 = memref.load %buf2[%arg3, %arg4] : memref<2x2xf32, 2>
      %2 = arith.addf %0, %1 : f32
      memref.store %2, %buf3[%arg3, %arg4] : memref<2x2xf32, 2>

      air.dma_memcpy_nd (%arg9[%c0, %c0][%c4, %c4][%c4, %c1], %buf3[][][]) {id = 3 : i32}  : (memref<2x2xf32>, memref<2x2xf32, 2>)

      memref.dealloc %buf1 : memref<2x2xf32, 2>
      memref.dealloc %buf2 : memref<2x2xf32, 2>
      memref.dealloc %buf3 : memref<2x2xf32, 2>
      air.herd_terminator
    }
    return
  }
}