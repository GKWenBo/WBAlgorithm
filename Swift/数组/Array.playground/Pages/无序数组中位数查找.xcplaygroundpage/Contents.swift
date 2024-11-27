//: [Previous](@previous)

import Foundation

/// 求一个无序数组的中位数
func findMedian(nums: [Int]) -> Int {
    let low: Int = 0
    let high: Int = nums.count - 1
    let mid: Int = (nums.count - 1) / 2
    var nums = nums
    var div = fdiv(nums: &nums, low: low, high: high)
    while div != mid {
        if mid < div {
            div = fdiv(nums: &nums, low: low, high: div - 1)
        } else {
            div = fdiv(nums: &nums, low: div + 1, high: high)
        }
    }
    return nums[mid]
}

func fdiv(nums: inout [Int], low: Int, high: Int) -> Int {
    let pivot = nums[high]
    var i = low
    var j = low
    while j < high {
        if nums[j] >= pivot {
            nums.swapAt(i, j)
            i += 1
        }
        j += 1
    }
    nums.swapAt(i, high)
    return i
}

// test
var arr = [1, 3, 5, 6, 4, 7, 8]
/// 1 3 4 5 6 7 8
findMedian(nums: arr)

//: [Next](@next)
