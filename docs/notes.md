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

### 3.2 函数
- 定义：函数用 `fn` 定义，指定参数类型和返回值类型。
- 语法：`fn name(param: Type) ReturnType { ... }`
- 示例：
```zig
// 定义一个以 add 命名的函数，传入两个形参 x, y 都是 i32 整型 返回 i32 整型
fn add(x:i32, y:i32) i32 {
    return x + y; // 返回 x 与 y 的和
}

pub fn main() !void {
    const result = add(3,4); // 定义一个 result 常量 将 执行 add 函数后返回的值赋值给result，这里传入 3，4两个实参 返回 7 赋值给result
    std.debug.print("Sum: {}\n", .{result});
}
```
* 注：`pub` 表示函数可被外部调用；`void` 表示无返回值。

##  4.第四天
### 4.1 错误类型（error union）
* Zig使用 `error union`表示可能失败的操作，语法为`!T`(T是返回值类型)
* 错误集用`error`定义，例如：
```zig
const MyError = error{InvalidInput, Overflow}
```
* 函数返回错误联合：
```zig
fn mightFail() !i32 {
    return error.InvalidInput; // 失败
    return 24; // 成功
}
```

### 4.2 try和catch
* `try`: 尝试执行可能返回错误的表达式，如果失败，立即返回错误。
```zig
const result = try mightFail()
```
* `catch`: 捕获错误平处理
```zig
const result = mightFail() catch |err| {
    std.debug.print("Error: {}\n", .{err});
    return;
}
```

### 4.3 errdefer
* 在函数返回错误时执行清理操作:
```zig
fn example() MyError!void {
    errdefer std.debug.print("Cleanup on error\n", .{});
    return error.InvalidInput;
}
```

## 5.第五天
### 5.1 动态数组
* `std.ArrayList`: 是Zig标准库提供的动态数组，支持添加、删除元素。
* 需要分配器（`std.mem.Allocator`）管理内存
* 常用方法：
	* `init(allocator)`：初始化列表。
	* `append(item)`: 添加元素。
	* `pop()`：移除最后一个元素。
	* `deinit()`：释放内存。
* 示例：
```zig
const std=@import("std");
pub fn main() !void {
	var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
	defer arena.deinit();
	const allocator = arena.allocator();

	var list = std.ArrayList(i32).init(allocator);
	defer list.deinit();

	try list.append(42);
	try list.append(100);

	std.debug.print("List: {d}\n", .{list.items});
}
```

*注：`try`用于处理`append`可能返回的内存分配错误。*
### 5.2 切片操作
* 切片是数组的视图，类型为`[]T`(`T`是元素类型)
* 创建：`array[start..end]`。
* 示例：
```zig
const array = [_]i32{1,2,3,4,5};
const slice = array[1..3]; // 包含2,3
std.debug.print("Slice: {d}\n", .{slice});
```

## 6.第六天
### 6.1 学习 `std.fs` 和 `std.io`
* `std.io`
	1. 提供输入输出功能，如`std.io.getStdOut` (标准输出) 和 `std.io.getStdIn`（标准输入）
	2. `std.io.Writer`接口用于格式化输出，`std.debug.print`是其简单的封装
	示例：
```zig
	const std=@import("std");
	pub fn main() !void {
		const stdout = std.io.getStdOut().writer();
		try stdout.print("Value: {d:.2}\n", .{3.1415926});
	}
```
* 字符串流（模拟文件操作）
	使用`std.io.fixedBufferStream`模拟文件读写
	示例：
```zig
var buffer: [100]u8 = undefined;
var stream = std.io.fixedBufferStream(&buffer);
const writer = stream.writer();
try writer.print("Hello, Zig!");
std.debug.print("Buffer content: {s}\n", .{stream.getWritten()});
```
* `std.fs`
	* 提供文件系统操作，如`std.fs.cwd().openFile`和 `std.fs.File.read`
	示例：
```zig
const file = try std.fs.cwd().openFile("example.txt", .{});
defer file.close();
```
