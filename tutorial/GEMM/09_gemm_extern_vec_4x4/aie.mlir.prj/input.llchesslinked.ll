; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target triple = "aie2"

%struct.ipd.custom_type.uint2_t.uint2_t = type { i2 }

@buf0 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf1 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf2 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf3 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf4 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf5 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf6 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf7 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf8 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf9 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf10 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf11 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf12 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf13 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf14 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf15 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf16 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf17 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf18 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf19 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf20 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf21 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf22 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf23 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf24 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf25 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf26 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf27 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf28 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf29 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf30 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf31 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf32 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf33 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf34 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf35 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf36 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf37 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf38 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf39 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf40 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf41 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf42 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf43 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf44 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf45 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf46 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf47 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf48 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf49 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf50 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf51 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf52 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf53 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf54 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf55 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf56 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf57 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf58 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf59 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf60 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf61 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf62 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf63 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf64 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf65 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf66 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf67 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf68 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf69 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf70 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf71 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf72 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf73 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf74 = external global [16 x [16 x [4 x [4 x bfloat]]]]
@buf75 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf76 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf77 = external global [8 x [16 x [4 x [8 x bfloat]]]]
@buf78 = external global [16 x [8 x [8 x [4 x bfloat]]]]
@buf79 = external global [16 x [16 x [4 x [4 x bfloat]]]]

define void @core_0_2() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf4 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf4)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf1 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf0 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf1, ptr @buf0, ptr @buf4)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf3 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf2 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf2, ptr @buf3, ptr @buf4)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

declare void @llvm.aie2.acquire(i32, i32)

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #0

declare void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat, ptr)

declare void @matmul_bf16_bf16(ptr, ptr, ptr)

declare void @llvm.aie2.release(i32, i32)

define void @core_1_2() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf9 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf9)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf6 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf5 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf6, ptr @buf5, ptr @buf9)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf8 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf7 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf7, ptr @buf8, ptr @buf9)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_2_2() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf14 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf14)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf11 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf10 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf11, ptr @buf10, ptr @buf14)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf13 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf12 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf12, ptr @buf13, ptr @buf14)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_3_2() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf19 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf19)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf16 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf15 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf16, ptr @buf15, ptr @buf19)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf18 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf17 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf17, ptr @buf18, ptr @buf19)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_0_3() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf24 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf24)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf21 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf20 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf21, ptr @buf20, ptr @buf24)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf23 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf22 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf22, ptr @buf23, ptr @buf24)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_1_3() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf29 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf29)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf26 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf25 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf26, ptr @buf25, ptr @buf29)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf28 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf27 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf27, ptr @buf28, ptr @buf29)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_2_3() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf34 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf34)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf31 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf30 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf31, ptr @buf30, ptr @buf34)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf33 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf32 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf32, ptr @buf33, ptr @buf34)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_3_3() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf39 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf39)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf36 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf35 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf36, ptr @buf35, ptr @buf39)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf38 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf37 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf37, ptr @buf38, ptr @buf39)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_0_4() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf44 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf44)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf41 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf40 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf41, ptr @buf40, ptr @buf44)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf43 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf42 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf42, ptr @buf43, ptr @buf44)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_1_4() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf49 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf49)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf46 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf45 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf46, ptr @buf45, ptr @buf49)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf48 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf47 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf47, ptr @buf48, ptr @buf49)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_2_4() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf54 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf54)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf51 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf50 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf51, ptr @buf50, ptr @buf54)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf53 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf52 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf52, ptr @buf53, ptr @buf54)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_3_4() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf59 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf59)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf56 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf55 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf56, ptr @buf55, ptr @buf59)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf58 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf57 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf57, ptr @buf58, ptr @buf59)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_0_5() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf64 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf64)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf61 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf60 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf61, ptr @buf60, ptr @buf64)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf63 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf62 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf62, ptr @buf63, ptr @buf64)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_1_5() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf69 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf69)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf66 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf65 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf66, ptr @buf65, ptr @buf69)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf68 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf67 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf67, ptr @buf68, ptr @buf69)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_2_5() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf74 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf74)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf71 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf70 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf71, ptr @buf70, ptr @buf74)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf73 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf72 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf72, ptr @buf73, ptr @buf74)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

