// day6_file_read.zig
// Purpose: Simulate file reading using a fixed buffer stream.
// Created: 2025-07-15

const std = @import("std");

pub fn main() !void {
    // Initialize a buffer with sample content
    var buffer: [100]u8 = undefined;
    var stream = std.io.fixedBufferStream(&buffer);
    const writer = stream.writer();

    // Simulate writing to "file"
    try writer.print("Hello, Zig!\nLine 2: {d}\n", .{42});

    // Reset stream position to read.
    stream.reset();

    // Read content
    const reader = stream.reader();
    var read_buffer: [100]u8 = undefined;
    const content = try reader.readUntilDelimiterOrEof(&read_buffer, '\n');
    std.debug.print("Read first line: {s}\n", .{content orelse "Empty"});

    // Read second line
    const content2 = try reader.readUntilDelimiterOrEof(&read_buffer, '\n');
    std.debug.print("Read second line: {s}\n", .{content2 orelse "Empty"});
}
