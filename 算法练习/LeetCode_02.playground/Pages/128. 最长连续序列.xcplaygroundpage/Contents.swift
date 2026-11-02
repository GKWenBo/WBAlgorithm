//: [Previous](@previous)

import Foundation

/*
 给定一个未排序的整数数组 nums ，找出数字连续的最长序列（不要求序列元素在原数组中连续）的长度。

 请你设计并实现时间复杂度为 O(n) 的算法解决此问题。

  

 示例 1：

 输入：nums = [100,4,200,1,3,2]
 输出：4
 解释：最长数字连续序列是 [1, 2, 3, 4]。它的长度为 4。
 示例 2：

 输入：nums = [0,3,7,2,5,8,4,6,0,1]
 输出：9
 示例 3：

 输入：nums = [1,0,1,2]
 输出：3
  

 提示：

 0 <= nums.length <= 105
 -109 <= nums[i] <= 109
 
 LeetCode: https://leetcode.cn/problems/longest-consecutive-sequence/description/
 */


class Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
        // 去重 + O(1) 查找；预分配容量避免扩容rehash
        var set = Set<Int>(minimumCapacity: nums.count)
        for num in nums {
            set.insert(num)
        }
        
        guard !set.isEmpty else { return 0 }
        
        // 保存集合
        var res = 0

        // 遍历去重后的集合
        for num in set {
            // 只从序列起点开始扩展：若 num-1 存在，说明 num 不是起点，跳过
            if num != Int.min, set.contains(num - 1) {
                continue
            }

            // 从起点向右连续延伸，统计该序列长度
            var curNum = num
            var curLen = 1
            while curNum != Int.max, set.contains(curNum + 1) {
                curLen += 1
                curNum += 1
            }
            res = max(res, curLen)
        }
        return res
    }
}

// MARK: - Tests

let solution = Solution()

// 示例 1：基本连续序列 [1,2,3,4]，期望 4
assert(solution.longestConsecutive([100, 4, 200, 1, 3, 2]) == 4, "Test 1 failed")

// 示例 2：大部分数字连续，期望 9
assert(solution.longestConsecutive([0, 3, 7, 2, 5, 8, 4, 6, 0, 1]) == 9, "Test 2 failed")

// 示例 3：含重复元素，期望 3
assert(solution.longestConsecutive([1, 0, 1, 2]) == 3, "Test 3 failed")

// 空数组，期望 0
assert(solution.longestConsecutive([]) == 0, "Test 4 failed")

// 单个元素，期望 1
assert(solution.longestConsecutive([42]) == 1, "Test 5 failed")

// 全部重复，期望 1
assert(solution.longestConsecutive([5, 5, 5]) == 1, "Test 6 failed")

// 负数序列 [-3,-2,-1,0]，期望 4
assert(solution.longestConsecutive([-3, -2, -1, 0]) == 4, "Test 7 failed")

// 不相邻的多段序列，最长为 [1,2,3]，期望 3
assert(solution.longestConsecutive([1, 2, 3, 10, 20]) == 3, "Test 8 failed")

// Int.min 边界：num - 1 不得溢出，期望 2
assert(solution.longestConsecutive([Int.min, Int.min + 1, 5]) == 2, "Test 9 failed")

// Int.max 边界：序列尾部正好落在 Int.max，curNum + 1 不得溢出，期望 4
assert(solution.longestConsecutive([Int.max - 3, Int.max - 2, Int.max - 1, Int.max]) == 4, "Test 10 failed")

print("All tests passed!")

//: [Next](@next)
