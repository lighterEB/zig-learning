const print = @import("std").debug.print;

pub fn main() !void {
    const num: i32 = 32; // 声明常量 num 赋值 32
    const result: i32 = num % 2; // 声明常量 result 赋值 num 模运算
    switch (result) {
        0 => print("Even\n", .{}), // result 为0时输出偶数
        else => print("Odd\n", .{}), // 否则输出奇数
    }
}
