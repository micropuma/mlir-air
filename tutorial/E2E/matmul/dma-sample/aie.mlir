module {
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
  airrt.module_metadata{
    airrt.segment_metadata attributes {dma_allocations = [], sym_name = "graph_0"}{
      airrt.herd_metadata {dma_allocations = [{channel = 0 : i64, col = 0 : i64, id = 2 : i64, location = 7 : i64, row = 0 : i64}, {channel = 2 : i64, col = 0 : i64, id = 1 : i64, location = 7 : i64, row = 0 : i64}], sym_name = "copyherd"}
    }
  }
  func.func @graph(%arg0: memref<256xi32>, %arg1: memref<256xi32>) {
    %c1 = arith.constant 1 : index
    air.launch (%arg2, %arg3) in (%arg4=%c1, %arg5=%c1) args(%arg6=%arg0, %arg7=%arg1) : memref<256xi32>, memref<256xi32> {
      air.segment @graph_0  args(%arg8=%arg6, %arg9=%arg7) : memref<256xi32>, memref<256xi32> attributes {x_loc = 7 : i64, x_size = 10 : i64, y_loc = 2 : i64, y_size = 6 : i64} {
        %c1_0 = arith.constant 1 : index
        air.herd @copyherd  tile (%arg10, %arg11) in (%arg12=%c1_0, %arg13=%c1_0) args(%arg14=%arg8, %arg15=%arg9) : memref<256xi32>, memref<256xi32> attributes {x_loc = 7 : i64, y_loc = 2 : i64} {
          %alloc = memref.alloc() {sym_name = "scratch"} : memref<256xi32, 2>
          %alloc_1 = memref.alloc() {sym_name = "scratch_copy"} : memref<256xi32, 2>
          air.dma_memcpy_nd (%alloc[] [] [], %arg14[] [] []) {id = 1 : i32} : (memref<256xi32, 2>, memref<256xi32>)
          affine.for %arg16 = 0 to 256 {
            %0 = affine.load %alloc[%arg16] : memref<256xi32, 2>
            affine.store %0, %alloc_1[%arg16] : memref<256xi32, 2>
          }
          air.dma_memcpy_nd (%arg15[] [] [], %alloc[] [] []) {id = 2 : i32} : (memref<256xi32>, memref<256xi32, 2>)
          memref.dealloc %alloc_1 : memref<256xi32, 2>
          memref.dealloc %alloc : memref<256xi32, 2>
        }
      }
    }
    return
  }
}
