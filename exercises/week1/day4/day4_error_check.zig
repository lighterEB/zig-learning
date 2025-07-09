/// day4_check_error.zig
/// Purpose: Practice error handling with errdefer and multiple error types.
/// Created: 2025-07-09
const print = @import("std").debug.print;

const CheckError = error{ InvalidValue, OutOfRange };

fn checkNumber(num: i32) CheckError!i32 {
    errdefer print("Cleaning up for number {}\n", .{num});
    if (num < 0) return CheckError.InvalidValue;
    if (num > 100) return CheckError.OutOfRange;
    return num;
}

pub fn main() !void {
    const numbers = [_]i32{ 29, -32, 378, 76 };

    for (numbers) |number| {
        const result = checkNumber(number) catch |err| {
            print("Error for {}: {}\n", .{ number, err });
            continue;
        };
        print("Valid number: {}\n", .{result});
    }
}
