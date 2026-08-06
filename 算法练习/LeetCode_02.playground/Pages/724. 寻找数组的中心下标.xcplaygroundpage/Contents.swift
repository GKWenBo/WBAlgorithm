//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums ，请计算数组的 中心下标 。

 数组 中心下标 是数组的一个下标，其左侧所有元素相加的和等于右侧所有元素相加的和。

 如果中心下标位于数组最左端，那么左侧数之和视为 0 ，因为在下标的左侧不存在元素。这一点对于中心下标位于数组最右端同样适用。

 如果数组有多个中心下标，应该返回 最靠近左边 的那一个。如果数组不存在中心下标，返回 -1 。

  

 示例 1：

 输入：nums = [1, 7, 3, 6, 5, 6]
 输出：3
 解释：
 中心下标是 3 。
 左侧数之和 sum = nums[0] + nums[1] + nums[2] = 1 + 7 + 3 = 11 ，
 右侧数之和 sum = nums[4] + nums[5] = 5 + 6 = 11 ，二者相等。
 示例 2：

 输入：nums = [1, 2, 3]
 输出：-1
 解释：
 数组中不存在满足此条件的中心下标。
 示例 3：

 输入：nums = [2, 1, -1]
 输出：0
 解释：
 中心下标是 0 。
 左侧数之和 sum = 0 ，（下标 0 左侧不存在元素），
 右侧数之和 sum = nums[1] + nums[2] = 1 + -1 = 0 。
  

 提示：

 1 <= nums.length <= 104
 -1000 <= nums[i] <= 1000
  

 注意：本题与主站 1991 题相同：https://leetcode.cn/problems/find-the-middle-index-in-array/
 
 LeetCode: https://leetcode.cn/problems/find-pivot-index/description/
 */

/// 思路：前缀和
/// preSum[i] 表示 nums[0..<i] 的元素之和，preSum[0] = 0
/// 对于下标 i（0-based），左侧和 = preSum[i]，右侧和 = preSum[count] - preSum[i+1]
/// 当 preSum[i] == preSum[count] - preSum[i+1] 时，i 即为中心下标
/// 时间复杂度 O(n)，空间复杂度 O(n)
class Solution {
    func pivotIndex(_ nums: [Int]) -> Int {
        let count = nums.count
        // preSum[i] 表示前 i 个元素之和，即 nums[0..<i] 的总和
        var preSum = [Int](repeating: 0, count: count + 1)
        for i in 1...count {
            preSum[i] = preSum[i - 1] + nums[i - 1]
        }

        // 枚举每个下标（1-based），判断左右两侧之和是否相等
        for i in 1...count {
            let leftSum = preSum[i - 1]          // nums[0..<i-1] 的和（i-1 左侧）
            let rightSum = preSum[count] - preSum[i]  // nums[i..<count] 的和（i-1 右侧）
            if leftSum == rightSum {
                return i - 1  // 转换为 0-based 下标
            }
        }
        return -1
    }
}

// MARK: - 测试

let solution = Solution()

// 辅助断言函数
func assertEqual(_ result: Int, _ expected: Int, _ testCase: String) {
    if result == expected {
        print("✅ \(testCase) → \(result)")
    } else {
        print("❌ \(testCase) → 期望 \(expected)，实际 \(result)")
    }
}

// 题目示例 1：中心下标在中间
// 下标 3 左侧: 1+7+3=11，右侧: 5+6=11
assertEqual(solution.pivotIndex([1, 7, 3, 6, 5, 6]), 3, "[1,7,3,6,5,6]")

// 题目示例 2：不存在中心下标
assertEqual(solution.pivotIndex([1, 2, 3]), -1, "[1,2,3]")

// 题目示例 3：中心下标在最左端
// 下标 0 左侧: 0，右侧: 1+(-1)=0
assertEqual(solution.pivotIndex([2, 1, -1]), 0, "[2,1,-1]")

// 单元素数组：唯一元素两侧都为 0，故下标 0 即为中心下标
assertEqual(solution.pivotIndex([0]), 0, "[0]")

// 全零数组：最左边下标 0 满足条件（返回最靠左）
assertEqual(solution.pivotIndex([0, 0, 0]), 0, "[0,0,0]")

// 含负数：下标 2 左=-1+1=0，右=0 ✓
assertEqual(solution.pivotIndex([-1, 1, 0]), 2, "[-1,1,0]")

// 多个满足条件的中心下标，应返回最靠左的
// 下标 2: 左=1+0=1, 右=0+1=1 ✓（最先遇到，直接返回）
assertEqual(solution.pivotIndex([1, 0, 1, 0, 1]), 2, "[1,0,1,0,1]")

// 中心下标在最右端
// [0, 0, 1]: 下标 2 左=0+0=0, 右=0 ✓
assertEqual(solution.pivotIndex([0, 0, 1]), 2, "[0,0,1]")

// 不存在中心下标的边界情况
assertEqual(solution.pivotIndex([1, 2, 3, 4]), -1, "[1,2,3,4]")

//: [Next](@next)
