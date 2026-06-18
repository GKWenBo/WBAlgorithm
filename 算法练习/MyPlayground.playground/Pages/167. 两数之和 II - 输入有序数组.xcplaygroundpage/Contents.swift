//: [Previous](@previous)

import Foundation

/*
 给你一个下标从 1 开始的整数数组 numbers ，该数组已按 非递减顺序排列  ，请你从数组中找出满足相加之和等于目标数 target 的两个数。如果设这两个数分别是 numbers[index1] 和 numbers[index2] ，则 1 <= index1 < index2 <= numbers.length 。

 以长度为 2 的整数数组 [index1, index2] 的形式返回这两个整数的下标 index1 和 index2。

 你可以假设每个输入 只对应唯一的答案 ，而且你 不可以 重复使用相同的元素。

 你所设计的解决方案必须只使用常量级的额外空间。


 示例 1：

 输入：numbers = [2,7,11,15], target = 9
 输出：[1,2]
 解释：2 与 7 之和等于目标数 9 。因此 index1 = 1, index2 = 2 。返回 [1, 2] 。
 示例 2：

 输入：numbers = [2,3,4], target = 6
 输出：[1,3]
 解释：2 与 4 之和等于目标数 6 。因此 index1 = 1, index2 = 3 。返回 [1, 3] 。
 示例 3：

 输入：numbers = [-1,0], target = -1
 输出：[1,2]
 解释：-1 与 0 之和等于目标数 -1 。因此 index1 = 1, index2 = 2 。返回 [1, 2] 。


 提示：

 2 <= numbers.length <= 3 * 104
 -1000 <= numbers[i] <= 1000
 numbers 按 非递减顺序 排列
 -1000 <= target <= 1000
 仅存在一个有效答案

 LeetCode：https://leetcode.cn/problems/two-sum-ii-input-array-is-sorted/description/
 */

/// 双指针法，时间复杂度 O(n)，空间复杂度 O(1)
///
/// 思路：left 指向数组头，right 指向数组尾，利用有序性收缩区间：
/// - 当前和 < target：左指针右移，使和变大
/// - 当前和 > target：右指针左移，使和变小
/// - 当前和 == target：找到答案，返回 1-based 下标
class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var low = 0
        var high = numbers.count - 1
        while low < high {
            let sum = numbers[low] + numbers[high]
            if sum < target {
                // 和偏小，左指针右移增大和
                low += 1
            } else if sum > target {
                // 和偏大，右指针左移减小和
                high -= 1
            } else {
                // 找到目标，题目要求返回 1-based 下标
                return [low + 1, high + 1]
            }
        }
        return []
    }
}

// MARK: - 测试

let solution = Solution()

/// 验证结果并打印测试信息
func verify(_ result: [Int], _ expected: [Int], _ caseName: String) {
    let pass = result == expected
    print("\(pass ? "✅" : "❌") \(caseName): 期望 \(expected)，实际 \(result)")
}

// 示例 1：答案在数组头部两个元素
verify(solution.twoSum([2, 7, 11, 15], 9),  [1, 2], "示例1 - 头部命中")

// 示例 2：答案跨越中间元素
verify(solution.twoSum([2, 3, 4], 6),        [1, 3], "示例2 - 首尾命中")

// 示例 3：负数数组
verify(solution.twoSum([-1, 0], -1),         [1, 2], "示例3 - 负数数组")

// 答案在数组末尾两个元素
verify(solution.twoSum([1, 3, 5, 7], 12),    [3, 4], "末尾两个元素之和")

// 数组中存在重复元素
verify(solution.twoSum([1, 1, 2, 3], 2),     [1, 2], "含重复元素")

// 包含负数，答案分布在两端
verify(solution.twoSum([-3, -1, 0, 2, 5], 2), [2, 5], "跨正负数区间")

//: [Next](@next)
