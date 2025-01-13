module {
  func.func @matadd(%arg0: memref<?x300xf32>, %arg1: memref<?x300xf32>, %arg2: memref<?x300xf32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c200 = arith.constant 200 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c300 = arith.constant 300 : index
    scf.for %arg3 = %c0 to %c200 step %c1 {
      scf.for %arg4 = %c0 to %c300 step %c1 {
        %0 = memref.load %arg0[%arg3, %arg4] : memref<?x300xf32>
        %1 = memref.load %arg1[%arg3, %arg4] : memref<?x300xf32>
        %2 = arith.addf %0, %1 : f32
        memref.store %2, %arg2[%arg3, %arg4] : memref<?x300xf32>
      }
    }
    return
  }
}
