// day9_union_parse.zig
// Purpose: Practice parsing and handling union types with error checking.
// Created: 2025-08-20
const std = @import("std");
const ParseError = error{InvalidData};
const ValueType = enum { number, boolean };
const Value = union(ValueType) {
    number: f32,
    boolean: bool,
};

// Parse a string to a Value union
fn parseValue(input: []const u8) ParseError!Value {
    if (std.fmt.parseFloat(f32, input)) |num| {
        return Value{ .number = num };
    } else |_| {
        if (std.mem.eql(u8, input, "true")) return Value{ .boolean = true };
        if (std.mem.eql(u8, input, "false")) return Value{ .boolean = false };
        return ParseError.InvalidData;
    }
}

pub fn main() !void {
    const inputs = [_][]const u8{
        "3.14",
        "invalid",
        "false",
        "true",
    };

    for (inputs) |input| {
        const result = parseValue(input) catch |err| {
            std.debug.print("Failed to parse '{s}': {}\n", .{ input, err });
            continue;
        };
        switch (result) {
            .number => |num| std.debug.print("Parsed number: {d:.2}\n", .{num}),
            .boolean => |b| std.debug.print("Parsed boolean: {}\n", .{b}),
        }
    }
}
