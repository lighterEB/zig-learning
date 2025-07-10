const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit();

    try list.append(42);
    try list.append(100);

    std.debug.print("List: {d}\n", .{list.items});
}
