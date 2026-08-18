//: [Previous](@previous)

import Foundation

/*
 给你一份工作时间表 hours，上面记录着某一位员工每天的工作小时数。

 我们认为当员工一天中的工作小时数大于 8 小时的时候，那么这一天就是「劳累的一天」。

 所谓「表现良好的时间段」，意味在这段时间内，「劳累的天数」是严格 大于「不劳累的天数」。

 请你返回「表现良好时间段」的最大长度。



 示例 1：

 输入：hours = [9,9,6,0,6,6,9]
 输出：3
 解释：最长的表现良好时间段是 [9,9,6]。
 示例 2：

 输入：hours = [6,6,6]
 输出：0


 提示：

 1 <= hours.length <= 104
 0 <= hours[i] <= 16

LeetCode：https://leetcode.cn/problems/longest-well-performing-interval/description/
 */

// 思路：前缀和 + 哈希表
//
// 将每天转化为分值：劳累(>8h) → +1，不劳累 → -1。
// 前缀和 preSum[i] 表示前 i 天的总分值。
// 子数组 [j, i-1] 表现良好 ⟺ preSum[i] - preSum[j] > 0 ⟺ preSum[i] > preSum[j]。
//
// 两种情况：
//   1. preSum[i] > 0：从第 0 天到第 i-1 天整段都表现良好，长度为 i。
//   2. preSum[i] ≤ 0：寻找最早出现 preSum-1 的位置 j，
//      使差值恰好为 1（最小正差），对应子数组长度 i - j 最大。
//
// 时间复杂度 O(n)，空间复杂度 O(n)
class Solution {
    func longestWPI(_ hours: [Int]) -> Int {
        var preSum = 0
        // key: 前缀和值，value: 该值首次出现的索引（越早出现，子数组越长）
        var firstOccurrence: [Int: Int] = [:]
        var res = 0

        for i in 1...hours.count {
            // 当天累加分值（注意索引 i-1，循环变量 i 从 1 开始对应前缀和下标）
            preSum += hours[i - 1] > 8 ? 1 : -1

            // 只记录首次出现，确保用最左侧的 j 来最大化子数组长度
            if firstOccurrence[preSum] == nil {
                firstOccurrence[preSum] = i
            }

            if preSum > 0 {
                // 整个前缀 [0, i-1] 都满足条件
                res = max(res, i)
            } else {
                // 寻找 preSum-1 首次出现的位置 j，子数组长度为 i - j
                if let j = firstOccurrence[preSum - 1] {
                    res = max(res, i - j)
                }
            }
        }

        return res
    }
}

// MARK: - 测试

let solution = Solution()

// 示例 1：最长子段 [9,9,6]（2 劳累 > 1 不劳累），长度 3
assert(solution.longestWPI([9, 9, 6, 0, 6, 6, 9]) == 3, "示例1失败")

// 示例 2：全为不劳累天，无满足条件的子段
assert(solution.longestWPI([6, 6, 6]) == 0, "示例2失败")

// 单个劳累日
assert(solution.longestWPI([9]) == 1, "单个劳累日失败")

// 单个非劳累日
assert(solution.longestWPI([6]) == 0, "单个非劳累日失败")

// 全是劳累日，整段均表现良好
assert(solution.longestWPI([9, 9, 9, 9, 9]) == 5, "全劳累日失败")

// 整段 2 劳累 > 1 不劳累，长度 3
assert(solution.longestWPI([9, 6, 9]) == 3, "交替劳累失败")

// 仅 hours[1]=9 一天劳累，最长子段为 [9]，长度 1
assert(solution.longestWPI([6, 9, 6]) == 1, "中间劳累失败")

// 前缀和先降后升，整段 3 劳累 > 2 不劳累，答案为全段长度 5
assert(solution.longestWPI([6, 6, 9, 9, 9]) == 5, "先降后升失败")

// 最优子段不从头开始：hours[1..3]=[6,9,9] 中 2 劳累 > 1 不劳累，长度 3
assert(solution.longestWPI([6, 6, 9, 9, 6, 6]) == 3, "中间子段失败")

// 前三天 [9,9,6] 满足 2>1，之后大量不劳累拉低总和，答案为 3
assert(solution.longestWPI([9, 9, 6, 6, 6, 6]) == 3, "前劳后闲失败")

print("所有测试通过 ✓")

//: [Next](@next)
