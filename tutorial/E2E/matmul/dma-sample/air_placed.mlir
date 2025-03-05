module {
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
