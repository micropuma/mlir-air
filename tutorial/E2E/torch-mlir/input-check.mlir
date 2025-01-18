module attributes {torch.debug_module_name = "LargeMatrixMultiplication"} {
  memref.global "private" @global_seed : memref<i64> = dense<0>
  func.func @forward(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %alloca = memref.alloca() {alignment = 64 : i64} : memref<2x2xf32>
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c2, %c2) step (%c1, %c1) {
      memref.store %cst, %alloca[%arg3, %arg4] : memref<2x2xf32>
      scf.reduce 
    }
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c2, %c2) step (%c1, %c1) {
      scf.for %arg5 = %c0 to %c2 step %c1 {
        %0 = memref.load %arg0[%arg3, %arg5] : memref<2x2xf32>
        %1 = memref.load %arg1[%arg5, %arg4] : memref<2x2xf32>
        %2 = memref.load %alloca[%arg3, %arg4] : memref<2x2xf32>
        %3 = arith.mulf %0, %1 : f32
        %4 = arith.addf %2, %3 : f32
        memref.store %4, %alloca[%arg3, %arg4] : memref<2x2xf32>
      }
      scf.reduce 
    }
    memref.copy %alloca, %arg2 : memref<2x2xf32> to memref<2x2xf32>
    return
  }
}
