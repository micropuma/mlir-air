; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@__airrt_shim_location_data = internal constant [1024 x i64] zeroinitializer
@__airrt_shim_channel_data = internal constant [1024 x i64] zeroinitializer
@__airrt_shim_descriptor = internal constant { ptr, ptr } { ptr @__airrt_shim_location_data, ptr @__airrt_shim_channel_data }
@__airrt_string_herd_0 = internal constant [6 x i8] c"herd_0"
@__airrt_herd_descriptor = constant { i64, ptr, ptr } { i64 6, ptr @__airrt_string_herd_0, ptr @__airrt_shim_descriptor }
@__airrt_string_matadd_0 = internal constant [8 x i8] c"matadd_0"
@__airrt_segment_herd_descriptors = internal constant [1 x ptr] [ptr @__airrt_herd_descriptor]
@__airrt_segment_descriptor = constant { i64, ptr, i64, ptr } { i64 8, ptr @__airrt_string_matadd_0, i64 1, ptr @__airrt_segment_herd_descriptors }
@__airrt_module_segment_descriptors = internal constant [1 x ptr] [ptr @__airrt_segment_descriptor]
@__airrt_module_descriptor = constant { i64, ptr } { i64 1, ptr @__airrt_module_segment_descriptors }

declare void @free(ptr)

declare ptr @malloc(i64)

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

define void @matadd(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20) {
  %22 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (float, ptr null, i32 4) to i64))
  br label %23

23:                                               ; preds = %33, %21
  %24 = phi i64 [ %34, %33 ], [ 0, %21 ]
  %25 = icmp slt i64 %24, 2
  br i1 %25, label %26, label %35

26:                                               ; preds = %23
  br label %27

27:                                               ; preds = %30, %26
  %28 = phi i64 [ %32, %30 ], [ 0, %26 ]
  %29 = icmp slt i64 %28, 2
  br i1 %29, label %30, label %33

30:                                               ; preds = %27
  %31 = alloca i32, align 4
  call void @__airrt_dma_nd_memcpy_2d0f32(ptr %31, i32 4, i64 %24, i64 %28, ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 0, i64 0, i64 %24, i64 %28, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  %32 = add i64 %28, 1
  br label %27

33:                                               ; preds = %27
  %34 = add i64 %24, 1
  br label %23

35:                                               ; preds = %23
  br label %36

36:                                               ; preds = %46, %35
  %37 = phi i64 [ %47, %46 ], [ 0, %35 ]
  %38 = icmp slt i64 %37, 2
  br i1 %38, label %39, label %48

39:                                               ; preds = %36
  br label %40

40:                                               ; preds = %43, %39
  %41 = phi i64 [ %45, %43 ], [ 0, %39 ]
  %42 = icmp slt i64 %41, 2
  br i1 %42, label %43, label %46

43:                                               ; preds = %40
  %44 = alloca i32, align 4
  call void @__airrt_dma_nd_memcpy_2d0f32(ptr %44, i32 5, i64 %37, i64 %41, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, i64 0, i64 0, i64 %37, i64 %41, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  %45 = add i64 %41, 1
  br label %40

46:                                               ; preds = %40
  %47 = add i64 %37, 1
  br label %36

48:                                               ; preds = %36
  br label %49

49:                                               ; preds = %59, %48
  %50 = phi i64 [ %60, %59 ], [ 0, %48 ]
  %51 = icmp slt i64 %50, 2
  br i1 %51, label %52, label %61

52:                                               ; preds = %49
  br label %53

53:                                               ; preds = %56, %52
  %54 = phi i64 [ %58, %56 ], [ 0, %52 ]
  %55 = icmp slt i64 %54, 2
  br i1 %55, label %56, label %59

56:                                               ; preds = %53
  %57 = alloca i32, align 4
  call void @__airrt_dma_nd_memcpy_2d0f32(ptr %57, i32 6, i64 %50, i64 %54, ptr %22, ptr %22, i64 0, i64 2, i64 2, i64 2, i64 1, i64 0, i64 0, i64 %50, i64 %54, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  %58 = add i64 %54, 1
  br label %53

59:                                               ; preds = %53
  %60 = add i64 %50, 1
  br label %49

61:                                               ; preds = %49
  br label %62

62:                                               ; preds = %79, %61
  %63 = phi i64 [ %80, %79 ], [ 0, %61 ]
  %64 = icmp slt i64 %63, 1
  br i1 %64, label %65, label %81

65:                                               ; preds = %62
  br label %66

66:                                               ; preds = %77, %65
  %67 = phi i64 [ %78, %77 ], [ 0, %65 ]
  %68 = icmp slt i64 %67, 1
  br i1 %68, label %69, label %79

69:                                               ; preds = %66
  %70 = call i64 @__airrt_segment_load(ptr @__airrt_string_matadd_0)
  br label %71

71:                                               ; preds = %74, %69
  %72 = phi i64 [ %76, %74 ], [ 0, %69 ]
  %73 = icmp slt i64 %72, 1
  br i1 %73, label %74, label %77

74:                                               ; preds = %71
  %75 = call i64 @__airrt_herd_load(ptr @__airrt_string_herd_0)
  %76 = add i64 %72, 1
  br label %71

77:                                               ; preds = %71
  %78 = add i64 %67, 1
  br label %66

79:                                               ; preds = %66
  %80 = add i64 %63, 1
  br label %62

81:                                               ; preds = %62
  %82 = getelementptr float, ptr %15, i64 %16
  call void @llvm.memcpy.p0.p0.i64(ptr %82, ptr %22, i64 mul (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), i64 4), i1 false)
  call void @free(ptr %22)
  ret void
}

define void @_mlir_ciface_matadd(ptr %0, ptr %1, ptr %2) {
  %4 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %0, align 8
  %5 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 0
  %6 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 1
  %7 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 2
  %8 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 3, 0
  %9 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 3, 1
  %10 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 4, 0
  %11 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 4, 1
  %12 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %1, align 8
  %13 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 0
  %14 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 1
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 2
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 3, 0
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 3, 1
  %18 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 4, 0
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 4, 1
  %20 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %2, align 8
  %21 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 0
  %22 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 1
  %23 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 2
  %24 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 3, 0
  %25 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 3, 1
  %26 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 4, 0
  %27 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 4, 1
  call void @matadd(ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, i64 %10, i64 %11, ptr %13, ptr %14, i64 %15, i64 %16, i64 %17, i64 %18, i64 %19, ptr %21, ptr %22, i64 %23, i64 %24, i64 %25, i64 %26, i64 %27)
  ret void
}

define private void @__airrt_dma_nd_memcpy_2d0f32(ptr %0, i32 %1, i64 %2, i64 %3, ptr %4, ptr %5, i64 %6, i64 %7, i64 %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, i64 %14, i64 %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20, i64 %21) {
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %4, 0
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, ptr %5, 1
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 %6, 2
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 %7, 3, 0
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 %9, 4, 0
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %27, i64 %8, 3, 1
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, i64 %10, 4, 1
  %30 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, ptr %30, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr %0, i32 %1, i64 %2, i64 %3, ptr %30, i64 %11, i64 %12, i64 %13, i64 %14, i64 %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20, i64 %21)
  ret void
}

declare void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr, i32, i64, i64, ptr, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
