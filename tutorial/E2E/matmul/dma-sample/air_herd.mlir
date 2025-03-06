module {
  air.channel @channel_0 [1, 1]
  air.channel @channel_1 [1, 1]
  func.func @graph(%arg0: memref<256xi32>, %arg1: memref<256xi32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    air.channel.put  @channel_0[%c0, %c0] (%arg0[] [] []) {id = 1 : i32} : (memref<256xi32>)
    air.channel.get  @channel_1[%c0, %c0] (%arg1[] [] []) {id = 2 : i32} : (memref<256xi32>)
    air.launch (%arg2, %arg3) in (%arg4=%c1, %arg5=%c1) {
      air.segment @graph_0  {
        %c1_0 = arith.constant 1 : index
        air.herd @copyherd  tile (%arg6, %arg7) in (%arg8=%c1_0, %arg9=%c1_0) {
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
