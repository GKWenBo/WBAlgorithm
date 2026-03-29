//: [Previous](@previous)

import Foundation

/*
 给定一个含有 n 个正整数的数组和一个正整数 target 。

 找出该数组中满足其总和大于等于 target 的长度最小的 子数组 [numsl, numsl+1, ..., numsr-1, numsr] ，并返回其长度。如果不存在符合条件的子数组，返回 0 。

  

 示例 1：

 输入：target = 7, nums = [2,3,1,2,4,3]
 输出：2
 解释：子数组 [4,3] 是该条件下的长度最小的子数组。
 示例 2：

 输入：target = 4, nums = [1,4,4]
 输出：1
 示例 3：

 输入：target = 11, nums = [1,1,1,1,1,1,1,1]
 输出：0
  

 提示：

 1 <= target <= 109
 1 <= nums.length <= 105
 1 <= nums[i] <= 104
  

 进阶：

 如果你已经实现 O(n) 时间复杂度的解法, 请尝试设计一个 O(n log(n)) 时间复杂度的解法。
 
 LeetCode：https://leetcode.cn/problems/minimum-size-subarray-sum/description/
 */

class Solution {
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var left = 0
        var right = 0
        /// 窗口元素之和
        var windowSum = 0
        var res = Int.max
        while right < nums.count {
            /// 扩大窗口
            windowSum += nums[right]
            right += 1
            
            while windowSum >= target && left < right {
                /// 已满足target，缩小窗口
                res = min(res, right - left)
                
                windowSum -= nums[left]
                
                left += 1
                
            }
        }
        return res == Int.max ? 0 : res
    }
}

print("209. 长度最小的子数组")
print(Solution().minSubArrayLen(7, [2,3,1,2,4,3]))
print(Solution().minSubArrayLen(4, [1,4,4]))

//: [Next](@next)
