//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums 和一个整数 x 。每一次操作时，你应当移除数组 nums 最左边或最右边的元素，然后从 x 中减去该元素的值。请注意，需要 修改 数组以供接下来的操作使用。

 如果可以将 x 恰好 减到 0 ，返回 最小操作数 ；否则，返回 -1 。

  

 示例 1：

 输入：nums = [1,1,4,2,3], x = 5
 输出：2
 解释：最佳解决方案是移除后两个元素，将 x 减到 0 。
 示例 2：

 输入：nums = [5,6,7,8,9], x = 4
 输出：-1
 示例 3：

 输入：nums = [3,2,20,1,1,3], x = 10
 输出：5
 解释：最佳解决方案是移除后三个元素和前两个元素（总共 5 次操作），将 x 减到 0 。
  

 提示：

 1 <= nums.length <= 105
 1 <= nums[i] <= 104
 1 <= x <= 109
 
 LeetCode：https://leetcode.cn/problems/minimum-operations-to-reduce-x-to-zero/description/
 */

class Solution {
    func minOperations(_ nums: [Int], _ x: Int) -> Int {
        let sum = nums.reduce(0, +)
        /// 滑动窗口需要寻找的子数组目标和
        var target = sum - x
        /// 记录窗口内所有元素和
        var sumWindow = 0
        var left = 0, right = 0
        /// 记录目标子数组的最大长度
        var maxLen = Int.min
        while right < nums.count {
            sumWindow += nums[right]
            right += 1
            
            while sumWindow > target && left < right {
                /// 缩小窗口
                sumWindow -= nums[left]
                left += 1
            }
            /// 寻找目标子数组
            if sumWindow == target {
                maxLen = max(maxLen, right - left)
            }
        }
        /// 目标子数组的最大长度可以推导出需要删除的字符数量
        return maxLen == Int.min ? -1 : nums.count - maxLen
    }
}

let nums = [1,1,4,2,3]
let x = 5
print(Solution().minOperations(nums, x))

//: [Next](@next)
