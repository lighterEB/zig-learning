// day8_allocator.zig
// Purpose: Practice dynamic memory allocation with std.mem.Allocator.
// Created: 2025-08-08

const std = @import("std");

pub fn main() !void {
    // Initialize allocator
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // Allocate memory for 3 integers
    const memory = try allocator.alloc(i32, 3);
    defer allocator.free(memory);

    // Initialize values
    memory[0] = 10;
    memory[1] = 20;
    memory[2] = 30;

    // Print allocated memory
    std.debug.print("Allocated memory: {d}\n", .{memory});
}
