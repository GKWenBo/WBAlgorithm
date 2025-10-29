//: [Previous](@previous)

import Foundation

/// 二分查找算法
func binarySearch(_ nums: [Int], target: Int) -> Int {
    var left = 0, right = nums.count - 1
    while left <= right {
        let mid = (right + left) / 2
        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            left = mid + 1
        } else if nums[mid] > target {
            right = mid - 1
        }
    }
    return -1
}


let arr = [1, 5, 6, 7]
let res = binarySearch(arr, target: 6)

//: [Next](@next)
