//: [Previous](@previous)

import Foundation

/*
 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。

 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？

  

 示例 1：

 输入：n = 2
 输出：2
 解释：有两种方法可以爬到楼顶。
 1. 1 阶 + 1 阶
 2. 2 阶
 示例 2：

 输入：n = 3
 输出：3
 解释：有三种方法可以爬到楼顶。
 1. 1 阶 + 1 阶 + 1 阶
 2. 1 阶 + 2 阶
 3. 2 阶 + 1 阶
 
 LeetCode: https://leetcode.cn/problems/climbing-stairs/description/
 */

// 思路：自顶向下记忆化递归（Memoization）
// 状态定义：dp(n) = 爬到第 n 阶的方案数
// 状态转移：dp(n) = dp(n-1) + dp(n-2)（最后一步爬 1 或 2 阶）
// 本质上等价于斐波那契数列，时间复杂度 O(n)，空间复杂度 O(n)
class Solution {

    // 备忘录，避免重复计算子问题，索引对应台阶数
    var memo: [Int] = []

    func climbStairs(_ n: Int) -> Int {
        memo = [Int](repeating: 0, count: n + 1)
        return dp(n)
    }

    func dp(_ n: Int) -> Int {
        // 基础情况：1 阶 1 种，2 阶 2 种
        guard n > 2 else {
            return n
        }
        // 已计算过，直接返回缓存结果
        if memo[n] > 0 {
            return memo[n]
        }
        // 到达第 n 阶只能从 n-1 或 n-2 阶爬上来
        memo[n] = dp(n - 1) + dp(n - 2)
        return memo[n]
    }
}

// MARK: - Tests

let solution = Solution()

assert(solution.climbStairs(1) == 1, "n=1 应返回 1")
assert(solution.climbStairs(2) == 2, "n=2 应返回 2")
assert(solution.climbStairs(3) == 3, "n=3 应返回 3")
assert(solution.climbStairs(4) == 5, "n=4 应返回 5")
assert(solution.climbStairs(5) == 8, "n=5 应返回 8")
assert(solution.climbStairs(10) == 89, "n=10 应返回 89")
assert(solution.climbStairs(44) == 1134903170, "n=44 应返回 1134903170")
assert(solution.climbStairs(45) == 1836311903, "n=45 应返回 1836311903")

print("所有测试通过 ✓")

//: [Next](@next)
