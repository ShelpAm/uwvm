; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -codegenprepare -S | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@b = dso_local local_unnamed_addr global i64 0, align 8
@c = dso_local local_unnamed_addr global i64 0, align 8
@d = dso_local local_unnamed_addr global i64 0, align 8
@e = dso_local local_unnamed_addr global i64 0, align 8
@f = dso_local local_unnamed_addr global i64 0, align 8
@g = dso_local local_unnamed_addr global i64 0, align 8

define dso_local i32 @m() {
; CHECK-LABEL: @m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @f, align 8
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, ptr @c, align 8
; CHECK-NEXT:    [[CONV18:%.*]] = trunc i64 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr @d, align 8
; CHECK-NEXT:    [[CONV43:%.*]] = trunc i64 [[TMP2]] to i8
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[J_0:%.*]] = phi i32 [ undef, [[ENTRY:%.*]] ], [ [[J_1_LCSSA:%.*]], [[FOR_COND39_PREHEADER:%.*]] ]
; CHECK-NEXT:    [[P_0:%.*]] = phi i64 [ undef, [[ENTRY]] ], [ [[P_1_LCSSA:%.*]], [[FOR_COND39_PREHEADER]] ]
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ undef, [[ENTRY]] ], [ [[I_1_LCSSA:%.*]], [[FOR_COND39_PREHEADER]] ]
; CHECK-NEXT:    [[CMP73:%.*]] = icmp slt i32 [[I_0]], 3
; CHECK-NEXT:    br i1 [[CMP73]], label [[FOR_BODY:%.*]], label [[FOR_COND39_PREHEADER]]
; CHECK:       for.cond1.loopexit:
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i32 [[CONV18]], 3
; CHECK-NEXT:    br i1 [[TMP3]], label [[FOR_BODY]], label [[FOR_COND39_PREHEADER]]
; CHECK:       for.cond39.preheader:
; CHECK-NEXT:    [[J_1_LCSSA]] = phi i32 [ [[J_0]], [[FOR_COND]] ], [ [[CONV18]], [[FOR_COND1_LOOPEXIT:%.*]] ]
; CHECK-NEXT:    [[P_1_LCSSA]] = phi i64 [ [[P_0]], [[FOR_COND]] ], [ 0, [[FOR_COND1_LOOPEXIT]] ]
; CHECK-NEXT:    [[I_1_LCSSA]] = phi i32 [ [[I_0]], [[FOR_COND]] ], [ [[CONV18]], [[FOR_COND1_LOOPEXIT]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq i8 [[CONV43]], 0
; CHECK-NEXT:    br i1 [[TMP4]], label [[FOR_COND]], label [[FOR_INC42:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[L_176:%.*]] = phi i8 [ [[SUB:%.*]], [[FOR_COND1_LOOPEXIT]] ], [ 0, [[FOR_COND]] ]
; CHECK-NEXT:    [[P_175:%.*]] = phi i64 [ 0, [[FOR_COND1_LOOPEXIT]] ], [ [[P_0]], [[FOR_COND]] ]
; CHECK-NEXT:    [[J_174:%.*]] = phi i32 [ [[CONV18]], [[FOR_COND1_LOOPEXIT]] ], [ [[J_0]], [[FOR_COND]] ]
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[J_174]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[CLEANUP45:%.*]], label [[FOR_COND2_PREHEADER:%.*]]
; CHECK:       for.cond2.preheader:
; CHECK-NEXT:    [[DOTPR_PRE:%.*]] = load i64, ptr @e, align 8
; CHECK-NEXT:    switch i64 [[P_175]], label [[FOR_BODY4_PREHEADER6:%.*]] [
; CHECK-NEXT:    i64 -1, label [[FOR_END12:%.*]]
; CHECK-NEXT:    i64 -2, label [[FOR_END12]]
; CHECK-NEXT:    i64 -3, label [[FOR_END12]]
; CHECK-NEXT:    i64 -4, label [[FOR_END12]]
; CHECK-NEXT:    i64 -5, label [[FOR_END12]]
; CHECK-NEXT:    i64 -6, label [[FOR_END12]]
; CHECK-NEXT:    i64 -7, label [[FOR_END12]]
; CHECK-NEXT:    i64 0, label [[FOR_END12]]
; CHECK-NEXT:    ]
; CHECK:       for.body4.preheader6:
; CHECK-NEXT:    [[TMP5:%.*]] = sub i64 0, [[P_175]]
; CHECK-NEXT:    [[XTRAITER:%.*]] = and i64 [[TMP5]], 7
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[P_175]], [[XTRAITER]]
; CHECK-NEXT:    br label [[FOR_BODY4:%.*]]
; CHECK:       for.body4:
; CHECK-NEXT:    [[P_270:%.*]] = phi i64 [ [[INC11_7:%.*]], [[FOR_BODY4]] ], [ [[TMP6]], [[FOR_BODY4_PREHEADER6]] ]
; CHECK-NEXT:    [[INC11_7]] = add i64 [[P_270]], 8
; CHECK-NEXT:    [[TOBOOL3_NOT_7:%.*]] = icmp eq i64 [[INC11_7]], 0
; CHECK-NEXT:    br i1 [[TOBOOL3_NOT_7]], label [[FOR_END12]], label [[FOR_BODY4]]
; CHECK:       for.end12:
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP0]] to ptr
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr [[TMP7]], align 4
; CHECK-NEXT:    [[CONV23:%.*]] = zext i32 [[TMP8]] to i64
; CHECK-NEXT:    [[TMP9:%.*]] = load i64, ptr @b, align 8
; CHECK-NEXT:    [[DIV24:%.*]] = udiv i64 [[TMP9]], [[CONV23]]
; CHECK-NEXT:    store i64 [[DIV24]], ptr @b, align 8
; CHECK-NEXT:    [[SUB]] = add i8 [[L_176]], -1
; CHECK-NEXT:    [[TOBOOL32_NOT72:%.*]] = icmp eq i64 [[DOTPR_PRE]], 0
; CHECK-NEXT:    br i1 [[TOBOOL32_NOT72]], label [[FOR_COND1_LOOPEXIT]], label [[FOR_INC34_PREHEADER:%.*]]
; CHECK:       for.inc34.preheader:
; CHECK-NEXT:    store i64 0, ptr @e, align 8
; CHECK-NEXT:    br label [[FOR_COND1_LOOPEXIT]]
; CHECK:       for.inc42:
; CHECK-NEXT:    br label [[FOR_INC42]]
; CHECK:       cleanup45:
; CHECK-NEXT:    [[CMP13:%.*]] = icmp ne i8 [[L_176]], 0
; CHECK-NEXT:    [[CONV16:%.*]] = zext i1 [[CMP13]] to i32
; CHECK-NEXT:    ret i32 [[CONV16]]
;
entry:
  %0 = load i64, ptr @f, align 8
  %1 = inttoptr i64 %0 to ptr
  %2 = load i64, ptr @c, align 8
  %conv18 = trunc i64 %2 to i32
  %cmp = icmp slt i32 %conv18, 3
  %3 = load i64, ptr @d, align 8
  %conv43 = trunc i64 %3 to i8
  %tobool40.not = icmp eq i8 %conv43, 0
  br label %for.cond

