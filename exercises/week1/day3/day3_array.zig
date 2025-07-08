const print = @import("std").debug.print;

pub fn main() !void {
    const array = [_]i32{ 10, 20, 46, 69, 2 };
    for (array, 0..) |value, index| {
        print("Value: {}, Index: {d}\n", .{ value, index });
    }
}
