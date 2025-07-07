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