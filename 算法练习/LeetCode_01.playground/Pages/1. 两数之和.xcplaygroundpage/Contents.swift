//: [Previous](@previous)

import Foundation
/*
 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

 你可以假设每种输入只会对应一个答案，并且你不能使用两次相同的元素。

 你可以按任意顺序返回答案。



 示例 1：

 输入：nums = [2,7,11,15], target = 9
 输出：[0,1]
 解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
 示例 2：

 输入：nums = [3,2,4], target = 6
 输出：[1,2]
 示例 3：

 输入：nums = [3,3], target = 6
 输出：[0,1]


 提示：

 2 <= nums.length <= 104
 -109 <= nums[i] <= 109
 -109 <= target <= 109
 只会存在一个有效答案


 进阶：你可以想出一个时间复杂度小于 O(n2) 的算法吗？


 LeetCode: https://leetcode.cn/problems/two-sum/description/
 */

// MARK: - 解法：哈希表（时间 O(n)，空间 O(n)）
//
// 思路：遍历数组，对每个元素 num 计算其"互补值" complement = target - num，
// 若 complement 已在哈希表中，则找到答案；否则将 num 及其下标存入哈希表。
// 注意：双指针法要求数组有序，不适用于本题（索引会错位）。

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // key: 数组元素值，value: 该元素在原数组中的下标
        var map: [Int: Int] = [:]

        for (i, num) in nums.enumerated() {
            let complement = target - num
            // 若互补值已存在，直接返回两个下标
            if let j = map[complement] {
                return [j, i]
            }
            map[num] = i
        }
        return []
    }
}

// MARK: - 测试

/// 验证结果是否与期望相符（结果顺序无关）
func assertEqual(_ result: [Int], _ expected: [Int], testName: String) {
    let pass = Set(result) == Set(expected) && result.count == expected.count
    if pass {
        print("✅ \(testName) 通过")
    } else {
        print("❌ \(testName) 失败 — 期望 \(expected)，实际 \(result)")
    }
}

let solution = Solution()

// 示例 1：已排序数组，结果为首尾两个元素
assertEqual(solution.twoSum([2, 7, 11, 15], 9),  [0, 1], testName: "示例1 - 有序数组")

// 示例 2：无序数组，双指针法在此会出错，哈希表法正确
assertEqual(solution.twoSum([3, 2, 4], 6),        [1, 2], testName: "示例2 - 无序数组")

// 示例 3：数组中存在重复元素
assertEqual(solution.twoSum([3, 3], 6),           [0, 1], testName: "示例3 - 重复元素")

// 额外测试：包含负数
assertEqual(solution.twoSum([-1, -2, -3, -4, -5], -8), [2, 4], testName: "额外 - 负数")

// 额外测试：包含零
assertEqual(solution.twoSum([0, 4, 3, 0], 0),    [0, 3], testName: "额外 - 含零")

// 额外测试：答案在数组末尾
assertEqual(solution.twoSum([1, 2, 3, 4, 5], 9), [3, 4], testName: "额外 - 答案在末尾")

//: [Next](@next)
