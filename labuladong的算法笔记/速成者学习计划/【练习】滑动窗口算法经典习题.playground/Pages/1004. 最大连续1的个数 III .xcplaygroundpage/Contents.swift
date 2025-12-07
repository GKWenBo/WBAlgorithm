//: [Previous](@previous)

import Foundation
/*
 给定一个二进制数组 nums 和一个整数 k，假设最多可以翻转 k 个 0 ，则返回执行操作后 数组中连续 1 的最大个数 。

  

 示例 1：

 输入：nums = [1,1,1,0,0,0,1,1,1,1,0], K = 2
 输出：6
 解释：[1,1,1,0,0,1,1,1,1,1,1]
 粗体数字从 0 翻转到 1，最长的子数组长度为 6。
 示例 2：

 输入：nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], K = 3
 输出：10
 解释：[0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
 粗体数字从 0 翻转到 1，最长的子数组长度为 10。
  

 提示：

 1 <= nums.length <= 105
 nums[i] 不是 0 就是 1
 0 <= k <= nums.length
 */

class Solution {
    func longestOnes(_ nums: [Int], _ k: Int) -> Int {
        /// 记录窗口中1出现的次数
        var numberOneCount = 0
        var left = 0
        var right = 0
        /// 记录结果长度
        var len = 0
        while right < nums.count {
            /// 扩大窗口
            if nums[right] == 1 {
                numberOneCount += 1
            }
            right += 1
            
            /// 当窗口中需要替换的 0 的数量大于 k，缩小窗口
            while right - left - numberOneCount > k {
                if nums[left] == 1 {
                    numberOneCount -= 1
                }
                left += 1
            }
            
            /// 此时一定是一个合法的窗口，求最大窗口长度
            len = max(len, right - left)
        }
        return len
    }
}

print(Solution().longestOnes([1,1,1,0,0,0,1,1,1,1,0], 2))
print(Solution().longestOnes([1,1,1,0,0,0,1,1,1,1,0], 3))

//: [Next](@next)
