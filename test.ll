declare i64 @read_integer()
declare void @print_integer(i64)

define i64 @dolphin_main () {
 %z28 = alloca i1
 %y27 = alloca i1
 %x26 = alloca i1
 store i1 1, i1* %x26
 store i1 0, i1* %y27
 %tmp29 = alloca i1
 %x_val32 = load i1, i1* %x26
 store i1 %x_val32, i1* %tmp29
 br i1 %x_val32, label %end31, label %right_eval30
right_eval30:
 %tmp33 = sdiv i64 1, 0
 %tmp34 = icmp eq i64 %tmp33, 0
 store i1 %tmp34, i1* %tmp29
 br label %end31
end31:
 %tmp_val35 = load i1, i1* %tmp29
 store i1 %tmp_val35, i1* %z28
 ret i64 0
}