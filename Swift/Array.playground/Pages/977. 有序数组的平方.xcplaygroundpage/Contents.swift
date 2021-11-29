//: [Previous](@previous)

/*
 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

 示例 1：
 输入：nums = [-4,-1,0,3,10]
 输出：[0,1,9,16,100]
 解释：平方后，数组变为 [16,1,0,9,100]
 排序后，数组变为 [0,1,9,16,100]
 示例 2：

 输入：nums = [-7,-3,2,3,11]
 输出：[4,9,9,49,121]

 提示：
 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums 已按 非递减顺序 排序
  

 进阶：
 请你设计时间复杂度为 O(n) 的算法解决本问题

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/squares-of-a-sorted-array
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func sortedSquares(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else {
            return []
        }
        
        // 左指针
        var left = 0
        // 右指针
        var right = nums.count - 1
        var index = right
        // 保存结果数组
        var resArray: [Int] = Array.init(repeating: 0, count: nums.count)
        while left <= right {
            if nums[left] * nums[left] > nums[right] * nums[right] {
                resArray[index] = nums[left] * nums[left]
                left += 1
            } else {
                resArray[index] = nums[right] * nums[right]
                right -= 1
            }
            index -= 1
        }
        return resArray
    }
}

// test
let s = Solution()
let arr = [-7,-3,2,3,11]
print(s.sortedSquares(arr))

//: [Next](@next)
