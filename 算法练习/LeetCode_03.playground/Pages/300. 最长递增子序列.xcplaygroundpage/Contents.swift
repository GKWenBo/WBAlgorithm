//: [Previous](@previous)

import Foundation

/*
 你一个整数数组 nums ，找到其中最长严格递增子序列的长度。

 子序列 是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的子序列。


 示例 1：

 输入：nums = [10,9,2,5,3,7,101,18]
 输出：4
 解释：最长递增子序列是 [2,3,7,101]，因此长度为 4 。
 示例 2：

 输入：nums = [0,1,0,3,2,3]
 输出：4
 示例 3：

 输入：nums = [7,7,7,7,7,7,7]
 输出：1


 提示：

 1 <= nums.length <= 2500
 -104 <= nums[i] <= 104


 进阶：

 你能将算法的时间复杂度降低到 O(n log(n)) 吗?

 LeetCode：https://leetcode.cn/problems/longest-increasing-subsequence/description/
 */

// MARK: - 解法一：动态规划，时间复杂度 O(n²)
class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        // dp[i] 表示以 nums[i] 结尾的最长递增子序列长度，初始值均为 1（每个元素自身构成长度为 1 的子序列）
        var dp = [Int](repeating: 1, count: nums.count)

        for i in 0..<nums.count {
            // 遍历 i 之前的所有元素，寻找可以接在 nums[j] 后面的情况
            for j in 0..<i {
                if nums[j] < nums[i] {
                    // nums[i] 可以接在 nums[j] 之后，更新 dp[i]
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
        }

        // 返回所有位置中最长子序列的长度
        return dp.max() ?? 0
    }
}

// MARK: - 解法二：贪心 + 二分查找，时间复杂度 O(n log n)
class Solution2 {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        // tails[i] 表示长度为 i+1 的所有递增子序列中，末尾元素的最小值
        // 维护 tails 单调递增，使得后续元素更容易接入更长的子序列
        var tails = [Int]()

        for num in nums {
            // 二分查找第一个 >= num 的位置
            var lo = 0, hi = tails.count
            while lo < hi {
                let mid = (lo + hi) / 2
                if tails[mid] < num {
                    lo = mid + 1
                } else {
                    hi = mid
                }
            }

            if lo == tails.count {
                // num 比所有末尾元素都大，直接追加，子序列长度 +1
                tails.append(num)
            } else {
                // 用 num 替换第一个 >= num 的末尾元素，保持贪心最优
                tails[lo] = num
            }
        }

        // tails 的长度即为最长递增子序列的长度
        return tails.count
    }
}

// MARK: - 测试验证
let s1 = Solution()
let s2 = Solution2()

// 示例 1：[10,9,2,5,3,7,101,18]，期望输出 4，子序列为 [2,3,7,101]
assert(s1.lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]) == 4)
assert(s2.lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]) == 4)

// 示例 2：[0,1,0,3,2,3]，期望输出 4，子序列为 [0,1,2,3]
assert(s1.lengthOfLIS([0, 1, 0, 3, 2, 3]) == 4)
assert(s2.lengthOfLIS([0, 1, 0, 3, 2, 3]) == 4)

// 示例 3：[7,7,7,7,7,7,7]，期望输出 1（全部相同，严格递增只有单个元素）
assert(s1.lengthOfLIS([7, 7, 7, 7, 7, 7, 7]) == 1)
assert(s2.lengthOfLIS([7, 7, 7, 7, 7, 7, 7]) == 1)

// 边界：单元素数组，期望输出 1
assert(s1.lengthOfLIS([5]) == 1)
assert(s2.lengthOfLIS([5]) == 1)

// 边界：严格递减数组，期望输出 1
assert(s1.lengthOfLIS([5, 4, 3, 2, 1]) == 1)
assert(s2.lengthOfLIS([5, 4, 3, 2, 1]) == 1)

// 边界：严格递增数组，期望输出等于数组长度
assert(s1.lengthOfLIS([1, 2, 3, 4, 5]) == 5)
assert(s2.lengthOfLIS([1, 2, 3, 4, 5]) == 5)

print("所有测试用例通过 ✓")

//: [Next](@next)
