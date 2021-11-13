//: [Previous](@previous)

/*
 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

 你可以按任意顺序返回答案。

  

 示例 1：

 输入：nums = [2,7,11,15], target = 9
 输出：[0,1]
 解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
 示例 2：

 输入：nums = [3,2,4], target = 6
 输出：[1,2]
 示例 3：

 输入：nums = [3,3], target = 6
 输出：[0,1]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/two-sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    /// 法1：两层for循环
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        let res = [Int]()
        guard !nums.isEmpty else {
            return res
        }
        
        for i in 0..<nums.count {
            for j in (i + 1)..<nums.count {
                if nums[j] == target - nums[i] {
                    return [i, j]
                }
            }
        }
        return res
    }
    
    /// 法2：两层for循环 + 哈希表
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        let res = [Int]()
        guard !nums.isEmpty else {
            return res
        }
        
        var dict = [Int: Int]()
        for (index, value) in nums.enumerated() {
            dict[value] = index
        }
        
        for (index, value) in nums.enumerated() {
            let result = target - value
            if dict.keys.contains(result) && dict[result] != index {
                return [index, dict[result]!]
            }
        }
        return res
    }
    
    /// 法3：一层for循环 + 哈希表
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        let res = [Int]()
        guard !nums.isEmpty else {
            return res
        }
        
        var dict = [Int: Int]()
        for (index, value) in nums.enumerated() {
            let result = target - value
            if dict.keys.contains(result) {
                return [dict[result]!, index]
            }
            dict[value] = index
        }
        return res
    }
}

// test
var solution = Solution()
var arr = [2,7,11,15]
//var arr = [3,2,4]
solution.twoSum1(arr, 9)

//: [Next](@next)
