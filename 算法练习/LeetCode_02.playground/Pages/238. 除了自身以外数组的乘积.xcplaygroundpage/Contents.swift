//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums，返回 数组 answer ，其中 answer[i] 等于 nums 中除了 nums[i] 之外其余各元素的乘积 。

 题目数据 保证 数组 nums之中任意元素的全部前缀元素和后缀的乘积都在  32 位 整数范围内。

 请 不要使用除法，且在 O(n) 时间复杂度内完成此题。

  

 示例 1:

 输入: nums = [1,2,3,4]
 输出: [24,12,8,6]
 示例 2:

 输入: nums = [-1,1,0,-3,3]
 输出: [0,0,9,0,0]
  

 提示：

 2 <= nums.length <= 105
 -30 <= nums[i] <= 30
 输入 保证 数组 answer[i] 在  32 位 整数范围内
  

 进阶：你可以在 O(1) 的额外空间复杂度内完成这个题目吗？（ 出于对空间复杂度分析的目的，输出数组 不被视为 额外空间。）
 
 LeetCode: https://leetcode.cn/problems/product-of-array-except-self/description/
 */

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var pre = [Int](repeating: 0, count: n)
        var suffix = [Int](repeating: 0, count: n)
        
        /// 前缀积
        pre[0] = nums[0]
        for i in 1..<n {
            pre[i] = pre[i - 1] * nums[i]
        }
        
        /// 后缀积
        suffix[n - 1] = nums[n - 1]
        for i in stride(from: n - 2, through: 0, by: -1) {
            suffix[i] = suffix[i + 1] * nums[i]
        }
        
        var res = [Int](repeating: 0, count: n)
        res[0] = suffix[1]
        res[n - 1] = pre[n - 2]
        for i in 1..<n - 1 {
            /// 当前下标
            res[i] = pre[i - 1] * suffix[i + 1]
        }
        return res
    }
}

//: [Next](@next)