for.cond:                                         ; preds = %for.cond39.preheader, %entry
  %j.0 = phi i32 [ undef, %entry ], [ %j.1.lcssa, %for.cond39.preheader ]
  %p.0 = phi i64 [ undef, %entry ], [ %p.1.lcssa, %for.cond39.preheader ]
  %i.0 = phi i32 [ undef, %entry ], [ %i.1.lcssa, %for.cond39.preheader ]
  %cmp73 = icmp slt i32 %i.0, 3
  br i1 %cmp73, label %for.body, label %for.cond39.preheader

for.cond1.loopexit:                               ; preds = %for.inc34.preheader, %for.end12
  br i1 %cmp, label %for.body, label %for.cond39.preheader

for.cond39.preheader:                             ; preds = %for.cond1.loopexit, %for.cond
  %j.1.lcssa = phi i32 [ %j.0, %for.cond ], [ %conv18, %for.cond1.loopexit ]
  %p.1.lcssa = phi i64 [ %p.0, %for.cond ], [ 0, %for.cond1.loopexit ]
  %i.1.lcssa = phi i32 [ %i.0, %for.cond ], [ %conv18, %for.cond1.loopexit ]
  br i1 %tobool40.not, label %for.cond, label %for.inc42

for.body:                                         ; preds = %for.cond, %for.cond1.loopexit
  %l.176 = phi i8 [ %sub, %for.cond1.loopexit ], [ 0, %for.cond ]
  %p.175 = phi i64 [ 0, %for.cond1.loopexit ], [ %p.0, %for.cond ]
  %j.174 = phi i32 [ %conv18, %for.cond1.loopexit ], [ %j.0, %for.cond ]
  %tobool.not = icmp eq i32 %j.174, 0
  br i1 %tobool.not, label %cleanup45, label %for.cond2.preheader

for.cond2.preheader:                              ; preds = %for.body
  %.pr.pre = load i64, ptr @e, align 8
  switch i64 %p.175, label %for.body4.preheader6 [
  i64 -1, label %for.end12
  i64 -2, label %for.end12
  i64 -3, label %for.end12
  i64 -4, label %for.end12
  i64 -5, label %for.end12
  i64 -6, label %for.end12
  i64 -7, label %for.end12
  i64 0, label %for.end12
  ]

for.body4.preheader6:                             ; preds = %for.cond2.preheader
  %4 = sub i64 0, %p.175
  %xtraiter = and i64 %4, 7
  %5 = add i64 %p.175, %xtraiter
  br label %for.body4

for.body4:                                        ; preds = %for.body4.preheader6, %for.body4
  %p.270 = phi i64 [ %inc11.7, %for.body4 ], [ %5, %for.body4.preheader6 ]
  %inc11.7 = add i64 %p.270, 8
  %tobool3.not.7 = icmp eq i64 %inc11.7, 0
  br i1 %tobool3.not.7, label %for.end12, label %for.body4

for.end12:                                        ; preds = %for.body4, %for.cond2.preheader, %for.cond2.preheader, %for.cond2.preheader, %for.cond2.preheader, %for.cond2.preheader, %for.cond2.preheader, %for.cond2.preheader, %for.cond2.preheader
  %6 = load i32, ptr %1, align 4
  %conv23 = zext i32 %6 to i64
  %7 = load i64, ptr @b, align 8
  %div24 = udiv i64 %7, %conv23
  store i64 %div24, ptr @b, align 8
  %sub = add i8 %l.176, -1
  %tobool32.not72 = icmp eq i64 %.pr.pre, 0
  br i1 %tobool32.not72, label %for.cond1.loopexit, label %for.inc34.preheader

for.inc34.preheader:                              ; preds = %for.end12
  store i64 0, ptr @e, align 8
  br label %for.cond1.loopexit

for.inc42:                                        ; preds = %for.cond39.preheader, %for.inc42
  br label %for.inc42

cleanup45:                                        ; preds = %for.body
  %cmp13 = icmp ne i8 %l.176, 0
  %conv16 = zext i1 %cmp13 to i32
  ret i32 %conv16
}