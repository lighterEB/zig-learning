# Zig Learning Notes
## 1.第一天

### 1.1 基本语法

* 变量`var`声明;常量使用`const`声明，不可修改

```zig

var x: i32 = 21; // 声明变量 x 并且赋值 21

x = 22; // 正确

const y: i32 = 12; // 声明常量 y 并且赋值 12

y = 23; // 错误

```

- 基本数据类型：

1. 整型：

- 有符号：`i8` `i16` `i32`
```zig
const x: i8 = 125;
const y: i16 = -21;
const z: i32 = 65535;
```

- 无符号： `u8` `u16` `u32`
```zig
const x: u8 = 12;
const y: u16 = 24;
const z: u32 = 128;
```
2.  浮点数：
  - `f32` `f64`
```zig
const f32Num: f32 = 3.1415;
const f64Num: f64 = 125.221;
```
2. 布尔:
  * `bool` (true 或 false)
```zig
const isOk: bool = false;
```
2. 字符串：
  * `[]const u8` (UTF-8编码的字节切片)
```zig
const name: []const u8 = "Hello!";
```

## 2. 第二天
### 2.1 if语句
* Zig的`if`支持条件判断，可与`else` 和 `else if` 组合
* 条件必须返回 `bool` 类型
* 支持捕获值（类似模式匹配）
```zig
const std=@import("std");
pub fn main() void {
	const num: i32 = 56;
	if (num > 0) {
	    std.debug.print("Positive\n", .{});
	} else if (num < 0) {
	    std.debug.print("Nagative\n", .{});
	} else {
	    std.debug.print("Zero\n", .{});
	}
}
```
### 2.2 while语句
* 支持 `break` 和 `continue` , 可带条件或捕获
```zig
var i:32 = 0;
while (i < 5) : (i += 1) {
    std.debug.print("i = {}\n", .{i});
}
```
### 2.3 switch语句
  * 用于多分支选择，支持整数、枚举、布尔等类型。
  * 必须覆盖所有可能值（或使用`else`）
```zig
const value: u8 = 2;
switch (value) {
    1 => std.debug.print("One\n", .{}),
    2 => std.debug.print("Two\n", .{}),
    else => std.debug.print("Other\n", .{}),
}
```

## 3. 第三天
### 3.1 for循环
* Zig的for循环主要用于迭代数组、切片或范围。
* 语法：`for (items) |item| {...}` , 支持捕获值(`item`)。
示例（迭代数组）：
```zig
const std=@import("std");
pub fn main() !void {
    const numbers = [_]i32{1, 2, 3, 4, 5};
    for (numbers) |num| {
        std.debug.print("Number: {}\n", .{num});
    }
}
```

示例 （迭代范围）：
```zig
for (0..5) |i| {
    std.debug.print("Index: {}\n", .{i});
}
```

