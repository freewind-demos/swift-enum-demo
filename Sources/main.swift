// swift-enum-demo.swift

// ============ 基本枚举 ============
enum Direction {
    case north
    case south
    case east
    case west
}
var dir = Direction.north
dir = .south  // 类型推断
print("方向: \(dir)")

// ============ 关联值 ============
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
let productCode = Barcode.upc(1, 2, 3, 4)
let qrCode = Barcode.qrCode("https://example.com")

switch productCode {
case .upc(let a, let b, let c, let d):
    print("UPC: \(a)-\(b)-\(c)-\(d)")
case .qrCode(let code):
    print("QR: \(code)")
}

// ============ 原始值 ============
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
let earth = Planet(rawValue: 3)
print("地球: \(earth!)")

// ============ 枚举方法 ============
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

// ============ 枚举递归 ============
enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

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

let expr = ArithmeticExpression.addition(
    .number(5),
    .multiplication(.number(3), .number(4))
)
print("表达式结果: \(evaluate(expr))")
