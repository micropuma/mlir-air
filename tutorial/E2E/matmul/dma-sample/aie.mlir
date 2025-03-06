module {
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
  airrt.module_metadata{
    airrt.segment_metadata attributes {dma_allocations = [], sym_name = "graph_0"}{
      airrt.herd_metadata {dma_allocations = [], sym_name = "copyherd"}
    }
  }
  air.channel @channel_0 [1, 1]
  air.channel @channel_1 [1, 1]
  func.func @graph(%arg0: memref<256xi32>, %arg1: memref<256xi32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    air.channel.put  @channel_0[%c0, %c0] (%arg0[] [] []) {id = 1 : i32, metadata = @air_channel_0} : (memref<256xi32>)
    air.channel.get  @channel_1[%c0, %c0] (%arg1[] [] []) {id = 2 : i32, metadata = @air_channel_1} : (memref<256xi32>)
    air.launch (%arg2, %arg3) in (%arg4=%c1, %arg5=%c1) {
      air.segment @graph_0  attributes {x_loc = 7 : i64, x_size = 10 : i64, y_loc = 2 : i64, y_size = 6 : i64} {
        %c1_0 = arith.constant 1 : index
        air.herd @copyherd  tile (%arg6, %arg7) in (%arg8=%c1_0, %arg9=%c1_0) attributes {x_loc = 7 : i64, y_loc = 2 : i64} {
          %alloc = memref.alloc() {sym_name = "scratch"} : memref<256xi32, 2>
          %alloc_1 = memref.alloc() {sym_name = "scratch_copy"} : memref<256xi32, 2>
          air.channel.get  @channel_0[%arg6, %arg7] (%alloc[] [] []) {id = 3 : i32} : (memref<256xi32, 2>)
          affine.for %arg10 = 0 to 256 {
            %0 = affine.load %alloc[%arg10] : memref<256xi32, 2>
            affine.store %0, %alloc_1[%arg10] : memref<256xi32, 2>
          }
          air.channel.put  @channel_1[%arg6, %arg7] (%alloc[] [] []) {id = 4 : i32} : (memref<256xi32, 2>)
          memref.dealloc %alloc_1 : memref<256xi32, 2>
          memref.dealloc %alloc : memref<256xi32, 2>
        }
      }
    }
    return
  }
}
