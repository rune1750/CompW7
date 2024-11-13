declare i64 @read_integer()
declare void @print_integer(i64)

define i64 @dolphin_main () {
 %b2 = alloca i64
 %a1 = alloca i64
 store i64 1, i64* %a1
 store i64 2, i64* %b2
 %a_val3 = load i64, i64* %a1
 %b_val4 = load i64, i64* %b2
 %tmp5 = add i64 %a_val3, %b_val4
 store i64 %tmp5, i64* %a1
 %a_val6 = load i64, i64* %a1
 %b_val7 = load i64, i64* %b2
 %tmp8 = mul i64 %a_val6, %b_val7
 ret i64 %tmp8
}
