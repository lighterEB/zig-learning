const std = @import("std");
test "add 1 + 1" {
    try std.testing.expectEqual(2, 1 + 1);
}
