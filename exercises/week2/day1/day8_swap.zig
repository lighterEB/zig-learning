// day8_swap.zig
// Purpose: Practice pointer usage by swapping two values.
// Created: 2025-08-08

const std = @import("std");

// Swap two i32 values using pointers
/// Accepts two pointers to i32 and swaps the values they point to.
fn swap(a: *i32, b: *i32) void {
    const temp = a.*;
    a.* = b.*;
    b.* = temp;
}

pub fn main() !void {
    var x: i32 = 10;
    var y: i32 = 20;
    std.debug.print("Before swap: x = {d}, y = {d}\n", .{ x, y });
    swap(&x, &y); // Pass addresses of x and y
    std.debug.print("After swap: x = {d}, y = {d}\n", .{ x, y });
}
