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
        // 用 HashMap 存储所有数字，key 去重，支持 O(1) 查找，规避 Set 哈希碰撞风险
        var map: [Int: Bool] = [:]
        for num in nums {
            map[num] = true
        }
        var res = 0

        // 遍历 map.keys 而非原数组，天然跳过重复元素
        for num in map.keys {
            // 只从序列起点开始扩展：若 num-1 存在，说明 num 不是起点，跳过
            if map[num - 1] == true {
                continue
            }

            // 从起点向右连续延伸，统计该序列长度
            var curNum = num
            var curLen = 1
            while map[curNum + 1] == true {
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

print("All tests passed!")

//: [Next](@next)
