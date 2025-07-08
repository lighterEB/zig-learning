const std = @import("std");

pub fn main() !void {
    const numbers = [_]i32{ 1, 2, 3, 4, 5 };
    for (numbers) |num| {
        std.debug.print("Number: {}\n", .{num});
    }

    for (0..5) |i| {
        std.debug.print("i = {}\n", .{i});
    }
}
