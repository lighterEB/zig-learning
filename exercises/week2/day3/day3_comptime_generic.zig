const std = @import("std");
fn printValue(comptime T: type, value: T) void {
    std.debug.print("Value: {}\n", .{value});
}

pub fn main() !void {
    printValue(i32, 42);
    printValue(f32, 3.14);
}
