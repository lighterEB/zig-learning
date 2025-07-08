const print = @import("std").debug.print;

// Defined a function named add.
// This function adds two numbers and returns the result.
fn add(x: i32, y: i32) i32 {
    return x + y;
}
pub fn main() !void {
    const result = add(3, 4);
    print("Sum: {}\n", .{result});
}
