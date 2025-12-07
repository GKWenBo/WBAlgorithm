//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums 和一个整数 k ，判断数组中是否存在两个 不同的索引 i 和 j ，满足 nums[i] == nums[j] 且 abs(i - j) <= k 。如果存在，返回 true ；否则，返回 false 。


 示例 1：

 输入：nums = [1,2,3,1], k = 3
 输出：true
 示例 2：

 输入：nums = [1,0,1,1], k = 1
 输出：true
 示例 3：

 输入：nums = [1,2,3,1,2,3], k = 2
 输出：false
  

 提示：

 1 <= nums.length <= 105
 -109 <= nums[i] <= 109
 0 <= k <= 105
 
 LeetCode：https://leetcode.cn/problems/contains-duplicate-ii/description/
 */

class Solution {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var left = 0
        var right = 0
        var windowSet: Set<Int> = []
        /// 滑动窗口算法框架，维护一个大小为 k 的窗口
        while right < nums.count {
            if !windowSet.insert(nums[right]).inserted { /// 插入数据失败，说明已经存在一个相同元素
                return true
            }
            
            right += 1
                    
            /// 当窗口的大小大于 k 时，缩小窗口
            while right - left > k {
                windowSet.remove(nums[left])
                left += 1
            }
        }
        return false
    }
}

print("219. 存在重复元素 II")
print(Solution().containsNearbyDuplicate([1,2,3,1], 3))
print(Solution().containsNearbyDuplicate([1,2,3,1,2,3], 1))

//: [Next](@next)
