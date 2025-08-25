const std = @import("std");
const my_module = @import("my_module.zig");

pub fn main() !void {
    std.debug.print("Standard library print\n", .{});
    my_module.sayHello();
}
