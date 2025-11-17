//: [Previous](@previous)

import Foundation

/*
 给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回满足下述全部条件且不重复的四元组 [nums[a], nums[b], nums[c], nums[d]] （若两个四元组元素一一对应，则认为两个四元组重复）：

 0 <= a, b, c, d < n
 a、b、c 和 d 互不相同
 nums[a] + nums[b] + nums[c] + nums[d] == target
 你可以按 任意顺序 返回答案 。

  

 示例 1：

 输入：nums = [1,0,-1,0,-2,2], target = 0
 输出：[[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
 示例 2：

 输入：nums = [2,2,2,2,2], target = 8
 输出：[[2,2,2,2]]
  

 提示：

 1 <= nums.length <= 200
 -109 <= nums[i] <= 109
 -109 <= target <= 109
  

 LeetCode：https://leetcode.cn/problems/4sum/description/
 */

class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        /// 数组必须有序，排序时间复杂度NlogN
        let nums = nums.sorted()
        let n = nums.count
        var i = 0
        var res: [[Int]] = []
        while i < n {
            let tuples = threeSumTarget(nums, start: i + 1, target: target - nums[i])
            for tuple in tuples {
                var tuple = tuple
                tuple.append(nums[i])
                res.append(tuple)
            }
            
            while i < n - 1 && nums[i] == nums[i + 1] {
                i += 1
            }
            i += 1
        }
        return res
    }
    
    func threeSumTarget(_ nums: [Int], start: Int, target: Int) -> [[Int]] {
        /// 存储结果
        var res: [[Int]] = []
        let n = nums.count
        var i = start
        /// 穷举threeSum的第一个数
        while i < n {
            // 对 target - nums[i] 计算 twoSum
            let tuples = twoSumTarget(nums, start: i + 1, target: target - nums[i])
            // 如果存在满足条件的二元组，再加上 nums[i] 就是结果三元组
            for tuple in tuples {
                var tuple = tuple
                tuple.append(nums[i])
                res.append(tuple)
            }
            // 对 target - nums[i] 计算 twoSum
            while i < n - 1 && nums[i] == nums[i + 1] {
                i += 1
            }
            i += 1
        }
        return res
    }
    
    func twoSumTarget(_ nums: [Int], start: Int, target: Int) -> [[Int]] {
        /// 存储结果
        var res: [[Int]] = []
        var low = start
        var high = nums.count - 1
        while low < high {
            let left = nums[low]
            let right = nums[high]
            let sum = left + right
            if sum < target {
                while low < high && nums[low] == left {
                    low += 1
                }
            } else if sum > target {
                while low < high && nums[high] == right {
                    high -= 1
                }
            } else if sum == target {
                res.append([left, right])
                while low < high && nums[low] == left {
                    low += 1
                }
                while low < high && nums[high] == right {
                    high -= 1
                }
            }
        }
        return res
    }
}

let nums = [1,0,-1,0,-2,2]
print(Solution().fourSum(nums, 0))

//: [Next](@next)
