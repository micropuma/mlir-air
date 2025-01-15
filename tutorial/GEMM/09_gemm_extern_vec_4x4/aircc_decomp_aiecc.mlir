module {
  aie.device(npu1_4col) {
    %tile_0_1 = aie.tile(0, 1)
    %tile_1_1 = aie.tile(1, 1)
    %tile_2_1 = aie.tile(2, 1)
    %tile_3_1 = aie.tile(3, 1)
    %__L2_tmp3 = aie.buffer(%tile_3_1) {sym_name = "__L2_tmp3"} : memref<1xi8> 
    %__L2_tmp2 = aie.buffer(%tile_2_1) {sym_name = "__L2_tmp2"} : memref<1xi8> 
    %__L2_tmp1 = aie.buffer(%tile_1_1) {sym_name = "__L2_tmp1"} : memref<1xi8> 
    %__L2_tmp0 = aie.buffer(%tile_0_1) {sym_name = "__L2_tmp0"} : memref<1xi8> 
  } {sym_name = "matadd_0"}
  airrt.module_metadata{
  }
  func.func @matadd(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>) {
    %c200 = arith.constant 200 : index
    %0 = air.launch async (%arg3) in (%arg4=%c200) args(%arg5=%arg0, %arg6=%arg1, %arg7=%arg2) : memref<?xf32>, memref<?xf32>, memref<?xf32> attributes {id = 1 : i32} {
      %1 = air.segment @matadd_0 async  args(%arg8=%arg3, %arg9=%arg5, %arg10=%arg6, %arg11=%arg7) : index, memref<?xf32>, memref<?xf32>, memref<?xf32> attributes {id = 2 : i32, x_loc = 0 : i64, x_size = 4 : i64, y_loc = 2 : i64, y_size = 4 : i64} {
        %async_token, %results = air.execute -> (f32) {
          %3 = memref.load %arg9[%arg8] : memref<?xf32>
          air.execute_terminator %3 : f32
        }
        %async_token_0, %results_1 = air.execute -> (f32) {
          %3 = memref.load %arg10[%arg8] : memref<?xf32>
          air.execute_terminator %3 : f32
        }
        %2 = arith.addf %results, %results_1 : f32
        %async_token_2 = air.execute {
          memref.store %2, %arg11[%arg8] : memref<?xf32>
        }
      }
    }
    return
  }
}
