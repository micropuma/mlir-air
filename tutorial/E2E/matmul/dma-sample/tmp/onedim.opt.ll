; ModuleID = 'tmp/onedim.opt.bc'
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
@__airrt_module_descriptor = local_unnamed_addr constant { i64, ptr } { i64 1, ptr @__airrt_module_segment_descriptors }

declare i64 @_mlir_ciface___airrt_segment_load(ptr) local_unnamed_addr

declare i64 @_mlir_ciface___airrt_herd_load(ptr) local_unnamed_addr

define void @graph(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9) local_unnamed_addr {
.critedge.critedge:
  %10 = alloca { ptr, ptr, i64, [1 x i64], [1 x i64] }, align 8
  %11 = alloca { ptr, ptr, i64, [1 x i64], [1 x i64] }, align 8
  call void @llvm.lifetime.start.p0(i64 40, ptr nonnull %11)
  store ptr %0, ptr %11, align 8
  %.fca.1.gep.i = getelementptr inbounds i8, ptr %11, i64 8
  store ptr %1, ptr %.fca.1.gep.i, align 8
  %.fca.2.gep.i = getelementptr inbounds i8, ptr %11, i64 16
  store i64 %2, ptr %.fca.2.gep.i, align 8
  %.fca.3.0.gep.i = getelementptr inbounds i8, ptr %11, i64 24
  store i64 %3, ptr %.fca.3.0.gep.i, align 8
  %.fca.4.0.gep.i = getelementptr inbounds i8, ptr %11, i64 32
  store i64 %4, ptr %.fca.4.0.gep.i, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_1d0i32(ptr null, i32 3, i64 0, i64 0, ptr nonnull %11, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 256, i64 0, i64 0, i64 0)
  call void @llvm.lifetime.end.p0(i64 40, ptr nonnull %11)
  call void @llvm.lifetime.start.p0(i64 40, ptr nonnull %10)
  store ptr %5, ptr %10, align 8
  %.fca.1.gep.i3 = getelementptr inbounds i8, ptr %10, i64 8
  store ptr %6, ptr %.fca.1.gep.i3, align 8
  %.fca.2.gep.i4 = getelementptr inbounds i8, ptr %10, i64 16
  store i64 %7, ptr %.fca.2.gep.i4, align 8
  %.fca.3.0.gep.i5 = getelementptr inbounds i8, ptr %10, i64 24
  store i64 %8, ptr %.fca.3.0.gep.i5, align 8
  %.fca.4.0.gep.i6 = getelementptr inbounds i8, ptr %10, i64 32
  store i64 %9, ptr %.fca.4.0.gep.i6, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_1d0i32(ptr null, i32 4, i64 0, i64 0, ptr nonnull %10, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 256, i64 0, i64 0, i64 0)
  call void @llvm.lifetime.end.p0(i64 40, ptr nonnull %10)
  %12 = call i64 @_mlir_ciface___airrt_segment_load(ptr nonnull @__airrt_string_graph_0)
  %13 = call i64 @_mlir_ciface___airrt_herd_load(ptr nonnull @__airrt_string_copyherd)
  ret void
}

define void @_mlir_ciface_graph(ptr nocapture readonly %0, ptr nocapture readonly %1) local_unnamed_addr {
  %3 = alloca { ptr, ptr, i64, [1 x i64], [1 x i64] }, align 8
  %4 = alloca { ptr, ptr, i64, [1 x i64], [1 x i64] }, align 8
  %.unpack = load ptr, ptr %0, align 8
  %.elt1 = getelementptr inbounds i8, ptr %0, i64 8
  %.unpack2 = load ptr, ptr %.elt1, align 8
  %.elt3 = getelementptr inbounds i8, ptr %0, i64 16
  %.unpack4 = load i64, ptr %.elt3, align 8
  %.elt5 = getelementptr inbounds i8, ptr %0, i64 24
  %.unpack6.unpack = load i64, ptr %.elt5, align 8
  %.elt7 = getelementptr inbounds i8, ptr %0, i64 32
  %.unpack8.unpack = load i64, ptr %.elt7, align 8
  %.unpack11 = load ptr, ptr %1, align 8
  %.elt12 = getelementptr inbounds i8, ptr %1, i64 8
  %.unpack13 = load ptr, ptr %.elt12, align 8
  %.elt14 = getelementptr inbounds i8, ptr %1, i64 16
  %.unpack15 = load i64, ptr %.elt14, align 8
  %.elt16 = getelementptr inbounds i8, ptr %1, i64 24
  %.unpack17.unpack = load i64, ptr %.elt16, align 8
  %.elt18 = getelementptr inbounds i8, ptr %1, i64 32
  %.unpack19.unpack = load i64, ptr %.elt18, align 8
  call void @llvm.lifetime.start.p0(i64 40, ptr nonnull %4)
  store ptr %.unpack, ptr %4, align 8
  %.fca.1.gep.i.i = getelementptr inbounds i8, ptr %4, i64 8
  store ptr %.unpack2, ptr %.fca.1.gep.i.i, align 8
  %.fca.2.gep.i.i = getelementptr inbounds i8, ptr %4, i64 16
  store i64 %.unpack4, ptr %.fca.2.gep.i.i, align 8
  %.fca.3.0.gep.i.i = getelementptr inbounds i8, ptr %4, i64 24
  store i64 %.unpack6.unpack, ptr %.fca.3.0.gep.i.i, align 8
  %.fca.4.0.gep.i.i = getelementptr inbounds i8, ptr %4, i64 32
  store i64 %.unpack8.unpack, ptr %.fca.4.0.gep.i.i, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_1d0i32(ptr null, i32 3, i64 0, i64 0, ptr nonnull %4, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 256, i64 0, i64 0, i64 0)
  call void @llvm.lifetime.end.p0(i64 40, ptr nonnull %4)
  call void @llvm.lifetime.start.p0(i64 40, ptr nonnull %3)
  store ptr %.unpack11, ptr %3, align 8
  %.fca.1.gep.i3.i = getelementptr inbounds i8, ptr %3, i64 8
  store ptr %.unpack13, ptr %.fca.1.gep.i3.i, align 8
  %.fca.2.gep.i4.i = getelementptr inbounds i8, ptr %3, i64 16
  store i64 %.unpack15, ptr %.fca.2.gep.i4.i, align 8
  %.fca.3.0.gep.i5.i = getelementptr inbounds i8, ptr %3, i64 24
  store i64 %.unpack17.unpack, ptr %.fca.3.0.gep.i5.i, align 8
  %.fca.4.0.gep.i6.i = getelementptr inbounds i8, ptr %3, i64 32
  store i64 %.unpack19.unpack, ptr %.fca.4.0.gep.i6.i, align 8
  call void @_mlir_ciface___airrt_dma_nd_memcpy_1d0i32(ptr null, i32 4, i64 0, i64 0, ptr nonnull %3, i64 0, i64 0, i64 0, i64 0, i64 1, i64 1, i64 1, i64 256, i64 0, i64 0, i64 0)
  call void @llvm.lifetime.end.p0(i64 40, ptr nonnull %3)
  %5 = call i64 @_mlir_ciface___airrt_segment_load(ptr nonnull @__airrt_string_graph_0)
  %6 = call i64 @_mlir_ciface___airrt_herd_load(ptr nonnull @__airrt_string_copyherd)
  ret void
}

declare void @_mlir_ciface___airrt_dma_nd_memcpy_1d0i32(ptr, i32, i64, i64, ptr, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64) local_unnamed_addr

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
