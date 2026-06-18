//: [Previous](@previous)

import Foundation

/*
 给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。

 请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。

 你必须设计并实现时间复杂度为 O(n) 的算法解决此问题。



 示例 1:

 输入: [3,2,1,5,6,4], k = 2
 输出: 5
 示例 2:

 输入: [3,2,3,1,2,4,5,5,6], k = 4
 输出: 4


 提示：

 1 <= k <= nums.length <= 105
 -104 <= nums[i] <= 104

 LeetCode: https://leetcode.cn/problems/kth-largest-element-in-an-array/description/

 算法思路：快速选择（QuickSelect）
 - 第 k 大元素等价于升序排列后索引为 n-k 的元素
 - 每次随机选取 pivot 进行分区，分区后 pivot 落在其最终排序位置
 - 若 pivot 索引恰好等于 target，直接返回；否则只递归目标所在的一侧
 - 平均时间复杂度 O(n)，最坏 O(n²)（随机化 pivot 可极大降低最坏情况概率）
 */

class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        // 第 k 大 ↔ 升序排列中倒数第 k 个，即索引 n-k
        let target = nums.count - k
        return quickSelect(&nums, low: 0, high: nums.count - 1, target: target)
    }

    // 快速选择：在 [low, high] 范围内寻找排序后索引为 target 的元素
    private func quickSelect(_ nums: inout [Int], low: Int, high: Int, target: Int) -> Int {
        let pivotIndex = partition(&nums, low: low, high: high)
        if pivotIndex == target {
            return nums[target]
        } else if pivotIndex < target {
            // pivot 左侧元素不够多，目标在右半部分
            return quickSelect(&nums, low: pivotIndex + 1, high: high, target: target)
        } else {
            // pivot 右侧元素过多，目标在左半部分
            return quickSelect(&nums, low: low, high: pivotIndex - 1, target: target)
        }
    }

    // 随机化分区：将小于 pivot 的元素移到左侧，返回 pivot 最终落定的索引
    private func partition(_ nums: inout [Int], low: Int, high: Int) -> Int {
        // 随机选 pivot，避免有序输入退化为 O(n²)
        let randomIndex = Int.random(in: low...high)
        nums.swapAt(randomIndex, high)

        let pivot = nums[high]
        var insertIndex = low  // 下一个小于 pivot 的元素应放置的位置
        for current in low..<high where nums[current] < pivot {
            nums.swapAt(current, insertIndex)
            insertIndex += 1
        }
        // 将 pivot 放到最终位置
        nums.swapAt(insertIndex, high)
        return insertIndex
    }
}

// MARK: - 测试

let solution = Solution()

// 辅助：断言并打印结果
func assertEqual(_ result: Int, _ expected: Int, _ testName: String) {
    if result == expected {
        print("✅ \(testName): \(result)")
    } else {
        print("❌ \(testName): 期望 \(expected)，实际 \(result)")
    }
}

// 题目示例
assertEqual(solution.findKthLargest([3, 2, 1, 5, 6, 4], 2), 5, "示例1 - 基本用例")
assertEqual(solution.findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4), 4, "示例2 - 含重复元素")

// 边界：单元素数组
assertEqual(solution.findKthLargest([1], 1), 1, "单元素数组")

// 边界：k=1（最大值）
assertEqual(solution.findKthLargest([7, 3, 5, 1, 9], 1), 9, "k=1 取最大值")

// 边界：k=n（最小值）
assertEqual(solution.findKthLargest([7, 3, 5, 1, 9], 5), 1, "k=n 取最小值")

// 全部相同元素
assertEqual(solution.findKthLargest([4, 4, 4, 4], 2), 4, "全相同元素")

// 含负数
assertEqual(solution.findKthLargest([-1, -2, -3, -4, -5], 2), -2, "全负数数组")

// 正负混合
assertEqual(solution.findKthLargest([3, -1, 0, 2, -5], 3), 0, "正负混合")

// 已升序排列
assertEqual(solution.findKthLargest([1, 2, 3, 4, 5], 2), 4, "已升序排列")

// 已降序排列
assertEqual(solution.findKthLargest([5, 4, 3, 2, 1], 3), 3, "已降序排列")

//: [Next](@next)
