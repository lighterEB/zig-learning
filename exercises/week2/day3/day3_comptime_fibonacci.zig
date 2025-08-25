const std = @import("std");
const fib = blk: {
    var array: [10]i32 = undefined;
    array[0] = 0;
    array[1] = 1;
    for (2..10) |i| {
        array[i] = array[i - 1] + array[i - 2];
    }
    break :blk array;
};

pub fn main() !void {
    std.debug.print("Fibonacci: {any}\n", .{fib});
}
