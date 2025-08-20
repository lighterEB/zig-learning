// day9_variant.zig
// Purpose: Practice tagged unions to handle different data types.
// Created: 2025-08-20
const std = @import("std");
const DataType = enum { integer, floating, text };
const Data = union(DataType) {
    integer: i32,
    floating: f32,
    text: []const u8,
};

pub fn main() !void {
    const value = [_]Data{
        .{ .integer = 42 },
        .{ .floating = 3.14 },
        .{ .text = "LighterEB" },
    };

    for (value) |item| {
        switch (item) {
            .integer => |i| std.debug.print("Integer: {d}\n", .{i}),
            .floating => |f| std.debug.print("Float: {d:.2}\n", .{f}),
            .text => |s| std.debug.print("Text: {s}\n", .{s}),
        }
    }
}
