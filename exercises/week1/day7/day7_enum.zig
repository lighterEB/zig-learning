// day7_enum.zig
// Purpose: Practice enums by handling different states.
// Created: 2025-08-07

const std = @import("std");

const State = enum {
    idle,
    running,
    stopped,

    // Convert state to string
    fn toString(self: State) []const u8 {
        return switch (self) {
            .idle => "Idle",
            .running => "Running",
            .stopped => "Stopped",
        };
    }
};

pub fn main() !void {
    const states = [_]State{ .idle, .running, .stopped };
    for (states) |state| {
        std.debug.print("State: {s}\n", .{state.toString()});
    }
}
