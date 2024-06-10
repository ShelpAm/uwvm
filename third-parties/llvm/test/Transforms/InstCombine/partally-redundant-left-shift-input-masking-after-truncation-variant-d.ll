; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; If we have some pattern that leaves only some low bits set, and then performs
; left-shift of those bits, we can combine those two shifts into a shift+mask.

; There are many variants to this pattern:
;   d)  (trunc ((x & ((-1 << maskNbits) >> maskNbits)))) << shiftNbits
; simplify to:
;   ((trunc(x)) << shiftNbits) & (-1 >> ((-(maskNbits+shiftNbits))+32))

; Simple tests.

declare void @use32(i32)
declare void @use64(i64)

define i32 @t0_basic(i64 %x, i32 %nbits) {
; CHECK-LABEL: @t0_basic(
; CHECK-NEXT:    [[T0:%.*]] = zext i32 [[NBITS:%.*]] to i64
; CHECK-NEXT:    [[T1:%.*]] = shl nsw i64 -1, [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = lshr exact i64 [[T1]], [[T0]]
; CHECK-NEXT:    [[T3:%.*]] = add i32 [[NBITS]], -33
; CHECK-NEXT:    call void @use64(i64 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use32(i32 [[T3]])
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[X:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = shl i32 [[TMP1]], [[T3]]
; CHECK-NEXT:    [[T6:%.*]] = and i32 [[TMP2]], 2147483647
; CHECK-NEXT:    ret i32 [[T6]]
;
  %t0 = zext i32 %nbits to i64
  %t1 = shl i64 -1, %t0
  %t2 = lshr i64 %t1, %t0
  %t3 = add i32 %nbits, -33

  call void @use64(i64 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use32(i32 %t3)

  %t4 = and i64 %t2, %x
  %t5 = trunc i64 %t4 to i32
  %t6 = shl i32 %t5, %t3 ; shift is smaller than mask
  ret i32 %t6
}

; Vectors

declare void @use8xi32(<8 x i32>)
declare void @use8xi64(<8 x i64>)

define <8 x i32> @t1_vec_splat(<8 x i64> %x, <8 x i32> %nbits) {
; CHECK-LABEL: @t1_vec_splat(
; CHECK-NEXT:    [[T0:%.*]] = zext <8 x i32> [[NBITS:%.*]] to <8 x i64>
; CHECK-NEXT:    [[T1:%.*]] = shl nsw <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = lshr exact <8 x i64> [[T1]], [[T0]]
; CHECK-NEXT:    [[T3:%.*]] = add <8 x i32> [[NBITS]], <i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 -33>
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T0]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T1]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T2]])
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T3]])
; CHECK-NEXT:    [[TMP1:%.*]] = trunc <8 x i64> [[X:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = shl <8 x i32> [[TMP1]], [[T3]]
; CHECK-NEXT:    [[T6:%.*]] = and <8 x i32> [[TMP2]], <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; CHECK-NEXT:    ret <8 x i32> [[T6]]
;
  %t0 = zext <8 x i32> %nbits to <8 x i64>
  %t1 = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, %t0
  %t2 = lshr <8 x i64> %t1, %t0
  %t3 = add <8 x i32> %nbits, <i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 -33>

  call void @use8xi64(<8 x i64> %t0)
  call void @use8xi64(<8 x i64> %t1)
  call void @use8xi64(<8 x i64> %t2)
  call void @use8xi32(<8 x i32> %t3)

  %t4 = and <8 x i64> %t2, %x
  %t5 = trunc <8 x i64> %t4 to <8 x i32>
  %t6 = shl <8 x i32> %t5, %t3 ; shift is smaller than mask
  ret <8 x i32> %t6
}

define <8 x i32> @t2_vec_splat_undef(<8 x i64> %x, <8 x i32> %nbits) {
; CHECK-LABEL: @t2_vec_splat_undef(
; CHECK-NEXT:    [[T0:%.*]] = zext <8 x i32> [[NBITS:%.*]] to <8 x i64>
; CHECK-NEXT:    [[T1:%.*]] = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 undef, i64 -1>, [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = lshr exact <8 x i64> [[T1]], [[T0]]
; CHECK-NEXT:    [[T3:%.*]] = add <8 x i32> [[NBITS]], <i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 undef, i32 -33>
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T0]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T1]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T2]])
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T3]])
; CHECK-NEXT:    [[TMP1:%.*]] = trunc <8 x i64> [[X:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = shl <8 x i32> [[TMP1]], [[T3]]
; CHECK-NEXT:    [[T6:%.*]] = and <8 x i32> [[TMP2]], <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 poison, i32 2147483647>
; CHECK-NEXT:    ret <8 x i32> [[T6]]
;
  %t0 = zext <8 x i32> %nbits to <8 x i64>
  %t1 = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 undef, i64 -1>, %t0
  %t2 = lshr <8 x i64> %t1, %t0
  %t3 = add <8 x i32> %nbits, <i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 -33, i32 undef, i32 -33>

  call void @use8xi64(<8 x i64> %t0)
  call void @use8xi64(<8 x i64> %t1)
  call void @use8xi64(<8 x i64> %t2)
  call void @use8xi32(<8 x i32> %t3)

  %t4 = and <8 x i64> %t2, %x
  %t5 = trunc <8 x i64> %t4 to <8 x i32>
  %t6 = shl <8 x i32> %t5, %t3 ; shift is smaller than mask
  ret <8 x i32> %t6
}

define <8 x i32> @t3_vec_nonsplat(<8 x i64> %x, <8 x i32> %nbits) {
; CHECK-LABEL: @t3_vec_nonsplat(
; CHECK-NEXT:    [[T0:%.*]] = zext <8 x i32> [[NBITS:%.*]] to <8 x i64>
; CHECK-NEXT:    [[T1:%.*]] = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 undef, i64 -1>, [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = lshr exact <8 x i64> [[T1]], [[T0]]
; CHECK-NEXT:    [[T3:%.*]] = add <8 x i32> [[NBITS]], <i32 -64, i32 -63, i32 -33, i32 -32, i32 63, i32 64, i32 undef, i32 65>
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T0]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T1]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T2]])
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T3]])
; CHECK-NEXT:    [[TMP1:%.*]] = trunc <8 x i64> [[X:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = shl <8 x i32> [[TMP1]], [[T3]]
; CHECK-NEXT:    [[T6:%.*]] = and <8 x i32> [[TMP2]], <i32 poison, i32 1, i32 2147483647, i32 -1, i32 -1, i32 -1, i32 poison, i32 poison>
; CHECK-NEXT:    ret <8 x i32> [[T6]]
;
  %t0 = zext <8 x i32> %nbits to <8 x i64>
  %t1 = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 undef, i64 -1>, %t0
  %t2 = lshr <8 x i64> %t1, %t0
  %t3 = add <8 x i32> %nbits, <i32 -64, i32 -63, i32 -33, i32 -32, i32 63, i32 64, i32 undef, i32 65>

  call void @use8xi64(<8 x i64> %t0)
  call void @use8xi64(<8 x i64> %t1)
  call void @use8xi64(<8 x i64> %t2)
  call void @use8xi32(<8 x i32> %t3)

  %t4 = and <8 x i64> %t2, %x
  %t5 = trunc <8 x i64> %t4 to <8 x i32>
  %t6 = shl <8 x i32> %t5, %t3 ; shift is smaller than mask
  ret <8 x i32> %t6
}

; Extra uses.

define i32 @n4_extrause0(i64 %x, i32 %nbits) {
; CHECK-LABEL: @n4_extrause0(
; CHECK-NEXT:    [[T0:%.*]] = zext i32 [[NBITS:%.*]] to i64
; CHECK-NEXT:    [[T1:%.*]] = shl nsw i64 -1, [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = lshr exact i64 [[T1]], [[T0]]
; CHECK-NEXT:    [[T3:%.*]] = add i32 [[NBITS]], -33
; CHECK-NEXT:    call void @use64(i64 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use32(i32 [[T3]])
; CHECK-NEXT:    [[T4:%.*]] = and i64 [[T2]], [[X:%.*]]
; CHECK-NEXT:    call void @use64(i64 [[T4]])
; CHECK-NEXT:    [[T5:%.*]] = trunc i64 [[T4]] to i32
; CHECK-NEXT:    [[T6:%.*]] = shl i32 [[T5]], [[T3]]
; CHECK-NEXT:    ret i32 [[T6]]
;
  %t0 = zext i32 %nbits to i64
  %t1 = shl i64 -1, %t0
  %t2 = lshr i64 %t1, %t0
  %t3 = add i32 %nbits, -33

  call void @use64(i64 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use32(i32 %t3)

  %t4 = and i64 %t2, %x
  call void @use64(i64 %t4)
  %t5 = trunc i64 %t4 to i32
  %t6 = shl i32 %t5, %t3 ; shift is smaller than mask
  ret i32 %t6
}

define i32 @n5_extrause1(i64 %x, i32 %nbits) {
; CHECK-LABEL: @n5_extrause1(
; CHECK-NEXT:    [[T0:%.*]] = zext i32 [[NBITS:%.*]] to i64
; CHECK-NEXT:    [[T1:%.*]] = shl nsw i64 -1, [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = lshr exact i64 [[T1]], [[T0]]
; CHECK-NEXT:    [[T3:%.*]] = add i32 [[NBITS]], -33
; CHECK-NEXT:    call void @use64(i64 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use32(i32 [[T3]])
; CHECK-NEXT:    [[T4:%.*]] = and i64 [[T2]], [[X:%.*]]
; CHECK-NEXT:    [[T5:%.*]] = trunc i64 [[T4]] to i32
; CHECK-NEXT:    call void @use32(i32 [[T5]])
; CHECK-NEXT:    [[T6:%.*]] = shl i32 [[T5]], [[T3]]
; CHECK-NEXT:    ret i32 [[T6]]
;
  %t0 = zext i32 %nbits to i64
  %t1 = shl i64 -1, %t0
  %t2 = lshr i64 %t1, %t0
  %t3 = add i32 %nbits, -33

  call void @use64(i64 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use32(i32 %t3)

  %t4 = and i64 %t2, %x
  %t5 = trunc i64 %t4 to i32
  call void @use32(i32 %t5)
  %t6 = shl i32 %t5, %t3 ; shift is smaller than mask
  ret i32 %t6
}

define i32 @n6_extrause2(i64 %x, i32 %nbits) {
; CHECK-LABEL: @n6_extrause2(
; CHECK-NEXT:    [[T0:%.*]] = zext i32 [[NBITS:%.*]] to i64
; CHECK-NEXT:    [[T1:%.*]] = shl nsw i64 -1, [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = lshr exact i64 [[T1]], [[T0]]
; CHECK-NEXT:    [[T3:%.*]] = add i32 [[NBITS]], -33
; CHECK-NEXT:    call void @use64(i64 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use32(i32 [[T3]])
; CHECK-NEXT:    [[T4:%.*]] = and i64 [[T2]], [[X:%.*]]
; CHECK-NEXT:    call void @use64(i64 [[T4]])
; CHECK-NEXT:    [[T5:%.*]] = trunc i64 [[T4]] to i32
; CHECK-NEXT:    call void @use32(i32 [[T5]])
; CHECK-NEXT:    [[T6:%.*]] = shl i32 [[T5]], [[T3]]
; CHECK-NEXT:    ret i32 [[T6]]
;
  %t0 = zext i32 %nbits to i64
  %t1 = shl i64 -1, %t0
  %t2 = lshr i64 %t1, %t0
  %t3 = add i32 %nbits, -33

  call void @use64(i64 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use32(i32 %t3)

  %t4 = and i64 %t2, %x
  call void @use64(i64 %t4)
  %t5 = trunc i64 %t4 to i32
  call void @use32(i32 %t5)
  %t6 = shl i32 %t5, %t3 ; shift is smaller than mask
  ret i32 %t6
}

; This is a miscompile if it ends by masking off the high bit of the result.

define i32 @PR51351(i64 %x, i32 %nbits) {
; CHECK-LABEL: @PR51351(
; CHECK-NEXT:    [[T3:%.*]] = add i32 [[NBITS:%.*]], -33
; CHECK-NEXT:    [[T5:%.*]] = trunc i64 [[X:%.*]] to i32
; CHECK-NEXT:    [[T6:%.*]] = shl i32 [[T5]], [[T3]]
; CHECK-NEXT:    ret i32 [[T6]]
;
  %t0 = zext i32 %nbits to i64
  %t1 = shl i64 -1, %t0
  %t2 = ashr i64 %t1, %t0
  %t3 = add i32 %nbits, 4294967263
  %t4 = and i64 %t2, %x
  %t5 = trunc i64 %t4 to i32
  %t6 = shl i32 %t5, %t3
  ret i32 %t6
}