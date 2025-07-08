// day3_factorial.zi
// Purpose: practice loops and functions in Zig.
// Created: 2025-07-08

const print = @import("std").debug.print;

// Define a function to calculate the factorial of a number.
// using recursion
fn factorial_recursion(x: u32) u64 {
    if (x <= 1) {
        return 1;
    }
    return x * factorial_recursion(x - 1);
}

// using loop
fn factorial_loop(x: u32) u64 {
    var result: u64 = 1;
    for (1..x + 1) |i| {
        result = result * @as(u64, i);
    }
    return result;
}

pub fn main() !void {
    const input: u32 = 8;
    const result = factorial_recursion(input);
    print("The factorial of {} is {} using recursion\n", .{ input, result });

    const other = factorial_loop(input);
    print("The factorial of {} is {} using recursion\n", .{ input, other });
}
