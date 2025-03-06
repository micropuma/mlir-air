module @aie.matadd_0 {
  aie.device(xcvc1902) {
    %tile_7_2 = aie.tile(7, 2)
    %tile_7_3 = aie.tile(7, 3)
    %tile_7_4 = aie.tile(7, 4)
    %tile_7_5 = aie.tile(7, 5)
    %tile_2_0 = aie.tile(2, 0)
    %tile_3_0 = aie.tile(3, 0)
    %tile_6_0 = aie.tile(6, 0)
    %tile_7_0 = aie.tile(7, 0)
    aie.objectfifo @air_channel_6(%tile_7_5, {%tile_2_0}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_5(%tile_7_3, {%tile_2_0}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_4(%tile_7_4, {%tile_3_0}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_3(%tile_7_2, {%tile_3_0}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_9(%tile_2_0, {%tile_7_5}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_8(%tile_2_0, {%tile_7_3}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_7(%tile_3_0, {%tile_7_4}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_2(%tile_3_0, {%tile_7_2}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_12(%tile_6_0, {%tile_7_5}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_11(%tile_6_0, {%tile_7_3}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_10(%tile_7_0, {%tile_7_4}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    aie.objectfifo @air_channel_1(%tile_7_0, {%tile_7_2}, 1 : i32) : !aie.objectfifo<memref<1x1xf32>> 
    %core_7_5 = aie.core(%tile_7_5) {
      %cst = arith.constant 0.000000e+00 : f32
      %c0 = arith.constant 0 : index
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %0 = aie.objectfifo.acquire @air_channel_12(Consume, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %2 = builtin.unrealized_conversion_cast %1 : memref<1x1xf32> to memref<1x1xf32, 2>
      %3 = aie.objectfifo.acquire @air_channel_9(Consume, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %4 = aie.objectfifo.subview.access %3[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %5 = builtin.unrealized_conversion_cast %4 : memref<1x1xf32> to memref<1x1xf32, 2>
      %6 = aie.objectfifo.acquire @air_channel_6(Produce, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %8 = builtin.unrealized_conversion_cast %7 : memref<1x1xf32> to memref<1x1xf32, 2>
      memref.store %cst, %8[%c0, %c0] : memref<1x1xf32, 2>
      %9 = memref.load %2[%c0, %c0] : memref<1x1xf32, 2>
      %10 = memref.load %5[%c0, %c0] : memref<1x1xf32, 2>
      %11 = arith.addf %9, %10 : f32
      memref.store %11, %8[%c0, %c0] : memref<1x1xf32, 2>
      aie.objectfifo.release @air_channel_6(Produce, 1)
      aie.objectfifo.release @air_channel_9(Consume, 1)
      aie.objectfifo.release @air_channel_12(Consume, 1)
      cf.br ^bb1
    } {elf_file = "matadd_0_core_7_5.elf"}
    %core_7_4 = aie.core(%tile_7_4) {
      %cst = arith.constant 0.000000e+00 : f32
      %c0 = arith.constant 0 : index
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %0 = aie.objectfifo.acquire @air_channel_10(Consume, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %2 = builtin.unrealized_conversion_cast %1 : memref<1x1xf32> to memref<1x1xf32, 2>
      %3 = aie.objectfifo.acquire @air_channel_7(Consume, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %4 = aie.objectfifo.subview.access %3[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %5 = builtin.unrealized_conversion_cast %4 : memref<1x1xf32> to memref<1x1xf32, 2>
      %6 = aie.objectfifo.acquire @air_channel_4(Produce, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %8 = builtin.unrealized_conversion_cast %7 : memref<1x1xf32> to memref<1x1xf32, 2>
      memref.store %cst, %8[%c0, %c0] : memref<1x1xf32, 2>
      %9 = memref.load %2[%c0, %c0] : memref<1x1xf32, 2>
      %10 = memref.load %5[%c0, %c0] : memref<1x1xf32, 2>
      %11 = arith.addf %9, %10 : f32
      memref.store %11, %8[%c0, %c0] : memref<1x1xf32, 2>
      aie.objectfifo.release @air_channel_4(Produce, 1)
      aie.objectfifo.release @air_channel_7(Consume, 1)
      aie.objectfifo.release @air_channel_10(Consume, 1)
      cf.br ^bb1
    } {elf_file = "matadd_0_core_7_4.elf"}
    %core_7_3 = aie.core(%tile_7_3) {
      %cst = arith.constant 0.000000e+00 : f32
      %c0 = arith.constant 0 : index
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %0 = aie.objectfifo.acquire @air_channel_11(Consume, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %2 = builtin.unrealized_conversion_cast %1 : memref<1x1xf32> to memref<1x1xf32, 2>
      %3 = aie.objectfifo.acquire @air_channel_8(Consume, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %4 = aie.objectfifo.subview.access %3[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %5 = builtin.unrealized_conversion_cast %4 : memref<1x1xf32> to memref<1x1xf32, 2>
      %6 = aie.objectfifo.acquire @air_channel_5(Produce, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %8 = builtin.unrealized_conversion_cast %7 : memref<1x1xf32> to memref<1x1xf32, 2>
      memref.store %cst, %8[%c0, %c0] : memref<1x1xf32, 2>
      %9 = memref.load %2[%c0, %c0] : memref<1x1xf32, 2>
      %10 = memref.load %5[%c0, %c0] : memref<1x1xf32, 2>
      %11 = arith.addf %9, %10 : f32
      memref.store %11, %8[%c0, %c0] : memref<1x1xf32, 2>
      aie.objectfifo.release @air_channel_5(Produce, 1)
      aie.objectfifo.release @air_channel_8(Consume, 1)
      aie.objectfifo.release @air_channel_11(Consume, 1)
      cf.br ^bb1
    } {elf_file = "matadd_0_core_7_3.elf"}
    %core_7_2 = aie.core(%tile_7_2) {
      %cst = arith.constant 0.000000e+00 : f32
      %c0 = arith.constant 0 : index
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %0 = aie.objectfifo.acquire @air_channel_1(Consume, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %2 = builtin.unrealized_conversion_cast %1 : memref<1x1xf32> to memref<1x1xf32, 2>
      %3 = aie.objectfifo.acquire @air_channel_2(Consume, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %4 = aie.objectfifo.subview.access %3[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %5 = builtin.unrealized_conversion_cast %4 : memref<1x1xf32> to memref<1x1xf32, 2>
      %6 = aie.objectfifo.acquire @air_channel_3(Produce, 1) : !aie.objectfifosubview<memref<1x1xf32>>
      %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1x1xf32>> -> memref<1x1xf32>
      %8 = builtin.unrealized_conversion_cast %7 : memref<1x1xf32> to memref<1x1xf32, 2>
      memref.store %cst, %8[%c0, %c0] : memref<1x1xf32, 2>
      %9 = memref.load %2[%c0, %c0] : memref<1x1xf32, 2>
      %10 = memref.load %5[%c0, %c0] : memref<1x1xf32, 2>
      %11 = arith.addf %9, %10 : f32
      memref.store %11, %8[%c0, %c0] : memref<1x1xf32, 2>
      aie.objectfifo.release @air_channel_3(Produce, 1)
      aie.objectfifo.release @air_channel_2(Consume, 1)
      aie.objectfifo.release @air_channel_1(Consume, 1)
      cf.br ^bb1
    } {elf_file = "matadd_0_core_7_2.elf"}
  } {sym_name = "matadd_0"}
}

