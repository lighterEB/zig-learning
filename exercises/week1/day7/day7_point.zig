// day7_point.zig
// Purpose: Practice structs by calculating the distance between two points.
// Created: 2025-08-03
// Author: LighterEB

const std = @import("std");

const Point = struct {
    x: f32,
    y: f32,

    // Calculate distance to another point
    fn distance(self: Point, other: Point) f32 {
        const dx = self.x - other.x;
        const dy = self.y - other.y;
        return std.math.sqrt(dx * dx + dy * dy);
    }
};

pub fn main() !void {
    const p1 = Point{ .x = 1.0, .y = 2.0 };
    const p2 = Point{ .x = 4.0, .y = 6.0 };
    const dist = p1.distance(p2);
    std.debug.print("Distance between ({d:.2}, {d:.2}) and ({d:.2}, {d:.2}) is {d:.2}\n", .{ p1.x, p1.y, p2.x, p2.y, dist }); // Distance between (1.00, 2.00) and (4.00, 6.00) is 5.00
}
