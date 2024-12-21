module {
  // 定义一个接受参数的函数
  func.func @dma_matmul_example(
    %arg3: memref<128x128xf32>,  // 输入矩阵3
    %arg4: memref<128x128xf32>,  // 输入矩阵4
    %arg8: memref<128x128xf32>,  // 输入矩阵8
    %arg9: memref<128x128xf32>,  // 输入矩阵9
    %arg10: memref<128x128xf32>  // 输入矩阵10
  ) {
    // 常量定义，确保常量类型匹配
    %c0 = arith.constant 0 : index
    %c128 = arith.constant 128 : index
    %c32 = arith.constant 32 : index
    %c16 = arith.constant 16 : i32
    %c64 = arith.constant 64 : i32
    %c1_0 = arith.constant 1 : i32

    // 定义局部变量，用于分配内存
    %5 = memref.alloc() : memref<16x32xf32, 2>
    %6 = memref.alloc() : memref<32x64xf32, 2>
    %7 = memref.alloc() : memref<16x64xf32, 2>

    // 开始循环，从0到128，每次步长32
    scf.for %arg11 = %c0 to %c128 step %c32 {
      // DMA 复制操作1，将 %arg8 数据复制到 %5
      air.dma_memcpy_nd (%5[] [] [], %arg8[%arg3, %arg11] [%c16, %c32] [%c128, %c1_0]) {id = 1 : i32} : (memref<16x32xf32, 2>, memref<128x128xf32>)

      // DMA 复制操作2，将 %arg9 数据复制到 %6
      air.dma_memcpy_nd (%6[] [] [], %arg9[%arg11, %arg4] [%c32, %c64] [%c128, %c1_0]) {id = 2 : i32} : (memref<32x64xf32, 2>, memref<128x128xf32>)

      // DMA 复制操作3，将 %arg10 数据复制到 %7
      air.dma_memcpy_nd (%7[] [] [], %arg10[%arg3, %arg4] [%c16, %c64] [%c128, %c1_0]) {id = 3 : i32} : (memref<16x64xf32, 2>, memref<128x128xf32>)

      // 矩阵乘法，计算 %5 和 %6 的乘积并将结果存储到 %7
      linalg.matmul ins(%5, %6 : memref<16x32xf32, 2>, memref<32x64xf32, 2>) outs(%7 : memref<16x64xf32, 2>)

      // DMA 复制操作4，将结果 %7 复制回 %arg10
      air.dma_memcpy_nd (%arg10[%arg3, %arg4] [%c16, %c64] [%c128, %c1_0], %7[] [] []) {id = 4 : i32} : (memref<128x128xf32>, memref<16x64xf32, 2>)
    }

    // 释放分配的内存
    memref.dealloc %5 : memref<16x32xf32, 2>
    memref.dealloc %6 : memref<32x64xf32, 2>
    memref.dealloc %7 : memref<16x64xf32, 2>

    return
  }
}
