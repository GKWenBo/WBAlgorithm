//: [Previous](@previous)

/*
 给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。
 请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。

 示例 1:
 输入: [3,2,1,5,6,4] 和 k = 2
 输出: 5
 
 示例 2:
 输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
 输出: 4
  
 提示：
 1 <= k <= nums.length <= 104
 -104 <= nums[i] <= 104

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/xx4gT2
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        guard !nums.isEmpty, k <= nums.count else {
            return -1
        }
        
        var nums = nums
        
        var partitionIndex = partition(&nums, left: 0, right: nums.count - 1)
        while partitionIndex + 1 != k {
            if partitionIndex + 1 < k {
                partitionIndex = partition(&nums, left: partitionIndex + 1, right: nums.count - 1)
            } else {
                partitionIndex = partition(&nums, left: 0, right: partitionIndex - 1)
            }
        }
        print(nums)
        return nums[partitionIndex]
    }
    
    func partition(_ nums: inout [Int], left: Int, right: Int) -> Int {
        let pivot = nums[right]
        var i = left
        var j = left
        while j < right {
            if nums[j] >= pivot {
                nums.swapAt(i, j)
                i += 1
            }
            j += 1
        }
        nums.swapAt(i, right)
        return i
    }
}

/// test
var solution = Solution()
//var array = [3, 2, 1, 5, 6, 4]
var array = [3,2,3,1,2,4,5,5,6]
let item = solution.findKthLargest([], 0)
print(item)
//: [Next](@next)
