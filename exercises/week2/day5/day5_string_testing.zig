// week5_day5_string_testing.zig
// Purpose: Practice unit testing for string parsing using std.testing.
// Created: 2025-08-25

const std = @import("std");

const ParseError = error{InvalidFormat};

// Parse a string to an integer
fn parseNum(input: []const u8) ParseError!i32 {
    return std.fmt.parseInt(i32, input, 10) catch return ParseError.InvalidFormat;
}

test "test parseNum" {
    try std.testing.expectEqual(42, parseNum("42"));
    try std.testing.expectEqual(-7, parseNum("-7"));
    try std.testing.expectError(ParseError.InvalidFormat, parseNum("abc"));
}
