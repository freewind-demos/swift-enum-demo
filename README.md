# Swift 枚举 Demo

## 简介

本 demo 展示 Swift 枚举的强大功能。Swift 的枚举远比其他语言的枚举强大——它可以包含**关联值**、**方法**、**计算属性**，甚至支持**递归**。

## 基本原理

### 什么是枚举？

枚举（enum）是一种**受限的类型**，它定义了一组相关的值。在很多语言中，枚举只是整数的别名：

```c
// C 语言
enum Direction { North, South, East, West };
```

但 Swift 的枚举是**一等公民**，功能强大到接近其他语言的"联合体"或"标签联合"。

### Swift 枚举的核心特性

1. **关联值（Associated Values）** — 每个 case 可以携带额外数据
2. **原始值（Raw Values）** — 每个 case 可以有默认值
3. **方法** — 枚举可以包含实例方法
4. **计算属性** — 枚举可以有计算属性
5. **递归枚举** — 枚举可以嵌套自己

---

## 启动和使用

### 环境要求

- Swift 5.0+
- macOS 或 Linux

### 安装和运行

```bash
cd swift-enum-demo
swift run
```

---

## 教程

### 基本枚举

```swift
enum Direction {
    case north
    case south
    case east
    case west
}
var dir = Direction.north
dir = .south  // 类型推断
print("方向: \(dir)")
```

### 关联值（Associated Values）

关联值是 Swift 枚举最强大的特性——每个 case 可以携带不同的数据：

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)  // UPC 条形码：4个数字
    case qrCode(String)             // 二维码：字符串
}
```

使用关联值：

```swift
let productCode = Barcode.upc(1, 2, 3, 4)
let qrCode = Barcode.qrCode("https://example.com")

switch productCode {
case .upc(let a, let b, let c, let d):
    print("UPC: \(a)-\(b)-\(c)-\(d)")
case .qrCode(let code):
    print("QR: \(code)")
}
```

**原理**：关联值让枚举可以表示"同一种类型的不同形状"，类似于其他语言的"联合体"或"变体"。

**使用场景**：
- API 响应（成功/失败）
- 网络状态（加载中/成功/错误）
- 表单验证（有效/无效的原因）

### 原始值（Raw Values）

原始值是每个 case 的固定默认值：

```swift
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
let earth = Planet(rawValue: 3)
print("地球: \(earth!)")
```

**注意**：
- 原始值必须是 Int 或 String
- 如果不指定，默认递增
- 可以通过 `rawValue` 获取原始值
- 可以通过 `init(rawValue:)` 从原始值创建枚举

### 枚举方法

Swift 枚举可以添加实例方法：

```swift
enum Color {
    case red, green, blue

    func description() -> String {
        switch self {
        case .red: return "红色"
        case .green: return "绿色"
        case .blue: return "蓝色"
        }
    }
}
print("颜色: \(Color.blue.description())")
```

### 递归枚举（Recursive Enum）

递归枚举是指枚举的某个 case 包含枚举自身：

```swift
enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

使用递归枚举实现计算器：

```swift
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

// 构建表达式: 5 + (3 * 4)
let expr = ArithmeticExpression.addition(
    .number(5),
    .multiplication(.number(3), .number(4))
)
print("表达式结果: \(evaluate(expr))")  // 输出: 17
```

**原理**：递归枚举允许我们构建树形结构，特别适合表示：
- 数学表达式
- XML/JSON 解析树
- 文件系统
- 组织结构

### 枚举作为状态机

枚举非常适合表示状态机：

```swift
enum NetworkState {
    case idle
    case loading
    case success(Data)
    case failure(Error)
}
```

---

## 关键代码详解

### 关联值的内存布局

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

编译器会为每个关联值分配足够的内存：

```
Barcode.upc(1, 2, 3, 4)
┌─────────────────────────────────────┐
│ tag: 0 (upc) │ 1 │ 2 │ 3 │ 4      │
└─────────────────────────────────────┘

Barcode.qrCode("https://...")
┌─────────────────────────────────────┐
│ tag: 1 (qrCode) │ String 指针      │
└─────────────────────────────────────┘
```

### 递归枚举的展开

```swift
let expr = ArithmeticExpression.addition(
    .number(5),
    .multiplication(.number(3), .number(4))
)
```

内存结构：

```
addition
  ├── number(5)
  └── multiplication
        ├── number(3)
        └── number(4)
```

---

## 总结

Swift 枚举是极其强大的类型：

1. **关联值** — 让枚举可以表示复杂的数据结构
2. **原始值** — 提供默认的整数值或字符串
3. **方法** — 可以在枚举中添加业务逻辑
4. **递归** — 支持树形结构的表达

使用枚举的场景：
- 状态管理（UI 状态、API 状态）
- 结果类型（成功/失败）
- 选项配置（固定选项列表）
- 树形结构（数学表达式、AST）
