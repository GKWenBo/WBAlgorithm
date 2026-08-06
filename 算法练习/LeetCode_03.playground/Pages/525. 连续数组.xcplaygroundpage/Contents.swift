//: [Previous](@previous)

import Foundation

/*
 题目：525. 连续数组（Contiguous Array）
 给定一个二进制数组 nums，找到含有相同数量的 0 和 1 的最长连续子数组，并返回该子数组的长度。

 示例 1：
 输入：nums = [0,1]
 输出：2
 说明：[0, 1] 是具有相同数量 0 和 1 的最长连续子数组。

 示例 2：
 输入：nums = [0,1,0]
 输出：2
 说明：[0, 1] (或 [1, 0]) 是具有相同数量 0 和 1 的最长连续子数组。

 示例 3：
 输入：nums = [0,1,1,1,1,1,0,0,0]
 输出：6
 解释：[1,1,1,0,0,0] 是具有相同数量 0 和 1 的最长连续子数组。

 提示：
 1 <= nums.length <= 10^5
 nums[i] 不是 0 就是 1

 LeetCode：https://leetcode.cn/problems/contiguous-array/description/

 —— 核心思路（前缀和 + 哈希表，O(n) 时间 / O(n) 空间）——
 把 0 看成 -1、把 1 看成 +1，则「某段区间内 0 与 1 数量相等」⇔「该区间转换后的和为 0」。
 问题转化为：在转换后的数组里，找「和等于 0」的最长连续子数组。
 用前缀和 preSum：若 preSum[i] == preSum[j]（i < j），则区间 (i, j] 的和为 0，长度 = j - i。
 用哈希表只记录「每个前缀和第一次出现的下标」，即可在 O(n) 内求出最大长度。
 */

// MARK: - 解法：前缀和 + 哈希表（O(n)）

class Solution {
    /// 返回含有相同数量 0 和 1 的最长连续子数组长度
    func findMaxLength(_ nums: [Int]) -> Int {
        let n = nums.count

        // preSum[i] 表示「前 i 个元素」按 0→-1、1→+1 转换后的累加和
        // preSum[0] = 0（空前缀）；长度取 n+1 以便容纳 preSum[n]
        var preSum = [Int](repeating: 0, count: n + 1)

        // 递推：preSum[i] = preSum[i-1] + (nums[i-1] == 0 ? -1 : 1)
        // 注意：循环范围必须覆盖到 i = n，否则会漏掉最后一个前缀和
        for i in 1...n {
            let value = nums[i - 1] == 0 ? -1 : 1
            preSum[i] = preSum[i - 1] + value
        }

        // map 记录「某个前缀和第一次出现的下标」
        // 若之后又遇到相同的前缀和，说明中间那段区间的和为 0，更新最大长度
        var map: [Int: Int] = [:]
        var res = 0

        // 遍历所有前缀和下标 0...n（原代码 BUG：写成了 0..<n，会漏掉末尾）
        for i in 0...n {
            let key = preSum[i]
            if let j = map[key] {
                // key 之前出现过 → 区间 (j, i] 的 0/1 数量相等，长度 = i - j
                res = max(res, i - j)
            } else {
                // 第一次见到该前缀和，记录其下标（保证记录的是「最早」出现的，从而得到最长区间）
                map[key] = i
            }
        }

        return res
    }
}

// MARK: - 暴力解法（仅用于测试对拍，O(n^2)，不作为正式答案）

/// 通过枚举所有区间，统计 0/1 数量，返回最长相等子数组长度。
/// 逻辑简单、不易出错，用来交叉验证优化解的正确性。
func findMaxLengthBruteForce(_ nums: [Int]) -> Int {
    let n = nums.count
    var maxLen = 0
    for i in 0..<n {
        var zeros = 0, ones = 0
        for j in i..<n {
            if nums[j] == 0 { zeros += 1 } else { ones += 1 }
            if zeros == ones {
                maxLen = max(maxLen, j - i + 1)
            }
        }
    }
    return maxLen
}

// MARK: - 测试

/// 轻量级断言：打印 PASS / FAIL，并统计失败数量（不直接 fatalError，避免 playground 中断）
var failureCount = 0
@MainActor func assertEqual(_ actual: Int, _ expected: Int, _ caseName: String) {
    if actual == expected {
        print("✅ PASS | \(caseName) | 期望 \(expected)，实际 \(actual)")
    } else {
        failureCount += 1
        print("❌ FAIL | \(caseName) | 期望 \(expected)，实际 \(actual)")
    }
}

let s = Solution()

print("===== 1. 官方/题目示例 =====")
assertEqual(s.findMaxLength([0, 1]), 2, "示例1 [0,1]")
assertEqual(s.findMaxLength([0, 1, 0]), 2, "示例2 [0,1,0]")
assertEqual(s.findMaxLength([0, 1, 1, 1, 1, 1, 0, 0, 0]), 6, "示例3")

print("\n===== 2. 边界 & 特殊用例 =====")
assertEqual(s.findMaxLength([0, 0, 0, 0]), 0, "全 0")
assertEqual(s.findMaxLength([1, 1, 1, 1]), 0, "全 1")
assertEqual(s.findMaxLength([0]), 0, "单元素 0")
assertEqual(s.findMaxLength([1]), 0, "单元素 1")
assertEqual(s.findMaxLength([0, 0, 1, 1, 0, 0, 1, 1]), 8, "整体相等(8)")
assertEqual(s.findMaxLength([0, 1, 0, 1]), 4, "交替 01")
assertEqual(s.findMaxLength([1, 0, 1, 0, 1, 0]), 6, "交替 10(6)")
assertEqual(s.findMaxLength([0, 0, 1, 0, 1, 1, 0, 0, 1, 1]), 10, "整体相等(10)")

print("\n===== 3. 暴力解对拍（随机 500 组） =====")
var fuzzPass = 0
for _ in 0..<500 {
    let len = Int.random(in: 1...200)
    let nums = (0..<len).map { _ in Int.random(in: 0...1) }
    let a = s.findMaxLength(nums)
    let b = findMaxLengthBruteForce(nums)
    if a == b {
        fuzzPass += 1
    } else {
        failureCount += 1
        print("❌ 对拍不一致: \(nums) -> 优化解 \(a)，暴力解 \(b)")
    }
}
print("对拍通过 \(fuzzPass) / 500")

print("\n===== 结果汇总 =====")
if failureCount == 0 {
    print("🎉 全部测试通过！算法正确。")
} else {
    print("⚠️ 存在 \(failureCount) 个失败用例，请检查。")
}

//: [Next](@next)
