## 1. 第一天
### 1.1 指针（`*T`和 `[*]T`）
* `*T`单项指针：指向单个值（如 `*i32`指向一个 `i32`）。
* `[*]T`多项指针：指向未知长度的元素序列。
* 使用`&`获取变量地址，`*`解引用访问值。
* 示例（指针操作）：
```zig
const std=@import("std");
pub fn main() !void {
	var x: i32 = 32; 
	var ptr: *i32 = &x; // 指向 x 的指针
	std.debug.print("Value: {}\n", .{ptr.*}); // 解引用
	ptr.* = 100; // 修改值
	std.debug.print("New value: {}\n", .{x});
}
```

### 1.2 内存管理（`std.mem.Allocator`）
* Zig没有自动垃圾回收，内存管理通过分配器（`Allocator`）手动控制
* 常用分配器：`std.heap.page_allocator` (简单但可能会浪费内存)、`std.heap.ArenaAllocator`(批量释放)。
* 分配内存：`allocator.alloc(T, n)`, 释放内存：`allocator.free(ptr)`。
* 示例：
```zig
var arena = std.heap.ArenaAllocator(std.heap.page_allocator);
defer arena.deinit();
const allocator = arena.allocator();
const memory = try allocator.alloc(i32, 5); // 分配 5 个 i32
defer allocator.free(memory);
memory[0] = 42;
std.debug.print("Allocated: {d}\n", .{memory[0]});
```

## 2.第二天
### 2.1 联合（`union`）
* `union` 允许在同一内存位置存储不同类型，但在任何给定时间点，只能存储其中一种类型的值。
* 内存大小由联合中最大的字段决定（因为需要容纳所有可能需要类型）。例如，一个`union`可以定义为包含`i32`（4字节）、`f32`（4字节）或`bool`（1字节），内存分配会取最大值（4字节），但一次只能存储一个值。
#### 2.1.1 与结构体的区别
* 结构体（`struct`）：所有字段同时存在，内存分配是各字段大小之和。
* 联合（`union`）：只有一个字段有效，内存分配是最大字段的大小。
#### 2.1.2 语法
* 语法：`const UnionName = union { field1: Type1, field2: Type2 };`
* 需要手动管理活动字段（不安全）
* 示例：
```zig
const std=@import("std");
const Value = union {
	int: i32,
	float: f32,
}

pub fn main() !void {
	var v = Value{ .int = 42 };
	std.debug.print("Int: {}\n", .{v.int});
	v = Value{ .float = 3.14 };
	std.debug.print("Float: {d:.2} \n", .{v.float});
}
```
### 2.2 标签联合（`union(enum)`）
* 使用`enum`指定活动字段，增加类型安全性。
* 语法：`const UnionName = union(EnumName){ variant1: Type1, variant2: Type2 };`
* 使用`switch`处理不同变体
* 示例：
```zig
const std=@import("std");

  

const Type = enum{ int, float };

const Value = union(Type){
	int: i32,
	float: f32,
};

  

pub fn main() !void {

	const v = [_]Value{
		.{ .int = 10 },
		.{ .float = 3.14 },
		.{ .int = 20 },
	};
	
	  
	
	for (v) |item| {
		switch (item) {
			.int => |i| std.debug.print("Integer: {d}\n", .{i}),
			.float => |f| std.debug.print("Float: {d:.2}\n", .{f}),
		}
	}
}
```

## 3.第三天
### 3.1 `comptime`
* Zig的`comptime`允许在编译时执行代码，生成常量或优化逻辑。
* 用于生成类型、计算常量、性能优化。
* 示例（编译时数组）：
```zig
const std=@import("std");
const fib = blk: {
	var array: [10]i32 = undefined;
	array[0] = 0;
	array[1] = 1;
	for(2..10) |i| {
		array[i] = array[i-1] + array[i-2];
	}
	break :blk array;
};

pub fn main() !void {
	std.debug.print("Fibonacci: {d}\n", .{fib});
}
```
* 示例（泛型函数）
```zig
const std=@import("std");
fn printValue(comptime T: type, value: T) void {
	std.debug.print("Value: {}\n", .{value});
}

pub fn main() !void {
	printValue(i32, 42);
	printValue(f32, 3.14);
}
```

## 4.第四天
### 4.1 Zig模块系统和代码组织
*系统模块（`@import`、`pub`）：*
* Zig使用`@import`导入模块，`pub`标记公开的符号（函数、变量、类型等）。
* 标准库模块通过`@import("std")`导入，自定义模块通过文件路径导入。
* 示例：
```zig
const std=@import("std");
const my_module=@import("my_module.zig");

pub fn main() !void {
	std.debug.print("Standard library print\n", .{});
	my_module.sayHello(); // 自定义模块的方法
}
```
自定义模块：
```zig
pub fn sayHello() void {
	@import("std").debug.print("Hello from my_module!\n", .{});
}
```
*代码组织的最佳实践：*
* 将功能分组到模块文件（如 `math.zig`、`utilsz.zig`)
* 使用`pub`暴露需要跨模块访问的函数或类型。
* 文件名小写，使用下划线（例如 `my_module.zig`）
* 在项目根目录或子目录（如`src/`）存放模块
*字符串处理（`std.mem`）*
* 标准库`std.mem`提供字符串操作，如`std.mem.eql`（比较）、`std.mem.split`（分割）
* 示例：
```zig
const std=@import("std");
pub fn main() !void {
	const str = "Hello,World!";
	var iter = std.mem.splitAny(u8,str,",");
	while (iter.next()) |part| {
		std.debug.print("Part: {s}\n", .{part});
	}
}
```

## 5.第五天
### 5.1 `std.testing`与单元测试
* Zig测试框架：
	* Zig提供内置测试框架，通过`std.testing`模块实现
	* 测试用`test`关键自定义，运行时使用`zig test <file>.zig`
	* 常用函数：
		* `std.testing.expect(expr)`: 断言表达式为真
		* `std.testing.expectEqual(expected, actual)`：断言两值相等
		* `std.testing.expectError(expected, expr)`: 断言表达式返回特定错误
* 示例（简单测试）：
```zig
const std=@import("std");
test "add 1 + 1" {
	try std.testing.expectEqual(2, 1 + 1);
}
```
输出：
```bash
[2025-08-25T14:48:53.886Z] Running test: day5_testing.zig - add 1 + 1
1/1 day5_testing.test.add 1 + 1...OK
All 1 tests passed.
```
* 测试组织：
	* 测试块以`test "description" { ... }`定义
	* 可以在模块中定义测试，与代码分离