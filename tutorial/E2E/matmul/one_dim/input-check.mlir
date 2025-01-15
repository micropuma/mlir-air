module {
  func.func @matadd(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    scf.parallel (%arg3) = (%c0) to (%c2) step (%c1) {
      %c0_0 = arith.constant 0 : index
      %c2_1 = arith.constant 2 : index
      %c1_2 = arith.constant 1 : index
      scf.parallel (%arg4) = (%c0_0) to (%c2_1) step (%c1_2) {
        %0 = memref.load %arg0[%arg3, %arg4] : memref<2x2xf32>
        %1 = memref.load %arg1[%arg3, %arg4] : memref<2x2xf32>
        %2 = arith.addf %0, %1 : f32
        memref.store %2, %arg2[%arg3, %arg4] : memref<2x2xf32>
        scf.reduce 
      }
      scf.reduce 
    }
    return
  }
}
