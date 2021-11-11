//: [Previous](@previous)

import Foundation

class Solution {
    /// 查找第一个大于等于给定值的元素
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard !nums.isEmpty else {
            return -1
        }
        var low = 0, high = nums.count - 1
        while low <= high {
            let mid = ((high - low) >> 1) + low
            if nums[mid] >= target {
                if mid == 0 || nums[mid - 1] < target {
                    return mid
                } else {
                    high = mid - 1
                }
            } else {
                low = mid + 1
            }
        }
        return -1
    }
}

// test
let s = Solution()
let nums = [3, 4, 6, 7, 10]
s.search(nums, 5)

//: [Next](@next)
