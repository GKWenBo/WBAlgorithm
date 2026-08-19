//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

 子数组是数组中的一个连续部分。

 示例 1：
 输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
 输出：6
 解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。

 示例 2：
 输入：nums = [1]
 输出：1

 示例 3：
 输入：nums = [5,4,-1,7,8]
 输出：23

 提示：
 1 <= nums.length <= 105
 -104 <= nums[i] <= 104

 进阶：如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的 分治法 求解。

 LeetCode：https://leetcode.cn/problems/maximum-subarray/description/
 */

// MARK: - 解法一：动态规划（Kadane 算法）O(n) 时间，O(1) 空间
class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        // dp_i 表示以 nums[i] 结尾的子数组最大和
        var dp_i = nums[0]
        var res = dp_i   // 结果至少包含第一个元素

        for i in 1..<nums.count {
            // 状态转移：若前段和为负则抛弃（从 nums[i] 重新开始），否则累加延续
            dp_i = max(nums[i], dp_i + nums[i])
            res = max(res, dp_i)
        }

        return res
    }

    // MARK: - 解法二：前缀和 O(n) 时间，O(1) 空间
    //
    // 思路：
    //   prefixSum[i] = nums[0] + ... + nums[i-1]
    //   子数组 [j, i] 的和 = prefixSum[i+1] - prefixSum[j]
    //   为使该值最大，枚举右端 i 时，只需记录左侧最小前缀和 minPrefix
    func maxSubArrayPrefixSum(_ nums: [Int]) -> Int {
        var res = Int.min
        var prefixSum = 0       // 当前前缀和（代表 prefix[i]）
        var minPrefix = 0       // prefix[0] = 0，至少取到空前缀

        for num in nums {
            prefixSum += num
            // 当前前缀和 - 左侧历史最小前缀和 = 以某个位置结尾的最大子数组和
            res = max(res, prefixSum - minPrefix)
            minPrefix = min(minPrefix, prefixSum)
        }

        return res
    }

    // MARK: - 解法三：滑动窗口 O(n) 时间，O(1) 空间
    //
    // 思路：
    //   维护一个可变窗口 [left, right]，不断向右扩展；
    //   当窗口累计和降为负时，负前缀只会拖累后续元素，
    //   直接将左边界跳到 right+1、累计和清零，重新开始。
    func maxSubArraySlidingWindow(_ nums: [Int]) -> Int {
        var windowSum = 0
        var res = Int.min

        for num in nums {
            windowSum += num
            res = max(res, windowSum)
            // 窗口和为负时，重置窗口（等价于 left 移到下一个位置）
            if windowSum < 0 {
                windowSum = 0
            }
        }

        return res
    }
}

// MARK: - 测试

struct TestCase {
    let nums: [Int]
    let expected: Int
    let desc: String
}

let solution = Solution()

let cases: [TestCase] = [
    // 题目示例
    TestCase(nums: [-2, 1, -3, 4, -1, 2, 1, -5, 4], expected: 6,   desc: "题目示例1，[4,-1,2,1]"),
    TestCase(nums: [1],                               expected: 1,   desc: "单元素正数"),
    TestCase(nums: [5, 4, -1, 7, 8],                 expected: 23,  desc: "整个数组最优"),

    // 边界 & 特殊情况
    TestCase(nums: [-1],                              expected: -1,  desc: "单个负数"),
    TestCase(nums: [-2, -1],                          expected: -1,  desc: "全负，取最大单元素"),
    TestCase(nums: [-3, -2, -1],                      expected: -1,  desc: "全负，取绝对值最小"),
    TestCase(nums: [0, 0, 0],                         expected: 0,   desc: "全零"),
    TestCase(nums: [1, -1, 1, -1, 1],                 expected: 1,   desc: "交替正负"),
    TestCase(nums: [2, -1, 2, -1, 2],                 expected: 4,   desc: "跨越负数仍合算"),
    TestCase(nums: [100, -50, 100],                   expected: 150, desc: "中间负数小于两端之和"),
]

typealias Solver = ([Int]) -> Int
let solvers: [(String, Solver)] = [
    ("动态规划",   solution.maxSubArray),
    ("前缀和",    solution.maxSubArrayPrefixSum),
    ("滑动窗口",  solution.maxSubArraySlidingWindow),
]

for (name, solver) in solvers {
    print("── \(name) ──")
    var passed = 0
    for (i, tc) in cases.enumerated() {
        let result = solver(tc.nums)
        let ok = result == tc.expected
        if ok { passed += 1 }
        print("  Test \(i + 1): \(ok ? "✅" : "❌")  [\(tc.desc)]  expected=\(tc.expected)  got=\(result)")
    }
    print("  \(passed)/\(cases.count) 用例通过\n")
}

//: [Next](@next)
