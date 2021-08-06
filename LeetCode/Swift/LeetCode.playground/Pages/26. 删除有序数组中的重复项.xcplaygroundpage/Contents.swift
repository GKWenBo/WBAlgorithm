//: [Previous](@previous)

import Foundation

/*
 复杂度分析：

 时间复杂度：O(n)。
 空间复杂度：O(1)。
 */
func removeDuplicates(_ nums: inout [Int]) -> Int {
    if nums.isEmpty {
        return 0
    }
    
    var slow = 1
    var fast = 1
    while fast < nums.count {
        if nums[fast] != nums[fast - 1] {
            nums[slow] = nums[fast]
            slow += 1
        }
        fast += 1
    }
    return slow
}

var array = [0,0,1,1,1,2,2,3,3,4]
removeDuplicates(&array)
print(array)

//: [Next](@next)
