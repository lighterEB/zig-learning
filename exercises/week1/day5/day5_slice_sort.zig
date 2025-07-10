/// day5_slice_sort.zig
/// Purpose: Practice sorting a slice of integers.
/// Created: 2025-07-10
/// Author: LighterEB
const std = @import("std");

pub fn main() !void {
    // Define an array and create a mutable slice.
    var array = [_]i32{ 5, 2, 7, 1, 9 };
    const slice = array[0..];

    // Print original array
    std.debug.print("Before sorting: {d}\n", .{slice});

    // Sort the slice in ascending order.
    std.mem.sort(i32, slice, {}, comptime std.sort.asc(i32));
    std.debug.print("After sorting: {d}\n", .{slice});
}
