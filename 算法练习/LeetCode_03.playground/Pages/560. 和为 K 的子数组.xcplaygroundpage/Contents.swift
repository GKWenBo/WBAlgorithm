//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums 和一个整数 k ，请你统计并返回 该数组中和为 k 的子数组的个数 。

 子数组是数组中元素的连续非空序列。

 示例 1：
 输入：nums = [1,1,1], k = 2
 输出：2

 示例 2：
 输入：nums = [1,2,3], k = 3
 输出：2

 提示：
 1 <= nums.length <= 2 * 10^4
 -1000 <= nums[i] <= 1000
 -10^7 <= k <= 10^7

 LeetCode: https://leetcode.cn/problems/subarray-sum-equals-k/

 思路：前缀和 + 哈希表
 - 定义 preSum[i] = nums[0] + ... + nums[i-1]
 - 子数组 [j, i) 的和 = preSum[i] - preSum[j]
 - 要找和为 k 的子数组，即满足 preSum[i] - preSum[j] = k 的对数
 - 等价于：对每个 i，查询之前有多少个 j 使得 preSum[j] = preSum[i] - k
 - 用哈希表记录各前缀和出现次数，边遍历边查询，时间复杂度 O(n)
 */

class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        // 哈希表记录前缀和出现次数，初始化前缀和 0 出现 1 次（空子数组）
        var prefixCountMap: [Int: Int] = [0: 1]
        var prefixSum = 0
        var result = 0

        for num in nums {
            prefixSum += num

            // 查询有多少个历史前缀和等于 prefixSum - k
            // 若存在，说明对应区间的子数组和恰好为 k
            result += prefixCountMap[prefixSum - k, default: 0]

            // 将当前前缀和记入哈希表
            prefixCountMap[prefixSum, default: 0] += 1
        }

        return result
    }
}

// MARK: - 测试

let solution = Solution()

// 示例 1：[1,1,1], k=2，期望输出 2（子数组 [1,1] 出现两次）
assert(solution.subarraySum([1, 1, 1], 2) == 2, "测试 1 失败")

// 示例 2：[1,2,3], k=3，期望输出 2（子数组 [1,2] 和 [3]）
assert(solution.subarraySum([1, 2, 3], 3) == 2, "测试 2 失败")

// 单个元素等于 k
assert(solution.subarraySum([5], 5) == 1, "测试 3 失败")

// 单个元素不等于 k
assert(solution.subarraySum([5], 3) == 0, "测试 4 失败")

// 含负数：[-1, -1, 1], k=0，期望 1（子数组 [-1,1] 不连续，[-1,-1,1] 和为 -1，无和为 0 的）
// 实际：[-1] 和 = -1，[-1,-1] 和 = -2，[-1,-1,1] 和 = -1，[-1] 和 = -1，[-1,1] 和 = 0 ✓，[1] 和 = 1
assert(solution.subarraySum([-1, -1, 1], 0) == 1, "测试 5 失败")

// 含负数：[1, -1, 1], k=1，子数组 [1]、[1,-1,1]、[1] 共 3 个
assert(solution.subarraySum([1, -1, 1], 1) == 3, "测试 6 失败")

// k 为负数：[1, 2, -3], k=-3，子数组 [-3] 共 1 个
assert(solution.subarraySum([1, 2, -3], -3) == 1, "测试 7 失败")

// 全为 0：[0, 0, 0], k=0，子数组 [0],[0],[0],[0,0],[0,0],[0,0,0] 共 6 个
assert(solution.subarraySum([0, 0, 0], 0) == 6, "测试 8 失败")

print("所有测试通过 ✓")

//: [Next](@next)
