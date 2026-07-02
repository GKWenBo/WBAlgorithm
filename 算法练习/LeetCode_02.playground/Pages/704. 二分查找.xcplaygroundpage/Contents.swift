//: [Previous](@previous)

import Foundation

/*
 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果 target 存在返回下标，否则返回 -1。

 你必须编写一个具有 O(log n) 时间复杂度的算法。


 示例 1:

 输入: nums = [-1,0,3,5,9,12], target = 9
 输出: 4
 解释: 9 出现在 nums 中并且下标为 4
 示例 2:

 输入: nums = [-1,0,3,5,9,12], target = 2
 输出: -1
 解释: 2 不存在 nums 中因此返回 -1
  

 提示：

 你可以假设 nums 中的所有元素是不重复的。
 n 将在 [1, 10000]之间。
 nums 的每个元素都将在 [-9999, 9999]之间。
 
 LeetCode: http://leetcode.cn/problems/binary-search/
 */

class Solution {
    /// 二分查找：在有序数组中查找目标值，返回其下标，不存在则返回 -1
    /// 时间复杂度 O(log n)，空间复杂度 O(1)
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1

        // 闭区间 [left, right]，当 left > right 时区间为空，退出循环
        while left <= right {
            // 用 left + (right - left) / 2 而非 (left + right) / 2，防止整数溢出
            let mid = left + (right - left) / 2

            if nums[mid] < target {
                // 目标在右半区，收缩左边界
                left = mid + 1
            } else if nums[mid] > target {
                // 目标在左半区，收缩右边界
                right = mid - 1
            } else if nums[mid] == target {
                // 找到目标，直接返回下标
                return mid
            }
        }
        return -1
    }
}

// MARK: - 测试

let solution = Solution()

/// 断言辅助：结果不符时打印错误信息
func assertEqual(_ result: Int, _ expected: Int, _ desc: String) {
    if result == expected {
        print("✅ PASS \(desc)  result: \(result)")
    } else {
        print("❌ FAIL \(desc)  expected: \(expected), got: \(result)")
    }
}

// 题目示例 1：target 存在，返回下标 4
assertEqual(solution.search([-1, 0, 3, 5, 9, 12], 9),  4, "示例1 - 目标存在")

// 题目示例 2：target 不存在，返回 -1
assertEqual(solution.search([-1, 0, 3, 5, 9, 12], 2), -1, "示例2 - 目标不存在")

// 边界：target 是数组第一个元素
assertEqual(solution.search([-1, 0, 3, 5, 9, 12], -1), 0, "边界 - 目标在最左侧")

// 边界：target 是数组最后一个元素
assertEqual(solution.search([-1, 0, 3, 5, 9, 12], 12), 5, "边界 - 目标在最右侧")

// 边界：单元素数组，能找到
assertEqual(solution.search([5], 5), 0, "单元素 - 找到")

// 边界：单元素数组，找不到
assertEqual(solution.search([5], 3), -1, "单元素 - 未找到")

// 边界：target 小于所有元素
assertEqual(solution.search([1, 3, 5, 7], -99), -1, "目标小于所有元素")

// 边界：target 大于所有元素
assertEqual(solution.search([1, 3, 5, 7], 99), -1, "目标大于所有元素")

// 偶数长度数组，target 在中间偏左
assertEqual(solution.search([1, 3, 5, 7], 3), 1, "偶数长度 - 中间偏左")

// 全负数数组
assertEqual(solution.search([-9, -5, -3, -1], -3), 2, "全负数数组")

//: [Next](@next)
