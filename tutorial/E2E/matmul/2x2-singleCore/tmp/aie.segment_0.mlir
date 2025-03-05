module @aie.segment_0 {
  aie.device(xcvc1902) {
    %extBuf23 = aie.external_buffer {sym_name = "extBuf23"} : memref<64x64xi32>
    %extBuf22 = aie.external_buffer {sym_name = "extBuf22"} : memref<64x64xi32>
    %extBuf21 = aie.external_buffer {sym_name = "extBuf21"} : memref<64x64xi32>
    %extBuf20 = aie.external_buffer {sym_name = "extBuf20"} : memref<64x64xi32>
    %extBuf19 = aie.external_buffer {sym_name = "extBuf19"} : memref<64x64xi32>
    %extBuf18 = aie.external_buffer {sym_name = "extBuf18"} : memref<64x64xi32>
    %extBuf17 = aie.external_buffer {sym_name = "extBuf17"} : memref<64x64xi32>
    %extBuf16 = aie.external_buffer {sym_name = "extBuf16"} : memref<64x64xi32>
    %extBuf15 = aie.external_buffer {sym_name = "extBuf15"} : memref<64x64xi32>
    %extBuf14 = aie.external_buffer {sym_name = "extBuf14"} : memref<64x64xi32>
    %extBuf13 = aie.external_buffer {sym_name = "extBuf13"} : memref<64x64xi32>
    %extBuf12 = aie.external_buffer {sym_name = "extBuf12"} : memref<64x64xi32>
    %tile_7_2 = aie.tile(7, 2)
    %tile_7_3 = aie.tile(7, 3)
    %tile_7_4 = aie.tile(7, 4)
    %tile_7_5 = aie.tile(7, 5)
    %tile_7_0 = aie.tile(7, 0)
    %tile_10_0 = aie.tile(10, 0)
    %tile_11_0 = aie.tile(11, 0)
    %tile_18_0 = aie.tile(18, 0)
    %lock_18_0 = aie.lock(%tile_18_0, 1) {init = 0 : i32}
    %lock_18_0_0 = aie.lock(%tile_18_0, 0) {init = 0 : i32}
    %lock_11_0 = aie.lock(%tile_11_0, 1) {init = 0 : i32}
    %lock_11_0_1 = aie.lock(%tile_11_0, 0) {init = 0 : i32}
    %lock_10_0 = aie.lock(%tile_10_0, 3) {init = 0 : i32}
    %lock_10_0_2 = aie.lock(%tile_10_0, 2) {init = 0 : i32}
    %lock_10_0_3 = aie.lock(%tile_10_0, 1) {init = 0 : i32}
    %lock_10_0_4 = aie.lock(%tile_10_0, 0) {init = 0 : i32}
    %lock_7_0 = aie.lock(%tile_7_0, 3) {init = 0 : i32}
    %lock_7_0_5 = aie.lock(%tile_7_0, 2) {init = 0 : i32}
    %lock_7_0_6 = aie.lock(%tile_7_0, 1) {init = 0 : i32}
    %lock_7_0_7 = aie.lock(%tile_7_0, 0) {init = 0 : i32}
    %lock_7_2 = aie.lock(%tile_7_2, 2) {init = 0 : i32}
    %lock_7_2_8 = aie.lock(%tile_7_2, 1) {init = 0 : i32}
    %lock_7_2_9 = aie.lock(%tile_7_2, 0) {init = 0 : i32}
    %lock_7_3 = aie.lock(%tile_7_3, 2) {init = 0 : i32}
    %lock_7_3_10 = aie.lock(%tile_7_3, 1) {init = 0 : i32}
    %lock_7_3_11 = aie.lock(%tile_7_3, 0) {init = 0 : i32}
    %lock_7_4 = aie.lock(%tile_7_4, 2) {init = 0 : i32}
    %lock_7_4_12 = aie.lock(%tile_7_4, 1) {init = 0 : i32}
    %lock_7_4_13 = aie.lock(%tile_7_4, 0) {init = 0 : i32}
    %lock_7_5 = aie.lock(%tile_7_5, 2) {init = 0 : i32}
    %lock_7_5_14 = aie.lock(%tile_7_5, 1) {init = 0 : i32}
    %lock_7_5_15 = aie.lock(%tile_7_5, 0) {init = 0 : i32}
    %buf11 = aie.buffer(%tile_7_5) {sym_name = "buf11"} : memref<32x32xi32, 2> 
    %buf10 = aie.buffer(%tile_7_5) {sym_name = "buf10"} : memref<32x32xi32, 2> 
    %buf9 = aie.buffer(%tile_7_5) {sym_name = "buf9"} : memref<32x32xi32, 2> 
    %buf8 = aie.buffer(%tile_7_4) {sym_name = "buf8"} : memref<32x32xi32, 2> 
    %buf7 = aie.buffer(%tile_7_4) {sym_name = "buf7"} : memref<32x32xi32, 2> 
    %buf6 = aie.buffer(%tile_7_4) {sym_name = "buf6"} : memref<32x32xi32, 2> 
    %buf5 = aie.buffer(%tile_7_3) {sym_name = "buf5"} : memref<32x32xi32, 2> 
    %buf4 = aie.buffer(%tile_7_3) {sym_name = "buf4"} : memref<32x32xi32, 2> 
    %buf3 = aie.buffer(%tile_7_3) {sym_name = "buf3"} : memref<32x32xi32, 2> 
    %buf2 = aie.buffer(%tile_7_2) {sym_name = "buf2"} : memref<32x32xi32, 2> 
    %buf1 = aie.buffer(%tile_7_2) {sym_name = "buf1"} : memref<32x32xi32, 2> 
    %buf0 = aie.buffer(%tile_7_2) {sym_name = "buf0"} : memref<32x32xi32, 2> 
    memref.global "public" @__air_herd_arg_9 : memref<64x64xi32>
    memref.global "public" @__air_herd_arg_10 : memref<64x64xi32>
    memref.global "public" @__air_herd_arg_11 : memref<64x64xi32>
    %mem_7_5 = aie.mem(%tile_7_5) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb5)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_5_14, Acquire, 0)
      aie.dma_bd(%buf10 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_5_14, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb5
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_7_5, Acquire, 0)
      aie.dma_bd(%buf9 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_5, Release, 1)
      aie.next_bd ^bb4
    ^bb5:  // pred: ^bb0
      %2 = aie.dma_start(MM2S, 0, ^bb6, ^bb3)
    ^bb6:  // 2 preds: ^bb5, ^bb6
      aie.use_lock(%lock_7_5_15, Acquire, 1)
      aie.dma_bd(%buf11 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_5_15, Release, 0)
      aie.next_bd ^bb6
    }
    %core_7_5 = aie.core(%tile_7_5) {
      %c0_i32 = arith.constant 0 : i32
      %c64 = arith.constant 64 : index
      %c32 = arith.constant 32 : index
      %c1 = arith.constant 1 : index
      %c0 = arith.constant 0 : index
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_5_15, Acquire, 0)
      scf.for %arg0 = %c0 to %c32 step %c1 {
        scf.for %arg1 = %c0 to %c32 step %c1 {
          memref.store %c0_i32, %buf11[%arg0, %arg1] : memref<32x32xi32, 2>
        }
      }
      scf.for %arg0 = %c0 to %c64 step %c32 {
        aie.use_lock(%lock_7_5_14, Acquire, 1)
        aie.use_lock(%lock_7_5, Acquire, 1)
        scf.for %arg1 = %c0 to %c32 step %c1 {
          scf.for %arg2 = %c0 to %c32 step %c1 {
            scf.for %arg3 = %c0 to %c32 step %c1 {
              %0 = memref.load %buf10[%arg1, %arg3] : memref<32x32xi32, 2>
              %1 = memref.load %buf9[%arg3, %arg2] : memref<32x32xi32, 2>
              %2 = memref.load %buf11[%arg1, %arg2] : memref<32x32xi32, 2>
              %3 = arith.muli %0, %1 : i32
              %4 = arith.addi %2, %3 : i32
              memref.store %4, %buf11[%arg1, %arg2] : memref<32x32xi32, 2>
            }
          }
        }
        aie.use_lock(%lock_7_5_14, Release, 0)
        aie.use_lock(%lock_7_5, Release, 0)
      }
      aie.use_lock(%lock_7_5_15, Release, 1)
      cf.br ^bb1
    } {elf_file = "segment_0_core_7_5.elf"}
    memref.global "public" @__air_herd_arg_6 : memref<64x64xi32>
    memref.global "public" @__air_herd_arg_7 : memref<64x64xi32>
    memref.global "public" @__air_herd_arg_8 : memref<64x64xi32>
    %mem_7_4 = aie.mem(%tile_7_4) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb5)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_4_12, Acquire, 0)
      aie.dma_bd(%buf7 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_4_12, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb5
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_7_4, Acquire, 0)
      aie.dma_bd(%buf6 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_4, Release, 1)
      aie.next_bd ^bb4
    ^bb5:  // pred: ^bb0
      %2 = aie.dma_start(MM2S, 0, ^bb6, ^bb3)
    ^bb6:  // 2 preds: ^bb5, ^bb6
      aie.use_lock(%lock_7_4_13, Acquire, 1)
      aie.dma_bd(%buf8 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_4_13, Release, 0)
      aie.next_bd ^bb6
    }
    %core_7_4 = aie.core(%tile_7_4) {
      %c0_i32 = arith.constant 0 : i32
      %c64 = arith.constant 64 : index
      %c32 = arith.constant 32 : index
      %c1 = arith.constant 1 : index
      %c0 = arith.constant 0 : index
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_4_13, Acquire, 0)
      scf.for %arg0 = %c0 to %c32 step %c1 {
        scf.for %arg1 = %c0 to %c32 step %c1 {
          memref.store %c0_i32, %buf8[%arg0, %arg1] : memref<32x32xi32, 2>
        }
      }
      scf.for %arg0 = %c0 to %c64 step %c32 {
        aie.use_lock(%lock_7_4_12, Acquire, 1)
        aie.use_lock(%lock_7_4, Acquire, 1)
        scf.for %arg1 = %c0 to %c32 step %c1 {
          scf.for %arg2 = %c0 to %c32 step %c1 {
            scf.for %arg3 = %c0 to %c32 step %c1 {
              %0 = memref.load %buf7[%arg1, %arg3] : memref<32x32xi32, 2>
              %1 = memref.load %buf6[%arg3, %arg2] : memref<32x32xi32, 2>
              %2 = memref.load %buf8[%arg1, %arg2] : memref<32x32xi32, 2>
              %3 = arith.muli %0, %1 : i32
              %4 = arith.addi %2, %3 : i32
              memref.store %4, %buf8[%arg1, %arg2] : memref<32x32xi32, 2>
            }
          }
        }
        aie.use_lock(%lock_7_4_12, Release, 0)
        aie.use_lock(%lock_7_4, Release, 0)
      }
      aie.use_lock(%lock_7_4_13, Release, 1)
      cf.br ^bb1
    } {elf_file = "segment_0_core_7_4.elf"}
    memref.global "public" @__air_herd_arg_3 : memref<64x64xi32>
    memref.global "public" @__air_herd_arg_4 : memref<64x64xi32>
    memref.global "public" @__air_herd_arg_5 : memref<64x64xi32>
    %mem_7_3 = aie.mem(%tile_7_3) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb5)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_3_10, Acquire, 0)
      aie.dma_bd(%buf4 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_3_10, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb5
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_7_3, Acquire, 0)
      aie.dma_bd(%buf3 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_3, Release, 1)
      aie.next_bd ^bb4
    ^bb5:  // pred: ^bb0
      %2 = aie.dma_start(MM2S, 0, ^bb6, ^bb3)
    ^bb6:  // 2 preds: ^bb5, ^bb6
      aie.use_lock(%lock_7_3_11, Acquire, 1)
      aie.dma_bd(%buf5 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_3_11, Release, 0)
      aie.next_bd ^bb6
    }
    %core_7_3 = aie.core(%tile_7_3) {
      %c0_i32 = arith.constant 0 : i32
      %c64 = arith.constant 64 : index
      %c32 = arith.constant 32 : index
      %c1 = arith.constant 1 : index
      %c0 = arith.constant 0 : index
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_3_11, Acquire, 0)
      scf.for %arg0 = %c0 to %c32 step %c1 {
        scf.for %arg1 = %c0 to %c32 step %c1 {
          memref.store %c0_i32, %buf5[%arg0, %arg1] : memref<32x32xi32, 2>
        }
      }
      scf.for %arg0 = %c0 to %c64 step %c32 {
        aie.use_lock(%lock_7_3_10, Acquire, 1)
        aie.use_lock(%lock_7_3, Acquire, 1)
        scf.for %arg1 = %c0 to %c32 step %c1 {
          scf.for %arg2 = %c0 to %c32 step %c1 {
            scf.for %arg3 = %c0 to %c32 step %c1 {
              %0 = memref.load %buf4[%arg1, %arg3] : memref<32x32xi32, 2>
              %1 = memref.load %buf3[%arg3, %arg2] : memref<32x32xi32, 2>
              %2 = memref.load %buf5[%arg1, %arg2] : memref<32x32xi32, 2>
              %3 = arith.muli %0, %1 : i32
              %4 = arith.addi %2, %3 : i32
              memref.store %4, %buf5[%arg1, %arg2] : memref<32x32xi32, 2>
            }
          }
        }
        aie.use_lock(%lock_7_3_10, Release, 0)
        aie.use_lock(%lock_7_3, Release, 0)
      }
      aie.use_lock(%lock_7_3_11, Release, 1)
      cf.br ^bb1
    } {elf_file = "segment_0_core_7_3.elf"}
    memref.global "public" @__air_herd_arg : memref<64x64xi32>
    memref.global "public" @__air_herd_arg_1 : memref<64x64xi32>
    memref.global "public" @__air_herd_arg_2 : memref<64x64xi32>
    %mem_7_2 = aie.mem(%tile_7_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb5)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_2_8, Acquire, 0)
      aie.dma_bd(%buf1 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_2_8, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb5
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_7_2, Acquire, 0)
      aie.dma_bd(%buf0 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_2, Release, 1)
      aie.next_bd ^bb4
    ^bb5:  // pred: ^bb0
      %2 = aie.dma_start(MM2S, 0, ^bb6, ^bb3)
    ^bb6:  // 2 preds: ^bb5, ^bb6
      aie.use_lock(%lock_7_2_9, Acquire, 1)
      aie.dma_bd(%buf2 : memref<32x32xi32, 2>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_2_9, Release, 0)
      aie.next_bd ^bb6
    }
    %core_7_2 = aie.core(%tile_7_2) {
      %c0_i32 = arith.constant 0 : i32
      %c64 = arith.constant 64 : index
      %c32 = arith.constant 32 : index
      %c1 = arith.constant 1 : index
      %c0 = arith.constant 0 : index
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_2_9, Acquire, 0)
      scf.for %arg0 = %c0 to %c32 step %c1 {
        scf.for %arg1 = %c0 to %c32 step %c1 {
          memref.store %c0_i32, %buf2[%arg0, %arg1] : memref<32x32xi32, 2>
        }
      }
      scf.for %arg0 = %c0 to %c64 step %c32 {
        aie.use_lock(%lock_7_2_8, Acquire, 1)
        aie.use_lock(%lock_7_2, Acquire, 1)
        scf.for %arg1 = %c0 to %c32 step %c1 {
          scf.for %arg2 = %c0 to %c32 step %c1 {
            scf.for %arg3 = %c0 to %c32 step %c1 {
              %0 = memref.load %buf1[%arg1, %arg3] : memref<32x32xi32, 2>
              %1 = memref.load %buf0[%arg3, %arg2] : memref<32x32xi32, 2>
              %2 = memref.load %buf2[%arg1, %arg2] : memref<32x32xi32, 2>
              %3 = arith.muli %0, %1 : i32
              %4 = arith.addi %2, %3 : i32
              memref.store %4, %buf2[%arg1, %arg2] : memref<32x32xi32, 2>
            }
          }
        }
        aie.use_lock(%lock_7_2_8, Release, 0)
        aie.use_lock(%lock_7_2, Release, 0)
      }
      aie.use_lock(%lock_7_2_9, Release, 1)
      cf.br ^bb1
    } {elf_file = "segment_0_core_7_2.elf"}
    aie.flow(%tile_7_0, DMA : 0, %tile_7_5, DMA : 0)
    aie.flow(%tile_7_0, DMA : 1, %tile_7_5, DMA : 1)
    aie.flow(%tile_7_5, DMA : 0, %tile_7_0, DMA : 0)
    aie.flow(%tile_10_0, DMA : 0, %tile_7_4, DMA : 0)
    aie.flow(%tile_10_0, DMA : 1, %tile_7_4, DMA : 1)
    aie.flow(%tile_7_4, DMA : 0, %tile_7_0, DMA : 1)
    aie.flow(%tile_11_0, DMA : 0, %tile_7_3, DMA : 0)
    aie.flow(%tile_11_0, DMA : 1, %tile_7_3, DMA : 1)
    aie.flow(%tile_7_3, DMA : 0, %tile_10_0, DMA : 0)
    aie.flow(%tile_18_0, DMA : 0, %tile_7_2, DMA : 0)
    aie.flow(%tile_18_0, DMA : 1, %tile_7_2, DMA : 1)
    aie.flow(%tile_7_2, DMA : 0, %tile_10_0, DMA : 1)
    %shim_dma_7_0 = aie.shim_dma(%tile_7_0) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb7)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_7_0_7, Acquire, 0)
      aie.dma_bd(%extBuf12 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_0_7, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb5
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_7_0_6, Acquire, 0)
      aie.dma_bd(%extBuf13 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_0_6, Release, 1)
      aie.next_bd ^bb4
    ^bb5:  // pred: ^bb7
      %2 = aie.dma_start(MM2S, 0, ^bb6, ^bb3)
    ^bb6:  // 2 preds: ^bb5, ^bb6
      aie.use_lock(%lock_7_0_5, Acquire, 1)
      aie.dma_bd(%extBuf14 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_0_5, Release, 0)
      aie.next_bd ^bb6
    ^bb7:  // pred: ^bb0
      %3 = aie.dma_start(MM2S, 1, ^bb8, ^bb5)
    ^bb8:  // 2 preds: ^bb7, ^bb8
      aie.use_lock(%lock_7_0, Acquire, 1)
      aie.dma_bd(%extBuf15 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_7_0, Release, 0)
      aie.next_bd ^bb8
    }
    %shim_dma_10_0 = aie.shim_dma(%tile_10_0) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb7)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_10_0_4, Acquire, 0)
      aie.dma_bd(%extBuf16 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_10_0_4, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb5
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_10_0_3, Acquire, 0)
      aie.dma_bd(%extBuf17 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_10_0_3, Release, 1)
      aie.next_bd ^bb4
    ^bb5:  // pred: ^bb7
      %2 = aie.dma_start(MM2S, 0, ^bb6, ^bb3)
    ^bb6:  // 2 preds: ^bb5, ^bb6
      aie.use_lock(%lock_10_0_2, Acquire, 1)
      aie.dma_bd(%extBuf18 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_10_0_2, Release, 0)
      aie.next_bd ^bb6
    ^bb7:  // pred: ^bb0
      %3 = aie.dma_start(MM2S, 1, ^bb8, ^bb5)
    ^bb8:  // 2 preds: ^bb7, ^bb8
      aie.use_lock(%lock_10_0, Acquire, 1)
      aie.dma_bd(%extBuf19 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_10_0, Release, 0)
      aie.next_bd ^bb8
    }
    %shim_dma_11_0 = aie.shim_dma(%tile_11_0) {
      %0 = aie.dma_start(MM2S, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_11_0_1, Acquire, 1)
      aie.dma_bd(%extBuf20 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_11_0_1, Release, 0)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 1, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_11_0, Acquire, 1)
      aie.dma_bd(%extBuf21 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_11_0, Release, 0)
      aie.next_bd ^bb4
    }
    %shim_dma_18_0 = aie.shim_dma(%tile_18_0) {
      %0 = aie.dma_start(MM2S, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%lock_18_0_0, Acquire, 1)
      aie.dma_bd(%extBuf22 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_18_0_0, Release, 0)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb3
      aie.end
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 1, ^bb4, ^bb2)
    ^bb4:  // 2 preds: ^bb3, ^bb4
      aie.use_lock(%lock_18_0, Acquire, 1)
      aie.dma_bd(%extBuf23 : memref<64x64xi32>, 0, 1024) {task_id = 0 : i32}
      aie.use_lock(%lock_18_0, Release, 0)
      aie.next_bd ^bb4
    }
  } {sym_name = "segment_0"}
}
