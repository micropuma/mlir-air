module {
  func.func @matadd(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>) {
    %c200 = arith.constant 200 : index
    air.launch (%arg3) in (%arg4=%c200) args(%arg5=%arg0, %arg6=%arg1, %arg7=%arg2) : memref<?xf32>, memref<?xf32>, memref<?xf32> {
      air.segment @matadd_0  args(%arg8=%arg3, %arg9=%arg5, %arg10=%arg6, %arg11=%arg7) : index, memref<?xf32>, memref<?xf32>, memref<?xf32> {
        %0 = memref.load %arg9[%arg8] : memref<?xf32>
        %1 = memref.load %arg10[%arg8] : memref<?xf32>
        %2 = arith.addf %0, %1 : f32
        memref.store %2, %arg11[%arg8] : memref<?xf32>
      }
    }
    return
  }
}
