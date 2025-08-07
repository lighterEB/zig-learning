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
