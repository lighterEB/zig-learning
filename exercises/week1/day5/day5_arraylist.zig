/// day5_arraylist.zig
/// Purpose: Practice dynamic array operations using std.ArrayList.
/// Created: 2025-07-10
/// Author: LighterEB
const std = @import("std");

pub fn main() !void {
    // Initialize allocator
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // Create dynamic array
    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit();

    // Append items
    try list.append(50);
    try list.append(30);
    try list.append(-89);
    std.debug.print("Initial List: {d}\n", .{list.items});

    // Pop last element
    _ = list.pop();
    std.debug.print("After pop: {d}\n", .{list.items});
}
