//: [Previous](@previous)

import Foundation

import UIKit

func fib(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    
    let constant = 1000000007
    
    var first = 0
    var second = 1
    for _ in 0..<n-1 {
        let sum = first + second
        first = second % constant
        second = sum % constant
    }
    return second
}

print(fib(45))


//: [Next](@next)
