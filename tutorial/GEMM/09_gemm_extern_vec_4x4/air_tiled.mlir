module {
  func.func @matadd(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>) {
    %c0 = arith.constant 0 : index
    %c200 = arith.constant 200 : index
    %c1 = arith.constant 1 : index
    scf.parallel (%arg3) = (%c0) to (%c200) step (%c1) {
      %0 = memref.load %arg0[%arg3] : memref<?xf32>
      %1 = memref.load %arg1[%arg3] : memref<?xf32>
      %2 = arith.addf %0, %1 : f32
      memref.store %2, %arg2[%arg3] : memref<?xf32>
      scf.reduce 
    }
    return
  }
}
