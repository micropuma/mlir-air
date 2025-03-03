module {
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c2 = arith.constant 2 : index
    air.herd @herd_0  tile (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%arg0, %arg8=%arg1, %arg9=%arg2) : 
      memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
      %0 = memref.load %arg7[%arg3, %arg4] : memref<2x2xf32>
      %1 = memref.load %arg8[%arg3, %arg4] : memref<2x2xf32>
      %2 = arith.addf %0, %1 : f32
      memref.store %2, %arg9[%arg3, %arg4] : memref<2x2xf32>
    }
    return
  }
}
