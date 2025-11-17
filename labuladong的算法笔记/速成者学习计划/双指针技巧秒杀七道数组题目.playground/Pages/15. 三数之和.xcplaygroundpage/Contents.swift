//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，同时还满足 nums[i] + nums[j] + nums[k] == 0 。请你返回所有和为 0 且不重复的三元组。

 注意：答案中不可以包含重复的三元组。

  

  

 示例 1：

 输入：nums = [-1,0,1,2,-1,-4]
 输出：[[-1,-1,2],[-1,0,1]]
 解释：
 nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0 。
 nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0 。
 nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0 。
 不同的三元组是 [-1,0,1] 和 [-1,-1,2] 。
 注意，输出的顺序和三元组的顺序并不重要。
 示例 2：

 输入：nums = [0,1,1]
 输出：[]
 解释：唯一可能的三元组和不为 0 。
 示例 3：

 输入：nums = [0,0,0]
 输出：[[0,0,0]]
 解释：唯一可能的三元组和为 0 。
  

 提示：

 3 <= nums.length <= 3000
 -105 <= nums[i] <= 105
 
 LeetCode：https://leetcode.cn/problems/3sum/description/
 */

class Solution {
    /// 时间复杂度O(N²)
    func threeSum(_ nums: [Int]) -> [[Int]] {
        return threeSumTarget(nums, target: 0)
    }
    
    func threeSumTarget(_ nums: [Int], target: Int) -> [[Int]] {
        /// 数组必须有序，排序时间复杂度NlogN
        let nums = nums.sorted()
        /// 存储结果
        var res: [[Int]] = []
        let n = nums.count
        var i = 0
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

let nums = [-1,0,1,2,-1,-4]
let res = Solution().threeSum(nums)

//: [Next](@next)
