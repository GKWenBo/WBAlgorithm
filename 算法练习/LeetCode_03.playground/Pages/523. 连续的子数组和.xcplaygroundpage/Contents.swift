//: [Previous](@previous)

import Foundation

/*
 题目：523. 连续的子数组和（Continuous Subarray Sum）
 给你一个整数数组 nums 和一个整数 k，如果 nums 有一个「好的子数组」返回 true，否则返回 false。

 一个好的子数组满足：
   1. 长度至少为 2；
   2. 子数组元素总和为 k 的倍数（0 始终视为 k 的倍数）。

 示例 1：
 输入：nums = [23,2,4,6,7], k = 6
 输出：true
 解释：[2,4] 大小为 2，和为 6。

 示例 2：
 输入：nums = [23,2,6,4,7], k = 6
 输出：true
 解释：整个数组大小为 5，和为 42 = 7*6。

 示例 3：
 输入：nums = [23,2,6,4,7], k = 13
 输出：false

 提示：
 1 <= nums.length <= 10^5
 0 <= nums[i] <= 10^9
 1 <= k <= 2^31 - 1

 LeetCode: https://leetcode.cn/problems/continuous-subarray-sum/description/

 —— 核心思路（前缀和 + 同余 + 哈希表，O(n) 时间 / O(n) 空间）——
 记前缀和 preSum[i] = nums[0] + ... + nums[i-1]（preSum[0] = 0）。
 子数组 nums[l..<r] 的和为 preSum[r] - preSum[l]。
 它是 k 的倍数 ⇔ (preSum[r] - preSum[l]) % k == 0 ⇔ preSum[r] % k == preSum[l] % k（同余定理）。
 于是问题转化为：是否存在两个下标 l < r，使 preSum[r] 与 preSum[l] 模 k 同余，且区间长度 r - l >= 2。

 做法：
   - 用哈希表 map 记录「每个余数第一次出现的下标」（取第一次出现 → 区间最长，最容易满足长度 >= 2）。
   - 再遍历一次，若当前余数之前出现过、且下标差 >= 2，即找到好的子数组，返回 true。
 说明：本题 nums[i] >= 0，前缀和单调非负，取模不会涉及负数，无需额外处理符号。
 */

class Solution {
    /// 是否存在长度 >= 2 且和为 k 倍数的子数组
    func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
        let n = nums.count

        // preSum[i] = 前 i 个元素之和；长度取 n+1 以便容纳 preSum[n]
        var preSum = [Int](repeating: 0, count: n + 1)
        for i in 1...n {
            preSum[i] = preSum[i - 1] + nums[i - 1]
        }

        // 第一遍：记录「每个余数第一次出现的下标」
        // 取首次出现，是为了让后续匹配到最靠左的 l，从而得到最长的候选区间
        var map: [Int: Int] = [:]
        for i in 0..<preSum.count {
            let key = preSum[i] % k
            if map[key] == nil {
                map[key] = i
            }
        }

        // 第二遍：检查是否存在 r > l 且同余、且长度 r - l >= 2
        for i in 1..<preSum.count {
            let key = preSum[i] % k
            if let j = map[key], i - j >= 2 {
                // 子数组 nums[j..<i] 长度为 i - j（>=2），且其和 = preSum[i]-preSum[j] 是 k 的倍数
                return true
            }
        }
        return false
    }
}

// MARK: - 暴力解法（仅用于测试对拍，O(n^2)，不作为正式答案）

/// 枚举所有长度 >= 2 的子数组，判断其和是否为 k 的倍数。
/// 逻辑直白、不易出错，用来交叉验证优化解的正确性。
func checkSubarraySumBruteForce(_ nums: [Int], _ k: Int) -> Bool {
    let n = nums.count
    for l in 0..<n {
        var sum = 0
        for r in l..<n {
            sum += nums[r]
            // 子数组 nums[l...r] 长度 = r - l + 1，需 >= 2
            if r - l + 1 >= 2 && sum % k == 0 {
                return true
            }
        }
    }
    return false
}

// MARK: - 测试

/// 轻量级断言：打印 PASS / FAIL，并统计失败数量（不直接 fatalError，避免 playground 中断）
var failureCount = 0
@MainActor func assertEqual(_ actual: Bool, _ expected: Bool, _ caseName: String) {
    if actual == expected {
        print("✅ PASS | \(caseName)")
    } else {
        failureCount += 1
        print("❌ FAIL | \(caseName) | 期望 \(expected)，实际 \(actual)")
    }
}

let s = Solution()

print("===== 1. 官方/题目示例 =====")
assertEqual(s.checkSubarraySum([23, 2, 4, 6, 7], 6), true, "示例1 k=6")
assertEqual(s.checkSubarraySum([23, 2, 6, 4, 7], 6), true, "示例2 k=6")
assertEqual(s.checkSubarraySum([23, 2, 6, 4, 7], 13), false, "示例3 k=13")

print("\n===== 2. 边界 & 特殊用例 =====")
assertEqual(s.checkSubarraySum([0, 0], 1), true, "[0,0] k=1 (和为0)")
assertEqual(s.checkSubarraySum([0], 1), false, "单元素 k=1 (长度不足)")
assertEqual(s.checkSubarraySum([1], 1), false, "单元素 k=1 (长度不足)")
assertEqual(s.checkSubarraySum([1, 1], 2), true, "[1,1] k=2")
assertEqual(s.checkSubarraySum([1, 2], 3), true, "[1,2] k=3")
assertEqual(s.checkSubarraySum([5, 0, 0], 1), true, "[5,0,0] k=1")
assertEqual(s.checkSubarraySum([2, 2], 4), true, "[2,2] k=4")
assertEqual(s.checkSubarraySum([1, 0, 1, 0], 1), true, "[1,0,1,0] k=1")
assertEqual(s.checkSubarraySum([0, 1, 0], 2), false, "[0,1,0] k=2 (均不足)")
assertEqual(s.checkSubarraySum([1, 2, 3], 7), false, "[1,2,3] k=7 (无)")
assertEqual(s.checkSubarraySum([1, 0, 1], 2), true, "[1,0,1] k=2 (整体和为2)")

print("\n===== 3. 暴力解对拍（随机 1000 组） =====")
var fuzzPass = 0
for _ in 0..<1000 {
    let len = Int.random(in: 1...40)
    let nums = (0..<len).map { _ in Int.random(in: 0...20) }
    let k = Int.random(in: 1...15)
    let a = s.checkSubarraySum(nums, k)
    let b = checkSubarraySumBruteForce(nums, k)
    if a == b {
        fuzzPass += 1
    } else {
        failureCount += 1
        print("❌ 对拍不一致: nums=\(nums) k=\(k) -> 优化解 \(a)，暴力解 \(b)")
    }
}
print("对拍通过 \(fuzzPass) / 1000")

print("\n===== 结果汇总 =====")
if failureCount == 0 {
    print("🎉 全部测试通过！算法正确。")
} else {
    print("⚠️ 存在 \(failureCount) 个失败用例，请检查。")
}

//: [Next](@next)
