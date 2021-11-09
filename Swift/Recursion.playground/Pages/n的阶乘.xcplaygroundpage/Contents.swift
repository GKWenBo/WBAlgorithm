//: [Previous](@previous)

import Foundation

/// 递归实现
func factorial(n: Int) -> Int {
    guard n > 1 else {
        return 1
    }
    return factorial(n: n - 1) * n
}

/// 循环实现
func factorial1(n: Int) -> Int {
    var num = 1;
    for i in 1...n {
        num = num * i
    }
    return num
}

factorial(n: 10)
factorial1(n: 10)

//: [Next](@next)