define void @core_3_5() {
  br label %1

1:                                                ; preds = %17, %0
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  %2 = and i64 ptrtoint (ptr @buf79 to i64), 31
  %3 = icmp eq i64 %2, 0
  call void @llvm.assume(i1 %3)
  call void @linalg_fill_bf16_view16x16x4x4xbf16as2(bfloat 0xR0000, ptr @buf79)
  br label %4

4:                                                ; preds = %7, %1
  %5 = phi i64 [ %16, %7 ], [ 0, %1 ]
  %6 = icmp slt i64 %5, 128
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %8 = and i64 ptrtoint (ptr @buf76 to i64), 31
  %9 = icmp eq i64 %8, 0
  call void @llvm.assume(i1 %9)
  %10 = and i64 ptrtoint (ptr @buf75 to i64), 31
  %11 = icmp eq i64 %10, 0
  call void @llvm.assume(i1 %11)
  call void @matmul_bf16_bf16(ptr @buf76, ptr @buf75, ptr @buf79)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  call void @llvm.assume(i1 %3)
  %12 = and i64 ptrtoint (ptr @buf78 to i64), 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = and i64 ptrtoint (ptr @buf77 to i64), 31
  %15 = icmp eq i64 %14, 0
  call void @llvm.assume(i1 %15)
  call void @matmul_bf16_bf16(ptr @buf77, ptr @buf78, ptr @buf79)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.release(i32 53, i32 1)
  %16 = add i64 %5, 16
  br label %4

17:                                               ; preds = %4
  call void @llvm.aie2.release(i32 48, i32 1)
  br label %1
}

; Function Attrs: mustprogress nounwind
define dso_local void @llvm___aie2___acquire(i32 noundef %0, i32 noundef %1) local_unnamed_addr addrspace(1) #1 {
  tail call addrspace(1) void @llvm.chess_memory_fence()
  tail call addrspace(1) void @_Z25chess_separator_schedulerv() #5
  tail call x86_regcallcc addrspace(1) void @__regcall3__chessintr_void_acquire_guarded___uint___uint(i32 zeroext %0, i32 zeroext %1) #5
  tail call addrspace(1) void @_Z25chess_separator_schedulerv() #5
  tail call addrspace(1) void @llvm.chess_memory_fence()
  ret void
}

; Function Attrs: nounwind willreturn
declare void @llvm.chess_memory_fence() addrspace(1) #2

; Function Attrs: inaccessiblememonly nounwind
declare dso_local void @_Z25chess_separator_schedulerv() local_unnamed_addr addrspace(1) #3

; Function Attrs: inaccessiblememonly nounwind
declare dso_local x86_regcallcc void @__regcall3__chessintr_void_acquire_guarded___uint___uint(i32 zeroext, i32 zeroext) local_unnamed_addr addrspace(1) #3

; Function Attrs: mustprogress nounwind
define dso_local void @llvm___aie2___release(i32 noundef %0, i32 noundef %1) local_unnamed_addr addrspace(1) #1 {
  tail call addrspace(1) void @llvm.chess_memory_fence()
  tail call addrspace(1) void @_Z25chess_separator_schedulerv() #5
  tail call x86_regcallcc addrspace(1) void @__regcall3__chessintr_void_release_guarded___uint___sint(i32 zeroext %0, i32 signext %1) #5
  tail call addrspace(1) void @_Z25chess_separator_schedulerv() #5
  tail call addrspace(1) void @llvm.chess_memory_fence()
  ret void
}

; Function Attrs: inaccessiblememonly nounwind
declare dso_local x86_regcallcc void @__regcall3__chessintr_void_release_guarded___uint___sint(i32 zeroext, i32 signext) local_unnamed_addr addrspace(1) #3

; Function Attrs: nounwind
define dso_local void @llvm___aie___event0() local_unnamed_addr addrspace(1) #4 {
  tail call x86_regcallcc addrspace(1) void @__regcall3__chessintr_void_event_uint2_t(%struct.ipd.custom_type.uint2_t.uint2_t zeroinitializer) #5
  ret void
}

; Function Attrs: inaccessiblememonly nounwind
declare dso_local x86_regcallcc void @__regcall3__chessintr_void_event_uint2_t(%struct.ipd.custom_type.uint2_t.uint2_t) local_unnamed_addr addrspace(1) #3

; Function Attrs: nounwind
define dso_local void @llvm___aie___event1() local_unnamed_addr addrspace(1) #4 {
  tail call x86_regcallcc addrspace(1) void @__regcall3__chessintr_void_event_uint2_t(%struct.ipd.custom_type.uint2_t.uint2_t { i2 1 }) #5
  ret void
}

attributes #0 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
attributes #1 = { mustprogress nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { nounwind willreturn }
attributes #3 = { inaccessiblememonly nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #4 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #5 = { inaccessiblememonly nounwind "no-builtin-memcpy" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.linker.options = !{}
!llvm.ident = !{!3}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 15.0.5 (/u/sgasip/ipd/repositories/llvm_ipd 3a25925e0239306412dac02da5e4c8c51ae722e8)"}
