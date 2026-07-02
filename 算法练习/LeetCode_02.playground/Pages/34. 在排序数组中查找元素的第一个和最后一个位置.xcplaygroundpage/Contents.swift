//: [Previous](@previous)

import Foundation

/*
 给你一个按照非递减顺序排列的整数数组 nums，和一个目标值 target。请你找出给定目标值在数组中的开始位置和结束位置。

 如果数组中不存在目标值 target，返回 [-1, -1]。

 你必须设计并实现时间复杂度为 O(log n) 的算法解决此问题。

  

 示例 1：

 输入：nums = [5,7,7,8,8,10], target = 8
 输出：[3,4]
 示例 2：

 输入：nums = [5,7,7,8,8,10], target = 6
 输出：[-1,-1]
 示例 3：

 输入：nums = [], target = 0
 输出：[-1,-1]
  

 提示：

 0 <= nums.length <= 105
 -109 <= nums[i] <= 109
 nums 是一个非递减数组
 -109 <= target <= 109
 
 LeetCode：https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/description/
 */

class Solution {

    // 分别用二分查找找左边界和右边界，时间复杂度 O(log n)
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let lowIndex = lowBound(nums, target)
        // target 不存在时直接返回，无需再查右边界
        guard lowIndex != -1 else {
            return [-1, -1]
        }
        let highIndex = highBound(nums, target)
        return [lowIndex, highIndex]
    }

    // 二分查找左边界：找第一个值等于 target 的下标
    // 策略：nums[mid] >= target 时持续向左收缩，循环结束后 left 落在第一个 >= target 的位置
    func lowBound(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] < target {
                left = mid + 1  // target 在右半段
            } else {
                right = mid - 1 // 可能命中，但继续向左缩小寻找更靠左的位置
            }
        }
        // left 越界，或最终落点不是 target，说明 target 不存在
        guard left >= 0 && left < nums.count else {
            return -1
        }
        return nums[left] == target ? left : -1
    }

    // 二分查找右边界：找最后一个值等于 target 的下标
    // 策略：nums[mid] <= target 时持续向右收缩，循环结束后 right 落在最后一个 <= target 的位置
    func highBound(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] > target {
                right = mid - 1 // target 在左半段
            } else {
                left = mid + 1  // 可能命中，但继续向右缩小寻找更靠右的位置
            }
        }
        // right 越界，或最终落点不是 target，说明 target 不存在
        guard right >= 0 && right < nums.count else {
            return -1
        }
        return nums[right] == target ? right : -1
    }
}

// MARK: - Tests

private let solution = Solution()
private var passCount = 0
private var failCount = 0

@MainActor private func check(_ label: String, _ nums: [Int], _ target: Int, _ expected: [Int]) {
    let result = solution.searchRange(nums, target)
    if result == expected {
        print("✅ \(label): \(result)")
        passCount += 1
    } else {
        print("❌ \(label): got \(result), expected \(expected)")
        failCount += 1
    }
}

// 题目示例
check("示例1 target存在多个",  [5,7,7,8,8,10], 8, [3,4])
check("示例2 target不存在",    [5,7,7,8,8,10], 6, [-1,-1])
check("示例3 空数组",          [],              0, [-1,-1])

// 边界情况
check("只有一个元素且命中",    [5],             5, [0,0])
check("只有一个元素未命中",    [5],             3, [-1,-1])
check("target只出现一次",      [1,2,3,4,5],     3, [2,2])
check("所有元素相同且命中",    [2,2,2,2],       2, [0,3])
check("所有元素相同未命中",    [2,2,2,2],       5, [-1,-1])
check("target在数组首部",      [1,1,2,3,4],     1, [0,1])
check("target在数组尾部",      [1,2,3,4,5,5],   5, [4,5])
check("target为负数",          [-5,-3,-1,0,2], -3, [1,1])
check("target小于最小值",      [1,2,3],        -1, [-1,-1])
check("target大于最大值",      [1,2,3],         5, [-1,-1])

print("\n共 \(passCount + failCount) 个用例，通过 \(passCount)，失败 \(failCount)")

//: [Next](@next)
