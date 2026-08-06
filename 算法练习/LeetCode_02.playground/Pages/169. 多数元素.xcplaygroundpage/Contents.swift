//: [Previous](@previous)

import Foundation

/*
 给定一个大小为 n 的数组 nums ，返回其中的多数元素。多数元素是指在数组中出现次数 大于 ⌊ n/2 ⌋ 的元素。

 你可以假设数组是非空的，并且给定的数组总是存在多数元素。

  

 示例 1：

 输入：nums = [3,2,3]
 输出：3
 示例 2：

 输入：nums = [2,2,1,1,1,2,2]
 输出：2
  

 提示：
 n == nums.length
 1 <= n <= 5 * 104
 -109 <= nums[i] <= 109
 输入保证数组中一定有一个多数元素。
  

 进阶：尝试设计时间复杂度为 O(n)、空间复杂度为 O(1) 的算法解决此问题。
 
 LeetCode: https://leetcode.cn/problems/majority-element/description/
 */

// Boyer-Moore 投票算法：时间复杂度 O(n)，空间复杂度 O(1)
// 核心思想：多数元素出现次数超过 n/2，抵消所有非多数元素后仍有剩余
class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var count = 0
        var target = 0
        for num in nums {
            if count == 0 {
                // 候选人归零时，重新选当前元素为候选人
                target = num
                count = 1
            } else if num == target {
                // 遇到相同元素，票数 +1
                count += 1
            } else {
                // 遇到不同元素，相互抵消，票数 -1
                count -= 1
            }
        }
        // 多数元素出现次数 > n/2，抵消后 target 必为答案
        return target
    }
}

// MARK: - Tests

let solution = Solution()

// 基础用例
assert(solution.majorityElement([3, 2, 3]) == 3, "Test 1 failed")
assert(solution.majorityElement([2, 2, 1, 1, 1, 2, 2]) == 2, "Test 2 failed")

// 单元素
assert(solution.majorityElement([1]) == 1, "Test 3 failed")

// 全部相同
assert(solution.majorityElement([5, 5, 5]) == 5, "Test 4 failed")

// 多数元素在开头
assert(solution.majorityElement([1, 1, 2]) == 1, "Test 5 failed")

// 多数元素在末尾
assert(solution.majorityElement([2, 1, 1]) == 1, "Test 6 failed")

// 负数
assert(solution.majorityElement([-1, -1, 2]) == -1, "Test 7 failed")

// 混合正负数
assert(solution.majorityElement([-3, 2, -3]) == -3, "Test 8 failed")

// 较大数组：多数元素分散在数组各处
assert(solution.majorityElement([1, 2, 1, 2, 1, 2, 1]) == 1, "Test 9 failed")

// 极端值
assert(solution.majorityElement([Int.min, Int.min, Int.max]) == Int.min, "Test 10 failed")

print("All tests passed ✓")

//: [Next](@next)
