//: [Previous](@previous)

/*
 给定一个按照升序排列的整数数组 nums，和一个目标值 target。找出给定目标值在数组中的开始位置和结束位置。

 如果数组中不存在目标值 target，返回 [-1, -1]。

 进阶：
 你可以设计并实现时间复杂度为 O(log n) 的算法解决此问题吗？
  
 示例 1：
 输入：nums = [5,7,7,8,8,10], target = 8
 输出：[3,4]
 
 示例 2：
 输入：nums = [5,7,7,8,8,10], target = 6
 输出：[-1,-1]
 
 示例 3：
 输入：nums = [], target = 0
 输出：[-1,-1]

 提示：
 0 <= nums.length <= 105
 -109 <= nums[i] <= 109
 nums 是一个非递减数组
 -109 <= target <= 109

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        guard !nums.isEmpty else {
            return [-1, -1]
        }
        
        let firstIndex = l_search(nums, target)
        guard firstIndex != -1 else {
            return [-1, -1]
        }
        
        let lastIndex = r_search(nums, target)
        
        return [firstIndex, lastIndex]
    }
    
    /// 查找第一个值等于给定值的元素
    func l_search(_ nums: [Int], _ target: Int) -> Int {
        guard !nums.isEmpty else {
            return -1
        }
        var low = 0, high = nums.count - 1
        while low <= high {
            let mid = ((high - low) >> 1) + low
            if nums[mid] > target {
                high = mid - 1
            } else if nums[mid] < target {
                low = mid + 1
            } else {
                if mid == 0 || nums[mid - 1] != target {
                    return mid
                } else {
                    high = mid - 1
                }
            }
        }
        return -1
    }
    
    /// 查找最后一个值等于给定值的元素
    func r_search(_ nums: [Int], _ target: Int) -> Int {
        guard !nums.isEmpty else {
            return -1
        }
        var low = 0, high = nums.count - 1
        while low <= high {
            let mid = ((high - low) >> 1) + low
            if nums[mid] > target {
                high = mid - 1
            } else if nums[mid] < target {
                low = mid + 1
            } else {
                if mid == nums.count - 1 || nums[mid + 1] != target {
                    return mid
                } else {
                    low = mid + 1
                }
            }
        }
        return -1
    }
}

let s = Solution()
let nums = [5,7,7,8,8,10]
s.searchRange(nums, 7)

//: [Next](@next)
