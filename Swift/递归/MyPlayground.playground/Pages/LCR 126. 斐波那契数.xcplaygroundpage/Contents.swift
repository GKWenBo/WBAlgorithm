//: [Previous](@previous)

import Foundation

/*
 写一个函数，输入 n ，求斐波那契（Fibonacci）数列的第 n 项（即 F(N)）。斐波那契数列的定义如下：

 F(0) = 0,   F(1) = 1
 F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
 斐波那契数列由 0 和 1 开始，之后的斐波那契数就是由之前的两数相加而得出。

 答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

 示例 1：
 输入：n = 2
 输出：1
 示例 2：

 输入：n = 5
 输出：5

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/fei-bo-na-qi-shu-lie-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    /// 递归实现
    func fib(_ n: Int) -> Int {
        guard n > 1 else {
            return n
        }
        return fib(n - 2) + fib(n - 1)
    }
    
    /// 通过迭代实现
    func fib1(_ n: Int) -> Int {
        guard n > 1 else { return n }
        
        let constant = 1000000007;
        var first = 0;
        var second = 1;
        for _ in 0..<n - 1 {
            let sum = first + second
            first = second % constant
            second = sum % constant
        }
        return second
    }
}

/// test
var solution = Solution()
solution.fib(2)

//: [Next](@next)
