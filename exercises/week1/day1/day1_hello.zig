const std = @import("std");

pub fn main() void {
    const name: []const u8 = "Zig leanrner";
    const count: i32 = 1;
    std.debug.print("Hello, {s}! This is attempt #{}\n", .{ name, count });
}
