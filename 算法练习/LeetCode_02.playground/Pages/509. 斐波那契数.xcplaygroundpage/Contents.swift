//: [Previous](@previous)

import Foundation

/*
 斐波那契数 （通常用 F(n) 表示）形成的序列称为 斐波那契数列 。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：

 F(0) = 0，F(1) = 1
 F(n) = F(n - 1) + F(n - 2)，其中 n > 1
 给定 n ，请计算 F(n) 。

  

 示例 1：

 输入：n = 2
 输出：1
 解释：F(2) = F(1) + F(0) = 1 + 0 = 1
 示例 2：

 输入：n = 3
 输出：2
 解释：F(3) = F(2) + F(1) = 1 + 1 = 2
 示例 3：

 输入：n = 4
 输出：3
 解释：F(4) = F(3) + F(2) = 2 + 1 = 3
  

 提示：

 0 <= n <= 30
 
 LeetCode: https://leetcode.cn/problems/fibonacci-number/description/
 */

class Solution {

    // 缓存数组，-1 表示未计算
    var memo: [Int] = []

    // MARK: - 方法一：朴素递归
    // 时间复杂度：O(2^n)，存在大量重复子问题
    // 空间复杂度：O(n)，递归调用栈深度
    func fib(_ n: Int) -> Int {
        if n == 0 || n == 1 {
            return n
        }
        return fib(n - 1) + fib(n - 2)
    }

    // MARK: - 方法二：记忆化递归（自顶向下动态规划）
    // 时间复杂度：O(n)，每个子问题只计算一次
    // 空间复杂度：O(n)，memo 数组 + 递归栈
    func fib1(_ n: Int) -> Int {
        memo = [Int](repeating: -1, count: n + 1)
        return db(n)
    }

    // 递归求解，结果存入 memo 避免重复计算
    func db(_ n: Int) -> Int {
        if n == 0 || n == 1 {
            return n
        }

        // 已计算过，直接返回缓存值
        if memo[n] != -1 {
            return memo[n]
        }

        memo[n] = db(n - 1) + db(n - 2)
        return memo[n]
    }
}

// MARK: - Tests

import XCTest

class FibTests: XCTestCase {
    let solution = Solution()

    // MARK: fib (递归)

    func test_fib_base_zero() {
        XCTAssertEqual(solution.fib(0), 0)
    }

    func test_fib_base_one() {
        XCTAssertEqual(solution.fib(1), 1)
    }

    func test_fib_two() {
        XCTAssertEqual(solution.fib(2), 1)
    }

    func test_fib_three() {
        XCTAssertEqual(solution.fib(3), 2)
    }

    func test_fib_four() {
        XCTAssertEqual(solution.fib(4), 3)
    }

    func test_fib_ten() {
        XCTAssertEqual(solution.fib(10), 55)
    }

    func test_fib_thirty() {
        XCTAssertEqual(solution.fib(30), 832040)
    }

    // MARK: fib1 (记忆化递归)

    func test_fib1_base_zero() {
        XCTAssertEqual(solution.fib1(0), 0)
    }

    func test_fib1_base_one() {
        XCTAssertEqual(solution.fib1(1), 1)
    }

    func test_fib1_two() {
        XCTAssertEqual(solution.fib1(2), 1)
    }

    func test_fib1_ten() {
        XCTAssertEqual(solution.fib1(10), 55)
    }

    func test_fib1_thirty() {
        XCTAssertEqual(solution.fib1(30), 832040)
    }
}

FibTests.defaultTestSuite.run()

//: [Next](@next)
