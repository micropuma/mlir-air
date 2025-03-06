; ModuleID = 'tmp/onedim.opt.bc'
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
@__airrt_module_descriptor = local_unnamed_addr constant { i64, ptr } { i64 1, ptr @__airrt_module_segment_descriptors }

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #0

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #1

declare i64 @_mlir_ciface___airrt_segment_load(ptr) local_unnamed_addr

declare i64 @_mlir_ciface___airrt_herd_load(ptr) local_unnamed_addr

define void @matadd(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr nocapture readnone %14, ptr nocapture writeonly %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20) local_unnamed_addr {
.preheader21:
  %21 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, align 8
  %22 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, align 8
  %23 = alloca { ptr, ptr, i64, [2 x i64], [2 x i64] }, align 8
  %24 = tail call dereferenceable_or_null(16) ptr @malloc(i64 16)
  %.fca.1.gep.i = getelementptr inbounds i8, ptr %23, i64 8
  %.fca.2.gep.i = getelementptr inbounds i8, ptr %23, i64 16
  %.fca.3.0.gep.i = getelementptr inbounds i8, ptr %23, i64 24
  %.fca.3.1.gep.i = getelementptr inbounds i8, ptr %23, i64 32
  %.fca.4.0.gep.i = getelementptr inbounds i8, ptr %23, i64 40
  %.fca.4.1.gep.i = getelementptr inbounds i8, ptr %23, i64 48
  %25 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %23)
  store ptr %0, ptr %23, align 8
  store ptr %1, ptr %.fca.1.gep.i, align 8
  store i64 %2, ptr %.fca.2.gep.i, align 8
  store i64 %3, ptr %.fca.3.0.gep.i, align 8
  store i64 %4, ptr %.fca.3.1.gep.i, align 8
  store i64 %5, ptr %.fca.4.0.gep.i, align 8
  store i64 %6, ptr %.fca.4.1.gep.i, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %25, i32 4, i64 0, i64 0, ptr nonnull %23, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %23)
  %26 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %23)
  store ptr %0, ptr %23, align 8
  store ptr %1, ptr %.fca.1.gep.i, align 8
  store i64 %2, ptr %.fca.2.gep.i, align 8
  store i64 %3, ptr %.fca.3.0.gep.i, align 8
  store i64 %4, ptr %.fca.3.1.gep.i, align 8
  store i64 %5, ptr %.fca.4.0.gep.i, align 8
  store i64 %6, ptr %.fca.4.1.gep.i, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %26, i32 4, i64 0, i64 1, ptr nonnull %23, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %23)
  %27 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %23)
  store ptr %0, ptr %23, align 8
  store ptr %1, ptr %.fca.1.gep.i, align 8
  store i64 %2, ptr %.fca.2.gep.i, align 8
  store i64 %3, ptr %.fca.3.0.gep.i, align 8
  store i64 %4, ptr %.fca.3.1.gep.i, align 8
  store i64 %5, ptr %.fca.4.0.gep.i, align 8
  store i64 %6, ptr %.fca.4.1.gep.i, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %27, i32 4, i64 1, i64 0, ptr nonnull %23, i64 0, i64 0, i64 1, i64 0, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %23)
  %28 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %23)
  store ptr %0, ptr %23, align 8
  store ptr %1, ptr %.fca.1.gep.i, align 8
  store i64 %2, ptr %.fca.2.gep.i, align 8
  store i64 %3, ptr %.fca.3.0.gep.i, align 8
  store i64 %4, ptr %.fca.3.1.gep.i, align 8
  store i64 %5, ptr %.fca.4.0.gep.i, align 8
  store i64 %6, ptr %.fca.4.1.gep.i, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %28, i32 4, i64 1, i64 1, ptr nonnull %23, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %23)
  %.fca.1.gep.i6 = getelementptr inbounds i8, ptr %22, i64 8
  %.fca.2.gep.i7 = getelementptr inbounds i8, ptr %22, i64 16
  %.fca.3.0.gep.i8 = getelementptr inbounds i8, ptr %22, i64 24
  %.fca.3.1.gep.i9 = getelementptr inbounds i8, ptr %22, i64 32
  %.fca.4.0.gep.i10 = getelementptr inbounds i8, ptr %22, i64 40
  %.fca.4.1.gep.i11 = getelementptr inbounds i8, ptr %22, i64 48
  %29 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %22)
  store ptr %7, ptr %22, align 8
  store ptr %8, ptr %.fca.1.gep.i6, align 8
  store i64 %9, ptr %.fca.2.gep.i7, align 8
  store i64 %10, ptr %.fca.3.0.gep.i8, align 8
  store i64 %11, ptr %.fca.3.1.gep.i9, align 8
  store i64 %12, ptr %.fca.4.0.gep.i10, align 8
  store i64 %13, ptr %.fca.4.1.gep.i11, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %29, i32 5, i64 0, i64 0, ptr nonnull %22, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %22)
  %30 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %22)
  store ptr %7, ptr %22, align 8
  store ptr %8, ptr %.fca.1.gep.i6, align 8
  store i64 %9, ptr %.fca.2.gep.i7, align 8
  store i64 %10, ptr %.fca.3.0.gep.i8, align 8
  store i64 %11, ptr %.fca.3.1.gep.i9, align 8
  store i64 %12, ptr %.fca.4.0.gep.i10, align 8
  store i64 %13, ptr %.fca.4.1.gep.i11, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %30, i32 5, i64 0, i64 1, ptr nonnull %22, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %22)
  %31 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %22)
  store ptr %7, ptr %22, align 8
  store ptr %8, ptr %.fca.1.gep.i6, align 8
  store i64 %9, ptr %.fca.2.gep.i7, align 8
  store i64 %10, ptr %.fca.3.0.gep.i8, align 8
  store i64 %11, ptr %.fca.3.1.gep.i9, align 8
  store i64 %12, ptr %.fca.4.0.gep.i10, align 8
  store i64 %13, ptr %.fca.4.1.gep.i11, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %31, i32 5, i64 1, i64 0, ptr nonnull %22, i64 0, i64 0, i64 1, i64 0, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %22)
  %32 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %22)
  store ptr %7, ptr %22, align 8
  store ptr %8, ptr %.fca.1.gep.i6, align 8
  store i64 %9, ptr %.fca.2.gep.i7, align 8
  store i64 %10, ptr %.fca.3.0.gep.i8, align 8
  store i64 %11, ptr %.fca.3.1.gep.i9, align 8
  store i64 %12, ptr %.fca.4.0.gep.i10, align 8
  store i64 %13, ptr %.fca.4.1.gep.i11, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %32, i32 5, i64 1, i64 1, ptr nonnull %22, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %22)
  %.fca.1.gep.i12 = getelementptr inbounds i8, ptr %21, i64 8
  %.fca.2.gep.i13 = getelementptr inbounds i8, ptr %21, i64 16
  %.fca.3.0.gep.i14 = getelementptr inbounds i8, ptr %21, i64 24
  %.fca.3.1.gep.i15 = getelementptr inbounds i8, ptr %21, i64 32
  %.fca.4.0.gep.i16 = getelementptr inbounds i8, ptr %21, i64 40
  %.fca.4.1.gep.i17 = getelementptr inbounds i8, ptr %21, i64 48
  %33 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %21)
  store ptr %24, ptr %21, align 8
  store ptr %24, ptr %.fca.1.gep.i12, align 8
  store i64 0, ptr %.fca.2.gep.i13, align 8
  store i64 2, ptr %.fca.3.0.gep.i14, align 8
  store i64 2, ptr %.fca.3.1.gep.i15, align 8
  store i64 2, ptr %.fca.4.0.gep.i16, align 8
  store i64 1, ptr %.fca.4.1.gep.i17, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %33, i32 6, i64 0, i64 0, ptr nonnull %21, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %21)
  %34 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %21)
  store ptr %24, ptr %21, align 8
  store ptr %24, ptr %.fca.1.gep.i12, align 8
  store i64 0, ptr %.fca.2.gep.i13, align 8
  store i64 2, ptr %.fca.3.0.gep.i14, align 8
  store i64 2, ptr %.fca.3.1.gep.i15, align 8
  store i64 2, ptr %.fca.4.0.gep.i16, align 8
  store i64 1, ptr %.fca.4.1.gep.i17, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %34, i32 6, i64 0, i64 1, ptr nonnull %21, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %21)
  %35 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %21)
  store ptr %24, ptr %21, align 8
  store ptr %24, ptr %.fca.1.gep.i12, align 8
  store i64 0, ptr %.fca.2.gep.i13, align 8
  store i64 2, ptr %.fca.3.0.gep.i14, align 8
  store i64 2, ptr %.fca.3.1.gep.i15, align 8
  store i64 2, ptr %.fca.4.0.gep.i16, align 8
  store i64 1, ptr %.fca.4.1.gep.i17, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %35, i32 6, i64 1, i64 0, ptr nonnull %21, i64 0, i64 0, i64 1, i64 0, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %21)
  %36 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %21)
  store ptr %24, ptr %21, align 8
  store ptr %24, ptr %.fca.1.gep.i12, align 8
  store i64 0, ptr %.fca.2.gep.i13, align 8
  store i64 2, ptr %.fca.3.0.gep.i14, align 8
  store i64 2, ptr %.fca.3.1.gep.i15, align 8
  store i64 2, ptr %.fca.4.0.gep.i16, align 8
  store i64 1, ptr %.fca.4.1.gep.i17, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr nonnull %36, i32 6, i64 1, i64 1, ptr nonnull %21, i64 0, i64 0, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 0, i64 0, i64 2)
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %21)
  %37 = call i64 @_mlir_ciface___airrt_segment_load(ptr nonnull @__airrt_string_matadd_0)
  %38 = call i64 @_mlir_ciface___airrt_herd_load(ptr nonnull @__airrt_string_herd_0)
  %39 = getelementptr float, ptr %15, i64 %16
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(16) %39, ptr noundef nonnull align 1 dereferenceable(16) %24, i64 16, i1 false)
  call void @free(ptr %24)
  ret void
}

