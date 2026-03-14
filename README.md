# Swift 枚举 Demo

## 简介

展示 Swift 枚举的强大功能：关联值、原始值、方法、递归。

## 启动和使用

```bash
cd swift-enum-demo
swift run
```

## 教程

### 关联值

枚举可以存储额外信息：
```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

### 原始值

可以给枚举成员指定原始值（Int 或 String）

### 方法

枚举可以添加计算属性和方法

### 递归枚举

Swift 5.5+ 支持 indirect 关键字实现递归枚举
