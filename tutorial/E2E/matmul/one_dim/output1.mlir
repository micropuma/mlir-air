module {
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c1 = arith.constant 1 : index
    air.launch (%arg3, %arg4) in (%arg5=%c1, %arg6=%c1) args(%arg7=%arg0, %arg8=%arg1, %arg9=%arg2) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
      air.segment @matadd_0  args(%arg10=%arg7, %arg11=%arg8, %arg12=%arg9) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
        %c2 = arith.constant 2 : index
        air.herd @herd_0  tile (%arg13, %arg14) in (%arg15=%c2, %arg16=%c2) args(%arg17=%arg10, %arg18=%arg11, %arg19=%arg12) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
          %0 = memref.load %arg17[%arg13, %arg14] : memref<2x2xf32>
          %1 = memref.load %arg18[%arg13, %arg14] : memref<2x2xf32>
          %2 = arith.addf %0, %1 : f32
          memref.store %2, %arg19[%arg13, %arg14] : memref<2x2xf32>
        }
      }
    }
    return
  }
}

