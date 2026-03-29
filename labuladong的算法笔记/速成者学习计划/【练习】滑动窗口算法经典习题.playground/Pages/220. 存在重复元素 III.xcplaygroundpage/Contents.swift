//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums 和两个整数 indexDiff 和 valueDiff 。

 找出满足下述条件的下标对 (i, j)：

 i != j,
 abs(i - j) <= indexDiff
 abs(nums[i] - nums[j]) <= valueDiff
 如果存在，返回 true ；否则，返回 false 。

  

 示例 1：

 输入：nums = [1,2,3,1], indexDiff = 3, valueDiff = 0
 输出：true
 解释：可以找出 (i, j) = (0, 3) 。
 满足下述 3 个条件：
 i != j --> 0 != 3
 abs(i - j) <= indexDiff --> abs(0 - 3) <= 3
 abs(nums[i] - nums[j]) <= valueDiff --> abs(1 - 1) <= 0
 示例 2：

 输入：nums = [1,5,9,1,5,9], indexDiff = 2, valueDiff = 3
 输出：false
 解释：尝试所有可能的下标对 (i, j) ，均无法满足这 3 个条件，因此返回 false 。
  

 提示：

 2 <= nums.length <= 105
 -109 <= nums[i] <= 109
 1 <= indexDiff <= nums.length
 0 <= valueDiff <= 109
 
 LeetCode：https://leetcode.cn/problems/contains-duplicate-iii/description/
 */
class Solution {
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ indexDiff: Int, _ valueDiff: Int) -> Bool {
        var window: [Int] = []
        var left = 0
        var right = 0
        while right < nums.count {
            /// 为了防止 i == j，所以在扩大窗口之前先判断是否有符合题意的索引对 (i, j)
            /// 查找略大于 nums[right] 的那个元素
            let currentNum = nums[right]
            if let ceiling = findCeiling(window, target: currentNum) {
                if Int64(ceiling) - Int64(currentNum) <= Int64(valueDiff) {
                    return true
                }
            }
            
            /// 查找略小于 nums[right] 的那个元素
            if let floor = findFloor(window, target: currentNum) {
                if Int64(currentNum) - Int64(floor) <= Int64(valueDiff) {
                    return true
                }
            }
            
            /// 扩大窗口
            insert(&window, currentNum)
            right += 1
            
            /// 缩小窗口
            while right - left > indexDiff {
                remove(&window, nums[left])
                left += 1
            }
        }
        return false
    }
    
    /// 查找第一个大于或等于target的元素
    private func findCeiling(_ arr: [Int], target: Int) -> Int? {
        var left = 0
        var right = arr.count - 1
        var result: Int?
        while left <= right {
            let mid = left + (right - left) / 2
            if arr[mid] >= target {
                result = arr[mid]
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return result
    }
    
    
    /// 查找第一个小于或等于target的元素
    private func findFloor(_ arr: [Int], target: Int) -> Int? {
        var left = 0
        var right = arr.count - 1
        var result: Int?
        while left <= right {
            let mid = left + (right - left) / 2
            if arr[mid] <= target {
                result = arr[mid]
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return result
    }
    
    /// 在有序数组中插入元素
    private func insert(_ arr: inout [Int], _ num: Int) {
        var left = 0
        var right = arr.count
        while left < right {
            let mid = left + (right - left) / 2
            if arr[mid] < num {
                left = mid + 1
            } else {
                right = mid
            }
        }
        
        arr.insert(num, at: left)
    }
    
    /// 从有序数组中移除元素
    private func remove(_ arr: inout [Int], _ num: Int) {
        var left = 0
        var right = arr.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if arr[mid] == num {
                arr.remove(at: mid)
                return
            } else if arr[mid] < num {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
}

print("220. 存在重复元素 III")
print(Solution().containsNearbyAlmostDuplicate([1,2,3,1], 3, 0))
print(Solution().containsNearbyAlmostDuplicate([1,5,9,1,5,9], 2, 3))
print(Solution().containsNearbyAlmostDuplicate([-2,3], 2, 5))

//: [Next](@next)
