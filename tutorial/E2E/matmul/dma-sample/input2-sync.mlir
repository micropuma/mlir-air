module {
  air.channel @channel_0 [1, 1]
  air.channel @channel_1 [1, 1]
  func.func @graph(%arg0: memref<256xi32>, %arg1: memref<256xi32>) {
    %c1 = arith.constant 1 : index
    %c1_0 = arith.constant 1 : index
    %c1_1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c0_2 = arith.constant 0 : index
    %c1_3 = arith.constant 1 : index
    %c1_4 = arith.constant 1 : index
    %0 = air.wait_all async 
    scf.parallel (%arg2, %arg3) = (%c0, %c0_2) to (%c1_3, %c1_4) step (%c1_1, %c1_1) {
      air.channel.put  @channel_0[%arg2, %arg3] (%arg0[] [] []) : (memref<256xi32>)
      scf.reduce 
    }
    %c1_5 = arith.constant 1 : index
    %c0_6 = arith.constant 0 : index
    %c0_7 = arith.constant 0 : index
    %c1_8 = arith.constant 1 : index
    %c1_9 = arith.constant 1 : index
    %1 = air.wait_all async 
    scf.parallel (%arg2, %arg3) = (%c0_6, %c0_7) to (%c1_8, %c1_9) step (%c1_5, %c1_5) {
      air.channel.get  @channel_1[%arg2, %arg3] (%arg1[] [] []) : (memref<256xi32>)
      scf.reduce 
    }
    air.herd @copyherd  tile (%arg2, %arg3) in (%arg4=%c1, %arg5=%c1_0) args(%arg6=%arg0, %arg7=%arg1) : memref<256xi32>, memref<256xi32> {
      %c0_10 = arith.constant 0 : index
      %c1_11 = arith.constant 1 : index
      %c256 = arith.constant 256 : index
      %alloc = memref.alloc() {sym_name = "scratch"} : memref<256xi32, 2>
      %alloc_12 = memref.alloc() {sym_name = "scratch_copy"} : memref<256xi32, 2>
      air.channel.get  @channel_0[%arg2, %arg3] (%alloc[] [] []) : (memref<256xi32, 2>)
      affine.for %arg8 = 0 to 256 {
        %2 = affine.load %alloc[%arg8] : memref<256xi32, 2>
        affine.store %2, %alloc_12[%arg8] : memref<256xi32, 2>
      }
      air.channel.put  @channel_1[%arg2, %arg3] (%alloc[] [] []) : (memref<256xi32, 2>)
      memref.dealloc %alloc_12 : memref<256xi32, 2>
      memref.dealloc %alloc : memref<256xi32, 2>
    }
    return
  }
}
