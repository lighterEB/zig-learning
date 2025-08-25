// week2-day5_math_test.zig
// Purpose: Practice unit testing for math functions using std.testing.
// Created: 2025-08-25

const std = @import("std");

test "test math.add" {
    try std.testing.expectEqual(8, std.math.add(i32, 5, 3));
    try std.testing.expectEqual(0, std.math.add(i32, 0, 0));
    try std.testing.expectEqual(-2, std.math.add(i32, -1, -1));
}

test "test math.multiply" {
    try std.testing.expectEqual(15, 5 * 3);
    try std.testing.expectEqual(0, 0 * 0);
    try std.testing.expectEqual(4, -2 * -2);
}
