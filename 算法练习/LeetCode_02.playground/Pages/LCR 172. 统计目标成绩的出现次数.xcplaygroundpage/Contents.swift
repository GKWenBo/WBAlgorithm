import UIKit

/*
 某班级考试成绩按非严格递增顺序记录于整数数组 scores，请返回目标成绩 target 的出现次数。

  

 示例 1：

 输入: scores = [2, 2, 3, 4, 4, 4, 5, 6, 6, 8], target = 4
 输出: 3
 示例 2：

 输入: scores = [1, 2, 3, 5, 7, 9], target = 6
 输出: 0
  

 提示：

 0 <= scores.length <= 105
 -109 <= scores[i] <= 109
 scores 是一个非递减数组
 -109 <= target <= 109
  

 注意：本题与主站 34 题相同（仅返回值不同）：https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/
 
 LeetCode：https://leetcode.cn/problems/zai-pai-xu-shu-zu-zhong-cha-zhao-shu-zi-lcof/description/
 */

class Solution {

    /// 统计 target 在有序数组 scores 中的出现次数
    /// 思路：lowerBound(target+1) - lowerBound(target) = target 的个数
    func countTarget(_ scores: [Int], _ target: Int) -> Int {
        return lowerBound(scores, target + 1) - lowerBound(scores, target)
    }

    /// 返回 nums 中第一个 >= target 的下标（标准 lower_bound）
    /// 若所有元素均 < target，返回 nums.count（表示插入到末尾）
    /// 修复：原实现在末尾用 nums[left] == target ? left : 0 做条件返回，
    /// 导致 target 不存在时错误返回 0，应直接返回 left（即插入点）
    func lowerBound(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1  // 闭区间 [left, right]
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] < target {
                left = mid + 1   // target 在右侧
            } else if nums[mid] > target {
                right = mid - 1  // nums[mid] >= target，收缩右边界锁定第一个 >= target 的位置
            } else if nums[mid] == target {
                right = mid - 1
            }
        }
        return left  // 循环结束时 left 即为第一个 >= target 的下标（或 nums.count）
    }
}

// MARK: - 测试

let solution = Solution()

func assertEqual(_ result: Int, _ expected: Int, _ desc: String) {
    if result == expected {
        print("✅ PASS \(desc)  result: \(result)")
    } else {
        print("❌ FAIL \(desc)  expected: \(expected), got: \(result)")
    }
}

// 题目示例 1：target 出现 3 次
assertEqual(solution.countTarget([2, 2, 3, 4, 4, 4, 5, 6, 6, 8], 4), 3, "示例1 - target 出现多次")

// 题目示例 2：target 不存在
assertEqual(solution.countTarget([1, 2, 3, 5, 7, 9], 6), 0, "示例2 - target 不在数组中（插入点非首尾）")

// 原 bug 复现：target 在数组末尾，target+1 不在数组中
// 原实现 lowerBound(scores, 9) 越界后返回 0，导致结果为负数
assertEqual(solution.countTarget([2, 2, 3, 4, 4, 4, 5, 6, 6, 8], 8), 1, "Bug复现 - target 是最后一个元素")

// target 大于所有元素，结果应为 0
assertEqual(solution.countTarget([1, 2, 3, 5, 7, 9], 10), 0, "target 大于所有元素")

// target 小于所有元素，结果应为 0
assertEqual(solution.countTarget([1, 2, 3, 5, 7, 9], 0), 0, "target 小于所有元素")

// 全部相同，target 等于该值
assertEqual(solution.countTarget([3, 3, 3, 3], 3), 4, "全部相同 - target 命中全部")

// 全部相同，target 不等于该值
assertEqual(solution.countTarget([3, 3, 3, 3], 5), 0, "全部相同 - target 不存在")

// 单元素，命中
assertEqual(solution.countTarget([7], 7), 1, "单元素 - 命中")

// 单元素，未命中
assertEqual(solution.countTarget([7], 3), 0, "单元素 - 未命中")

// 空数组
assertEqual(solution.countTarget([], 5), 0, "空数组")

// target 只在首部出现
assertEqual(solution.countTarget([4, 4, 5, 6, 7], 4), 2, "target 在首部")

// target 只在尾部出现
assertEqual(solution.countTarget([1, 2, 3, 9, 9], 9), 2, "target 在尾部")
