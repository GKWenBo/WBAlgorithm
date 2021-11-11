//: [Previous](@previous)

/*
 给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。

 示例 1：
 输入：nums = [1,2,3]
 输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
 
 示例 2：
 输入：nums = [0,1]
 输出：[[0,1],[1,0]]
 
 示例 3：
 输入：nums = [1]
 输出：[[1]]

 提示：
 1 <= nums.length <= 6
 -10 <= nums[i] <= 10
 nums 中的所有整数 互不相同

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/permutations
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        guard !nums.isEmpty else {
            return res
        }
        
        let len = nums.count
        var used: [Bool] =  Array.init(repeating: false, count: len)
        let path = [Int]()
        dfs(nums: nums,
            len: len,
            depth: 0,
            path: path,
            used: &used,
            res: &res)
        return res
    }
    
    func dfs(nums: [Int],
             len: Int,
             depth: Int,
             path: [Int],
             used: inout [Bool],
             res: inout [[Int]]) {
        if depth == len {
            res.append(path)
            return
        }
        
        for i in 0..<len {
            if used[i] {
                continue
            }
            
            used[i] = true
            dfs(nums: nums,
                len: len,
                depth: depth + 1,
                path: [nums[i]] + path,
                used: &used,
                res: &res)
            used[i] = false
        }
    }
}


/// test
var solution = Solution()
//var array = [1, 2, 3]
var array = [0, 1]
solution.permute(array)

//: [Next](@next)