define void @_mlir_ciface_matadd(ptr nocapture readonly %0, ptr nocapture readonly %1, ptr nocapture readonly %2) local_unnamed_addr {
  %.unpack = load ptr, ptr %0, align 8
  %.elt1 = getelementptr inbounds i8, ptr %0, i64 8
  %.unpack2 = load ptr, ptr %.elt1, align 8
  %.elt3 = getelementptr inbounds i8, ptr %0, i64 16
  %.unpack4 = load i64, ptr %.elt3, align 8
  %.elt5 = getelementptr inbounds i8, ptr %0, i64 24
  %.unpack6.unpack = load i64, ptr %.elt5, align 8
  %.unpack6.elt9 = getelementptr inbounds i8, ptr %0, i64 32
  %.unpack6.unpack10 = load i64, ptr %.unpack6.elt9, align 8
  %.elt7 = getelementptr inbounds i8, ptr %0, i64 40
  %.unpack8.unpack = load i64, ptr %.elt7, align 8
  %.unpack8.elt12 = getelementptr inbounds i8, ptr %0, i64 48
  %.unpack8.unpack13 = load i64, ptr %.unpack8.elt12, align 8
  %.unpack15 = load ptr, ptr %1, align 8
  %.elt16 = getelementptr inbounds i8, ptr %1, i64 8
  %.unpack17 = load ptr, ptr %.elt16, align 8
  %.elt18 = getelementptr inbounds i8, ptr %1, i64 16
  %.unpack19 = load i64, ptr %.elt18, align 8
  %.elt20 = getelementptr inbounds i8, ptr %1, i64 24
  %.unpack21.unpack = load i64, ptr %.elt20, align 8
  %.unpack21.elt24 = getelementptr inbounds i8, ptr %1, i64 32
  %.unpack21.unpack25 = load i64, ptr %.unpack21.elt24, align 8
  %.elt22 = getelementptr inbounds i8, ptr %1, i64 40
  %.unpack23.unpack = load i64, ptr %.elt22, align 8
  %.unpack23.elt27 = getelementptr inbounds i8, ptr %1, i64 48
  %.unpack23.unpack28 = load i64, ptr %.unpack23.elt27, align 8
  %.elt31 = getelementptr inbounds i8, ptr %2, i64 8
  %.unpack32 = load ptr, ptr %.elt31, align 8
  %.elt33 = getelementptr inbounds i8, ptr %2, i64 16
  %.unpack34 = load i64, ptr %.elt33, align 8
  tail call void @matadd(ptr %.unpack, ptr %.unpack2, i64 %.unpack4, i64 %.unpack6.unpack, i64 %.unpack6.unpack10, i64 %.unpack8.unpack, i64 %.unpack8.unpack13, ptr %.unpack15, ptr %.unpack17, i64 %.unpack19, i64 %.unpack21.unpack, i64 %.unpack21.unpack25, i64 %.unpack23.unpack, i64 %.unpack23.unpack28, ptr poison, ptr %.unpack32, i64 %.unpack34, i64 poison, i64 poison, i64 poison, i64 poison)
  ret void
}

declare void @_mlir_ciface___airrt_dma_nd_memcpy_2d0f32(ptr, i32, i64, i64, ptr, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64) local_unnamed_addr

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #3

attributes #0 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
