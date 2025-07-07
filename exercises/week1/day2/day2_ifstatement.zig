const std = @import("std");

pub fn main() void {
    const num: i32 = 56;
    if (num > 0) {
        std.debug.print("Positive\n", .{});
    } else if (num < 0) {
        std.debug.print("Negative\n", .{});
    } else {
        std.debug.print("Zero", .{});
    }
}
