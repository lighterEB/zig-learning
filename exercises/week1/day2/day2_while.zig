const print = @import("std").debug.print;

pub fn main() !void {
    var num: i32 = 0;
    while (num < 5) : (num += 1) {
        print("num = {}\n", .{num});
    }
}
