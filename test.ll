declare i64 @read_integer()
declare void @print_integer(i64)

define i64 @dolphin_increment (i64 %x) {
 %tmp1 = add i64 %x, 1
 ret i64 %tmp1
}

define i64 @dolphin_double_and_increment (i64 %x) {
 %x3 = alloca i64
 %tmp2 = mul i64 %x, 2
 store i64 %tmp2, i64* %x3
 %x_val4 = load i64, i64* %x3
 %tmp5 = call i64 @increment (i64 %x_val4)
 ret i64 %tmp5
}

define i64 @dolphin_main () {
 %result7 = alloca i64
 %value6 = alloca i64
 store i64 3, i64* %value6
 %value_val8 = load i64, i64* %value6
 %tmp9 = call i64 @double_and_increment (i64 %value_val8)
 store i64 %tmp9, i64* %result7
 %result_val10 = load i64, i64* %result7
 ret i64 %result_val10
}