module @aie.graph_0 {
  aie.device(xcvc1902) {
    %tile_7_2 = aie.tile(7, 2)
    %tile_2_0 = aie.tile(2, 0)
    %scratch_copy_0_0 = aie.buffer(%tile_7_2) {sym_name = "scratch_copy_0_0"} : memref<256xi32, 2> 
    aie.objectfifo @air_channel_1(%tile_7_2, {%tile_2_0}, 1 : i32) : !aie.objectfifo<memref<256xi32>> 
    aie.objectfifo @air_channel_0(%tile_2_0, {%tile_7_2}, 1 : i32) : !aie.objectfifo<memref<256xi32>> 
    %core_7_2 = aie.core(%tile_7_2) {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %0 = aie.objectfifo.acquire @air_channel_0(Consume, 1) : !aie.objectfifosubview<memref<256xi32>>
      %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<256xi32>> -> memref<256xi32>
      %2 = aie.objectfifo.acquire @air_channel_1(Produce, 1) : !aie.objectfifosubview<memref<256xi32>>
      %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<256xi32>> -> memref<256xi32>
      %4 = builtin.unrealized_conversion_cast %3 : memref<256xi32> to memref<256xi32, 2>
      affine.for %arg0 = 0 to 256 {
        %5 = affine.load %4[%arg0] : memref<256xi32, 2>
        affine.store %5, %scratch_copy_0_0[%arg0] : memref<256xi32, 2>
      }
      aie.objectfifo.release @air_channel_1(Produce, 1)
      cf.br ^bb1
    } {elf_file = "graph_0_core_7_2.elf"}
  } {sym_name = "graph_0"}
  air.channel @channel_0 [1, 1]
  air.channel @channel_1 [1, 1]
}
