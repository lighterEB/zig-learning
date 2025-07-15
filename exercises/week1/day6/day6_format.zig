// day6_format.zig
// Purpose: Practice formatted output using std.io.Writer.
// Created: 2025-07-15

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Format numbers and strings
    const value: f32 = 3.1415926;
    const name = "Zig Learner";
    try stdout.print("Name: {s}, Value: {d:.2}\n", .{ name, value });

    // Format an array
    const numbers = [_]i32{ 1, 2, 3, 4, 5 };
    try stdout.print("Numbers: {d}\n", .{numbers});

    // Align and pad output
    try stdout.print("|{s:>10}|\n", .{"Aligned"}); // Right-align with width 10
}
