//: [Previous](@previous)

import Foundation

class Solution {
    func fib(_ n: Int) -> Int {
        guard n > 1 else {
            return n
        }
        return fib(n - 2) + fib(n - 1)
    }
}

/// test
var solution = Solution()
solution.fib(4)

//: [Next](@next)
