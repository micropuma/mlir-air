; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@__airrt_shim_location_data = internal constant [1024 x i64] zeroinitializer
@__airrt_shim_channel_data = internal constant [1024 x i64] zeroinitializer
@__airrt_shim_descriptor = internal constant { ptr, ptr } { ptr @__airrt_shim_location_data, ptr @__airrt_shim_channel_data }
@__airrt_string_copyherd = internal constant [8 x i8] c"copyherd"
@__airrt_herd_descriptor = constant { i64, ptr, ptr } { i64 8, ptr @__airrt_string_copyherd, ptr @__airrt_shim_descriptor }
@__airrt_string_graph_0 = internal constant [7 x i8] c"graph_0"
@__airrt_segment_herd_descriptors = internal constant [1 x ptr] [ptr @__airrt_herd_descriptor]
@__airrt_segment_descriptor = constant { i64, ptr, i64, ptr } { i64 7, ptr @__airrt_string_graph_0, i64 1, ptr @__airrt_segment_herd_descriptors }
@__airrt_module_segment_descriptors = internal constant [1 x ptr] [ptr @__airrt_segment_descriptor]
@__airrt_module_descriptor = constant { i64, ptr } { i64 1, ptr @__airrt_module_segment_descriptors }

define private i64 @__airrt_segment_load(ptr %0) {
  %2 = call i64 @_mlir_ciface___airrt_segment_load(ptr %0)
  ret i64 %2
}

declare i64 @_mlir_ciface___airrt_segment_load(ptr)

define private i64 @__airrt_herd_load(ptr %0) {
  %2 = call i64 @_mlir_ciface___airrt_herd_load(ptr %0)
  ret i64 %2
}

declare i64 @_mlir_ciface___airrt_herd_load(ptr)

define void @graph(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9) {
  call void @__airrt_dma_nd_memcpy_1d0i32(ptr null, i32 3, i64 0, i64 0, ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 256, i64 0, i64 0, i64 0)
  call void @__airrt_dma_nd_memcpy_1d0i32(ptr null, i32 4, i64 0, i64 0, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 256, i64 0, i64 0, i64 0)
  br label %11

11:                                               ; preds = %28, %10
  %12 = phi i64 [ %29, %28 ], [ 0, %10 ]
  %13 = icmp slt i64 %12, 1
  br i1 %13, label %14, label %30

14:                                               ; preds = %11
  br label %15

15:                                               ; preds = %26, %14
  %16 = phi i64 [ %27, %26 ], [ 0, %14 ]
  %17 = icmp slt i64 %16, 1
  br i1 %17, label %18, label %28

18:                                               ; preds = %15
  %19 = call i64 @__airrt_segment_load(ptr @__airrt_string_graph_0)
  br label %20

20:                                               ; preds = %23, %18
  %21 = phi i64 [ %25, %23 ], [ 0, %18 ]
  %22 = icmp slt i64 %21, 1
  br i1 %22, label %23, label %26

23:                                               ; preds = %20
  %24 = call i64 @__airrt_herd_load(ptr @__airrt_string_copyherd)
  %25 = add i64 %21, 1
  br label %20

26:                                               ; preds = %20
  %27 = add i64 %16, 1
  br label %15

28:                                               ; preds = %15
  %29 = add i64 %12, 1
  br label %11

30:                                               ; preds = %11
  ret void
}

define void @_mlir_ciface_graph(ptr %0, ptr %1) {
  %3 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %0, align 8
  %4 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, 0
  %5 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, 1
  %6 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, 2
  %7 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, 3, 0
  %8 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, 4, 0
  %9 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %1, align 8
  %10 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, 0
  %11 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, 1
  %12 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, 2
  %13 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, 3, 0
  %14 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, 4, 0
  call void @graph(ptr %4, ptr %5, i64 %6, i64 %7, i64 %8, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14)
  ret void
}

define private void @__airrt_dma_nd_memcpy_1d0i32(ptr %0, i32 %1, i64 %2, i64 %3, ptr %4, ptr %5, i64 %6, i64 %7, i64 %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, i64 %14, i64 %15, i64 %16, i64 %17, i64 %18, i64 %19) {
  %21 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %4, 0
  %22 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %21, ptr %5, 1
  %23 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, i64 %6, 2
  %24 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %23, i64 %7, 3, 0
  %25 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %24, i64 %8, 4, 0
  %26 = alloca { ptr, ptr, i64, [1 x i64], [1 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, ptr %26, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_1d0i32(ptr %0, i32 %1, i64 %2, i64 %3, ptr %26, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, i64 %14, i64 %15, i64 %16, i64 %17, i64 %18, i64 %19)
  ret void
}

declare void @_mlir_ciface___airrt_dma_nd_memcpy_1d0i32(ptr, i32, i64, i64, ptr, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
