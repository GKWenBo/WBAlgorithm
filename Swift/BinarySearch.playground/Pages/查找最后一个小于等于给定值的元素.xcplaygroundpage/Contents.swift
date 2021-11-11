//: [Previous](@previous)

import Foundation

class Solution {
    /// 查找最后一个小于等于给定值的元素
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard !nums.isEmpty else {
            return -1
        }
        var low = 0, high = nums.count - 1
        while low <= high {
            let mid = ((high - low) >> 1) + low
            if nums[mid] <= target {
                if mid == nums.count - 1 || nums[mid + 1] > target {
                    return mid
                } else {
                    low = mid + 1
                }
            } else {
                high = mid - 1
            }
        }
        return -1
    }
}

// test
let s = Solution()
let nums = [3, 5, 6, 8, 9, 10]
s.search(nums, 7)

//: [Next](@next)
