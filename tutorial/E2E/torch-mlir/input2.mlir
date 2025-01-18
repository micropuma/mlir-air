module attributes {torch.debug_module_name = "LargeMatrixMultiplication"} {
  memref.global "private" @global_seed : memref<i64> = dense<0>
  func.func @forward(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c2 = arith.constant 2 : index
    %alloca = memref.alloc() {alignment = 64 : i64} : memref<2x2xf32>
    air.herd @herd_0  tile (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%alloca) : memref<2x2xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      memref.store %cst, %arg7[%arg3, %arg4] : memref<2x2xf32>
    }
    air.herd @herd_1  tile (%arg3, %arg4) in (%arg5=%c2, %arg6=%c2) args(%arg7=%arg0, %arg8=%arg1, %arg9=%alloca) : memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32> {
      %c0 = arith.constant 0 : index
      %c2_0 = arith.constant 2 : index
      %c1 = arith.constant 1 : index
      scf.for %arg10 = %c0 to %c2_0 step %c1 {
        %0 = memref.load %arg7[%arg3, %arg10] : memref<2x2xf32>
        %1 = memref.load %arg8[%arg10, %arg4] : memref<2x2xf32>
        %2 = memref.load %arg9[%arg3, %arg4] : memref<2x2xf32>
        %3 = arith.mulf %0, %1 : f32
        %4 = arith.addf %2, %3 : f32
        memref.store %4, %arg9[%arg3, %arg4] : memref<2x2xf32>
      }
    }
    memref.copy %alloca, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    return
  }
}
