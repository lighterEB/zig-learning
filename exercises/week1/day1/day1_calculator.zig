const std = @import("std");

pub fn main() void {
    const fNum: f32 = 3.14;
    const iNum: i32 = 2;
    const r: f32 = fNum + @as(f32, iNum); // 类型转换
    std.debug.print("fNum + iNum = {d:.2}", .{r});
}
