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
 
 LeetCode：https://leetcode.cn/problems/4sum/
 */

class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        // 双指针法要求数组有序
        let sorted = nums.sorted()
        return nSumTarget(sorted, 4, 0, target)
    }

    /// 通用 n 数之和（递归 + 双指针）
    /// - Parameters:
    ///   - nums: 已排序数组
    ///   - n: 需要选取的元素个数
    ///   - start: 本层搜索的起始下标
    ///   - target: 目标和
    func nSumTarget(_ nums: [Int], _ n: Int, _ start: Int, _ target: Int) -> [[Int]] {
        let sz = nums.count
        var res: [[Int]] = []

        // 剩余元素不足 n 个，直接返回
        guard sz - start >= n else { return res }

        if n == 2 {
            // 双指针夹逼：low 从左，high 从右
            var low = start
            var high = sz - 1         
            while low < high {
                let left = nums[low]
                let right = nums[high]
                let sum = left + right
                if sum < target {
                    // 跳过所有与 left 相同的元素，避免重复结果
                    while low < high && nums[low] == left { low += 1 }
                } else if sum > target {
                    // 跳过所有与 right 相同的元素，避免重复结果
                    while low < high && nums[high] == right { high -= 1 }
                } else {
                    res.append([left, right])
                    while low < high && nums[low] == left { low += 1 }
                    while low < high && nums[high] == right { high -= 1 }
                }
            }
        } else {
            for i in start..<sz {
                // 与 start 比较而非 0，避免把本轮第一个元素误当重复跳过
                if i > start && nums[i] == nums[i - 1] { continue }

                // 固定 nums[i]，递归求剩余 (n-1) 个数之和等于 target - nums[i]
                let pairs = nSumTarget(nums, n - 1, i + 1, target - nums[i])
                for pair in pairs {
                    res.append([nums[i]] + pair)
                }
            }
        }
        return res
    }
}

// MARK: - 测试

/// 将二维数组排序后比较，消除顺序差异
func normalize(_ arr: [[Int]]) -> [[Int]] {
    arr.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
}

func assertEqual(_ result: [[Int]], _ expected: [[Int]], testName: String) {
    if normalize(result) == normalize(expected) {
        print("✅ \(testName) 通过")
    } else {
        print("❌ \(testName) 失败")
        print("   期望: \(normalize(expected))")
        print("   实际: \(normalize(result))")
    }
}

let sol = Solution()

// LeetCode 示例 1：两个 0 和 2 使三组四元组合法
assertEqual(
    sol.fourSum([1, 0, -1, -2, 0, 2], 0),
    [[-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]],
    testName: "示例1 [1,0,-1,-2,0,2] target=0"
)

// LeetCode 示例 2：全为相同数字
assertEqual(
    sol.fourSum([2, 2, 2, 2, 2], 8),
    [[2, 2, 2, 2]],
    testName: "示例2 [2,2,2,2,2] target=8"
)

// 全零
assertEqual(
    sol.fourSum([0, 0, 0, 0], 0),
    [[0, 0, 0, 0]],
    testName: "全零 [0,0,0,0] target=0"
)

// 含负数
assertEqual(
    sol.fourSum([-3, -2, -1, 0, 0, 1, 2, 3], 0),
    [[-3,-2,2,3], [-3,-1,1,3], [-3,0,0,3], [-3,0,1,2],
     [-2,-1,0,3], [-2,-1,1,2], [-2,0,0,2], [-1,0,0,1]],
    testName: "含负数 [-3,-2,-1,0,0,1,2,3] target=0"
)

// 无解
assertEqual(
    sol.fourSum([1, 2, 3, 4], 100),
    [],
    testName: "无解 [1,2,3,4] target=100"
)

// 输入元素不足 4 个
assertEqual(
    sol.fourSum([1, 2, 3], 6),
    [],
    testName: "元素不足4个"
)

// 输入为空
assertEqual(
    sol.fourSum([], 0),
    [],
    testName: "空数组"
)

//: [Next](@next)
