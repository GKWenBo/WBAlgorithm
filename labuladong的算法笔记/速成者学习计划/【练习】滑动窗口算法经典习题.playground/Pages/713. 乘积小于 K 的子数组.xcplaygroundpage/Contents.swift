import UIKit
/*
 给你一个整数数组 nums 和一个整数 k ，请你返回子数组内所有元素的乘积严格小于 k 的连续子数组的数目。
  

 示例 1：

 输入：nums = [10,5,2,6], k = 100
 输出：8
 解释：8 个乘积小于 100 的子数组分别为：[10]、[5]、[2]、[6]、[10,5]、[5,2]、[2,6]、[5,2,6]。
 需要注意的是 [10,5,2] 并不是乘积小于 100 的子数组。
 示例 2：

 输入：nums = [1,2,3], k = 0
 输出：0
  

 提示:

 1 <= nums.length <= 3 * 104
 1 <= nums[i] <= 1000
 0 <= k <= 106
 
 LeetCode：https://leetcode.cn/problems/subarray-product-less-than-k/description/
 */

class Solution {
    func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int {
        /// 滑动窗口，初始化为乘法单位元
        var windowProduct = 1
        var left = 0, right = 0
        /// 记录符合条件的子数组个数
        var count = 0
        while right < nums.count {
            windowProduct *= nums[right]
            right += 1
            
            /// 缩小窗口，并更新窗口数据
            while left < right && windowProduct >= k {
                windowProduct /= nums[left]
                left += 1
            }
            
            /// 现在必然是一个合法的窗口，但注意思考这个窗口中的子数组个数怎么计算：
            /// 比方说 left = 1, right = 4 划定了 [1, 2, 3] 这个窗口（right 是开区间）
            /// 但不止 [left..right] 是合法的子数组，[left+1..right], [left+2..right] 等都是合法子数组
            /// 所以我们需要把 [3], [2,3], [1,2,3] 这 right - left 个子数组都加上
            count += right - left
        }
        return count
    }
}

let nums = [10,5,2,6]
let k = 100
print(Solution().numSubarrayProductLessThanK(nums, k))
print(Solution().numSubarrayProductLessThanK([1,2,3], 0))
