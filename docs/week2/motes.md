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
