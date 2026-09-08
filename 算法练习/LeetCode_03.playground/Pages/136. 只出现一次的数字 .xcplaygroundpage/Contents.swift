//: [Previous](@previous)

import Foundation

/*
 给你一个 非空 整数数组 nums ，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。

 你必须设计并实现线性时间复杂度的算法来解决此问题，且该算法只使用常量额外空间。

  

 示例 1 ：

 输入：nums = [2,2,1]

 输出：1

 示例 2 ：

 输入：nums = [4,1,2,1,2]

 输出：4

 示例 3 ：

 输入：nums = [1]

 输出：1

  

 提示：

 1 <= nums.length <= 3 * 104
 -3 * 104 <= nums[i] <= 3 * 104
 除了某个元素只出现一次以外，其余每个元素均出现两次。
 
 LeetCode：https://leetcode.cn/problems/single-number/description/
 */

// MARK: - 解法：异或（XOR）
// 思路：利用异或的两个关键性质
//   1. a ^ a = 0（相同的数异或为 0）
//   2. a ^ 0 = a（任意数与 0 异或等于自身）
// 由于数组中其余元素均出现两次，两两异或后抵消为 0
// 只出现一次的元素最终会留在 res 中
// 时间复杂度：O(n)，空间复杂度：O(1)
class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var res = 0
        for num in nums {
            res ^= num  // 出现两次的数异或后抵消，剩下只出现一次的数
        }
        return res
    }
}

// MARK: - 测试
let solution = Solution()
solution.singleNumber([2, 2, 1])        // 期望：1
solution.singleNumber([4, 1, 2, 1, 2])  // 期望：4
solution.singleNumber([1])              // 期望：1

//: [Next](@next)
