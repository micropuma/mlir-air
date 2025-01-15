module {
    func.func @f(%arg0: memref<1024xi32>, %arg1: memref<1024xi32>) {
      %c1 = arith.constant 1 : index
      air.herd @herd_0  tile (%arg2, %arg3) in (%arg4=%c1, %arg5=%c1) args(%arg6=%arg0, %arg7=%arg1) : memref<1024xi32>, memref<1024xi32> attributes {x_loc = 1 : i32, y_loc = 1 : i32} {
        %alloc = memref.alloc() : memref<1024xi32, 2>
        air.dma_memcpy_nd (%alloc[] [] [], %arg6[] [] []) {id = 1 : i32} : (memref<1024xi32, 2>, memref<1024xi32>)
        memref.dealloc %alloc : memref<1024xi32, 2>
        air.herd_terminator
      }
      return
    }
  }
