//: [Previous](@previous)

import Foundation

/*
 给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。

 请注意 ，必须在不复制数组的情况下原地对数组进行操作。

  

 示例 1:

 输入: nums = [0,1,0,3,12]
 输出: [1,3,12,0,0]
 示例 2:

 输入: nums = [0]
 输出: [0]
  

 提示:

 1 <= nums.length <= 104
 -231 <= nums[i] <= 231 - 1
  

 进阶：你能尽量减少完成的操作次数吗？
 
 
 LeetCode：https://leetcode.cn/problems/move-zeroes/description/
 */

class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        let p = removeElement(&nums, 0)
        for i in p..<nums.count {
            nums[i] = 0
        }
    }
    
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var slow = 0, fast = 0
        while fast < nums.count {
            if nums[fast] != val {
                nums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        return slow
    }
}

//: [Next](@next)
