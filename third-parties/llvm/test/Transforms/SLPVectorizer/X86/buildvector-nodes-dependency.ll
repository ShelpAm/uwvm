; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -passes=slp-vectorizer -S -mtriple=x86_64 < %s | FileCheck %s

define double @test() {
; CHECK-LABEL: define double @test() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr null, align 8
; CHECK-NEXT:    br label [[COND_TRUE:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x double> <double 0.000000e+00, double poison>, double [[TMP0]], i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <2 x double> zeroinitializer, [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x double> [[TMP1]], <2 x double> poison, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP4:%.*]] = fmul <2 x double> [[TMP3]], zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x double> [[TMP3]], zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> [[TMP1]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP7:%.*]] = fmul <2 x double> [[TMP6]], zeroinitializer
; CHECK-NEXT:    [[TMP8:%.*]] = fsub <2 x double> [[TMP7]], zeroinitializer
; CHECK-NEXT:    [[TMP9:%.*]] = fmul <2 x double> [[TMP7]], zeroinitializer
; CHECK-NEXT:    [[TMP10:%.*]] = shufflevector <2 x double> [[TMP8]], <2 x double> [[TMP9]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP11:%.*]] = fadd <2 x double> zeroinitializer, [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = fmul <2 x double> zeroinitializer, [[TMP10]]
; CHECK-NEXT:    [[TMP13:%.*]] = shufflevector <2 x double> [[TMP11]], <2 x double> [[TMP12]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP14:%.*]] = fsub <2 x double> [[TMP13]], [[TMP2]]
; CHECK-NEXT:    [[TMP15:%.*]] = fadd <2 x double> [[TMP13]], [[TMP2]]
; CHECK-NEXT:    [[TMP16:%.*]] = shufflevector <2 x double> [[TMP14]], <2 x double> [[TMP15]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP17:%.*]] = fsub <2 x double> [[TMP16]], zeroinitializer
; CHECK-NEXT:    [[TMP18:%.*]] = fmul <2 x double> [[TMP4]], zeroinitializer
; CHECK-NEXT:    [[TMP19:%.*]] = fmul <2 x double> zeroinitializer, [[TMP18]]
; CHECK-NEXT:    [[TMP20:%.*]] = fadd <2 x double> [[TMP19]], [[TMP17]]
; CHECK-NEXT:    [[TMP21:%.*]] = fsub <2 x double> [[TMP20]], zeroinitializer
; CHECK-NEXT:    [[TMP22:%.*]] = fmul <2 x double> [[TMP5]], zeroinitializer
; CHECK-NEXT:    [[TMP23:%.*]] = fmul <2 x double> zeroinitializer, [[TMP22]]
; CHECK-NEXT:    [[TMP24:%.*]] = fadd <2 x double> [[TMP23]], [[TMP21]]
; CHECK-NEXT:    [[TMP25:%.*]] = extractelement <2 x double> [[TMP24]], i32 0
; CHECK-NEXT:    [[TMP26:%.*]] = extractelement <2 x double> [[TMP24]], i32 1
; CHECK-NEXT:    [[ADD29:%.*]] = fadd double [[TMP25]], [[TMP26]]
; CHECK-NEXT:    ret double [[ADD29]]
;
entry:
  %0 = load double, ptr null, align 8
  br label %cond.true

cond.true:
  %mul13 = fmul double %0, 0.000000e+00
  %mul14 = fmul double %0, 0.000000e+00
  %mul15 = fmul double %mul14, 0.000000e+00
  %mul16 = fmul double 0.000000e+00, %mul15
  %add17 = fadd double %mul13, %mul16
  %sub18 = fsub double %add17, 0.000000e+00
  %mul19 = fmul double %0, 0.000000e+00
  %mul20 = fmul double %mul19, 0.000000e+00
  %mul21 = fmul double %mul20, 0.000000e+00
  %add22 = fadd double %sub18, %mul21
  %sub23 = fsub double %add22, 0.000000e+00
  %mul24 = fmul double %0, 0.000000e+00
  %mul25 = fmul double %mul24, 0.000000e+00
  %mul26 = fmul double 0.000000e+00, %mul25
  %add27 = fadd double %mul26, %sub23
  %mul = fmul double 0.000000e+00, 0.000000e+00
  %mul1 = fmul double %mul, 0.000000e+00
  %sub = fsub double %mul1, 0.000000e+00
  %add = fadd double 0.000000e+00, %sub
  %sub2 = fsub double %add, %mul
  %sub3 = fsub double %sub2, 0.000000e+00
  %mul4 = fmul double %0, 0.000000e+00
  %mul5 = fmul double %mul4, 0.000000e+00
  %mul6 = fmul double 0.000000e+00, %mul5
  %add7 = fadd double %mul6, %sub3
  %sub8 = fsub double %add7, 0.000000e+00
  %mul9 = fmul double %0, 0.000000e+00
  %mul10 = fmul double %mul9, 0.000000e+00
  %mul11 = fmul double 0.000000e+00, %mul10
  %add12 = fadd double %mul11, %sub8
  %add29 = fadd double %add12, %add27
  ret double %add29
}