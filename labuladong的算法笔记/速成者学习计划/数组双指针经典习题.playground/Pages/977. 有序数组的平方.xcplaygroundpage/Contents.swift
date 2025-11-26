//: [Previous](@previous)

import Foundation

/*
 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

  

 示例 1：

 输入：nums = [-4,-1,0,3,10]
 输出：[0,1,9,16,100]
 解释：平方后，数组变为 [16,1,0,9,100]
 排序后，数组变为 [0,1,9,16,100]
 示例 2：

 输入：nums = [-7,-3,2,3,11]
 输出：[4,9,9,49,121]
  

 提示：

 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums 已按 非递减顺序 排序
  

 进阶：

 请你设计时间复杂度为 O(n) 的算法解决本问题
 
 LeetCode：https://leetcode.cn/problems/squares-of-a-sorted-array/description/
 */

class Solution {
    func sortedSquares(_ nums: [Int]) -> [Int] {
        // 两个指针分别初始化在正负子数组绝对值最大的元素索引
        var left = 0
        var right = nums.count - 1
        var res: [Int] = Array(repeating: 0, count: nums.count)
        // 得到的有序结果是降序的
        var p = right
        while left <= right {
            if abs(nums[left]) < abs(nums[right]) {
                res[p] = nums[right] * nums[right]
                right -= 1
            } else {
                res[p] = nums[left] * nums[left]
                left += 1
            }
            p -= 1
        }
        return res
    }
}

let nums = [-7,-3,2,3,11]
let res = Solution().sortedSquares(nums)


//: [Next](@next)
