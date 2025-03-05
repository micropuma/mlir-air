module @aie.graph_0 {
  aie.device(xcvc1902) {
    %extBuf1 = aie.external_buffer {sym_name = "extBuf1"} : memref<256xi32>
    %extBuf0 = aie.external_buffer {sym_name = "extBuf0"} : memref<256xi32>
    %tile_7_2 = aie.tile(7, 2)
    %tile_7_0 = aie.tile(7, 0)
    %lock_7_0 = aie.lock(%tile_7_0, 1) {init = 0 : i32}
    %lock_7_0_0 = aie.lock(%tile_7_0, 0) {init = 0 : i32}
    %lock_7_2 = aie.lock(%tile_7_2, 1) {init = 0 : i32}
    %lock_7_2_1 = aie.lock(%tile_7_2, 0) {init = 0 : i32}
    %scratch_0_0 = aie.buffer(%tile_7_2) {sym_name = "scratch_0_0"} : memref<256xi32, 2> 
    %scratch_copy_0_0 = aie.buffer(%tile_7_2) {sym_name = "scratch_copy_0_0"} : memref<256xi32, 2> 
    memref.global "public" @__air_herd_arg : memref<256xi32>
    memref.global "public" @__air_herd_arg_1 : memref<256xi32>
    %mem_7_2 = aie.mem(%tile_7_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_2, Acquire, 0)
      aie.dma_bd(%scratch_0_0 : memref<256xi32, 2>, 0, 256) {task_id = 0 : i32}
      aie.use_lock(%lock_7_2, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 0, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_7_2_1, Acquire, 1)
      aie.dma_bd(%scratch_0_0 : memref<256xi32, 2>, 0, 256) {task_id = 0 : i32}
      aie.use_lock(%lock_7_2_1, Release, 0)
      aie.next_bd ^bb4
    }
    %core_7_2 = aie.core(%tile_7_2) {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_2_1, Acquire, 0)
      aie.use_lock(%lock_7_2, Acquire, 1)
      affine.for %arg0 = 0 to 256 {
        %0 = affine.load %scratch_0_0[%arg0] : memref<256xi32, 2>
        affine.store %0, %scratch_copy_0_0[%arg0] : memref<256xi32, 2>
      }
      aie.use_lock(%lock_7_2_1, Release, 1)
      aie.use_lock(%lock_7_2, Release, 0)
      cf.br ^bb1
    } {elf_file = "graph_0_core_7_2.elf"}
    aie.flow(%tile_7_0, DMA : 0, %tile_7_2, DMA : 0)
    aie.flow(%tile_7_2, DMA : 0, %tile_7_0, DMA : 0)
    %shim_dma_7_0 = aie.shim_dma(%tile_7_0) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_0_0, Acquire, 0)
      aie.dma_bd(%extBuf0 : memref<256xi32>, 0, 256) {task_id = 0 : i32}
      aie.use_lock(%lock_7_0_0, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 0, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_7_0, Acquire, 1)
      aie.dma_bd(%extBuf1 : memref<256xi32>, 0, 256) {task_id = 0 : i32}
      aie.use_lock(%lock_7_0, Release, 0)
      aie.next_bd ^bb4
    }
  } {sym_name = "graph_0"}
}
