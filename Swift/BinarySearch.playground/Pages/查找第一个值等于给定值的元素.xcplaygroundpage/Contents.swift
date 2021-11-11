//: [Previous](@previous)

import Foundation

class Solution {
    /// 查找第一个值等于给定值的元素
    func search(_ nums: [Int], _ target: Int) -> Int {
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
}

// test
let s = Solution()
let nums = [1,2,3,4,5,6,8,8,8,11,18]
s.search(nums, 8)

//: [Next](@next)
