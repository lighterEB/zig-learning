/// day4_division.zig
/// Purpose: Practice error handling with a safe division function.
/// Created: 2025-07-09
const print = @import("std").debug.print;

const DivisionError = error{DivideByZero};

// Safe division function that checks for zero denominator.
fn division(a: f32, b: f32) DivisionError!f32 {
    if (b == 0) return DivisionError.DivideByZero;
    return a / b;
}
pub fn main() !void {
    const a: f32 = 64.78;
    const b: f32 = 8.65;
    const c: f32 = 0.0;

    // Try division with valid input
    const validResult = division(a, b) catch |err| {
        print("Error dividing {d} by {d}: {}\n", .{a, b, err});
        return;
    };
    print("{d} / {d} = {d:.2}\n", .{a,b,validResult});

    // Try division with invalid input
    const invalidResult = division(a, c) catch |err| {
        print("Error division {d} by {d}: {}\n", .{a,c,err});
        return;
    };

    print("{d} / {d} = {d:.2}\n", .{a,b,invalidResult});

}
