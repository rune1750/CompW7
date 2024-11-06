declare i64 @read_integer()
declare void @print_integer(i64)

define i64 @dolphin_main () {
 %x1 = alloca i64
 store i64 10, i64* %x1
 %x_val2 = load i64, i64* %x1
 %tmp3 = icmp slt i64 %x_val2, 20
 br i1 %tmp3, label %then4, label %else5
then4:
 %x_val7 = load i64, i64* %x1
 %tmp8 = add i64 %x_val7, 7
 store i64 %tmp8, i64* %x1
 br label %if_end6
else5:
 %x_val9 = load i64, i64* %x1
 %tmp10 = sub i64 %x_val9, 5
 store i64 %tmp10, i64* %x1
 br label %if_end6
if_end6:
 %x_val11 = load i64, i64* %x1
 ret i64 %x_val11
}