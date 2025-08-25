const std = @import("std");
pub fn main() !void {
    const str = "Hello,World!";
    var iter = std.mem.splitAny(u8, str, ",");
    while (iter.next()) |part| {
        std.debug.print("Part: {s}\n", .{part});
    }
}
