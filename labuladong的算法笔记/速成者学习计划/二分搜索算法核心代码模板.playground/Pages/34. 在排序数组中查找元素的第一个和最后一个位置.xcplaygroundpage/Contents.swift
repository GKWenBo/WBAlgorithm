import UIKit

/*
 给你一个按照非递减顺序排列的整数数组 nums，和一个目标值 target。请你找出给定目标值在数组中的开始位置和结束位置。

 如果数组中不存在目标值 target，返回 [-1, -1]。

 你必须设计并实现时间复杂度为 O(log n) 的算法解决此问题。

  

 示例 1：

 输入：nums = [5,7,7,8,8,10], target = 8
 输出：[3,4]
 示例 2：

 输入：nums = [5,7,7,8,8,10], target = 6
 输出：[-1,-1]
 示例 3：

 输入：nums = [], target = 0
 输出：[-1,-1]
  

 提示：

 0 <= nums.length <= 105
 -109 <= nums[i] <= 109
 nums 是一个非递减数组
 -109 <= target <= 109
 
 LeetCode：https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/description/
 */

class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let startIndex = leftBound(nums, target)
        if startIndex == -1 {
            return [-1, -1]
        }
        let endIndex = rightBound(nums, target)
        return [startIndex, endIndex]
    }
    
    private func leftBound(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target { /// 别返回，锁定左侧边界
                right = mid - 1
            } else if nums[mid] < target {
               left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            }
        }
        
        /// 判断 target 是否存在于 nums 中
        guard left >= 0, left < nums.count else {
            return -1
        }
        
        /// 判断一下 nums[left] 是不是 target
        return nums[left] == target ? left : -1
    }
    
    private func rightBound(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target { /// 别返回，锁定右侧边界
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            } else if nums[mid] < target {
                left = mid + 1
            }
        }
        
        /// 由于 while 的结束条件是 right == left - 1，且现在在求右边界
        /// 所以用 right 替代 left - 1 更好记
        guard right >= 0, right < nums.count else {
            return -1
        }
        
        return nums[right] == target ? right : -1
    }
}

print("34. 在排序数组中查找元素的第一个和最后一个位置")

print(Solution().searchRange([5,7,7,8,8,10], 8))
