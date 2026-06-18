//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，
 同时还满足 nums[i] + nums[j] + nums[k] == 0 。请你返回所有和为 0 且不重复的三元组。

 注意：答案中不可以包含重复的三元组。

 示例 1：
 输入：nums = [-1,0,1,2,-1,-4]
 输出：[[-1,-1,2],[-1,0,1]]

 示例 2：
 输入：nums = [0,1,1]
 输出：[]

 示例 3：
 输入：nums = [0,0,0]
 输出：[[0,0,0]]

 提示：
 3 <= nums.length <= 3000
 -105 <= nums[i] <= 105

 思路：排序 + 固定一个元素 + 双指针
 时间复杂度：O(n²)，空间复杂度：O(1)（不计结果数组）
 */

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // 排序一次，后续所有操作都依赖有序性
        threeSum(nums.sorted(), target: 0)
    }

    /// 在已排序的 nums 中找所有和为 target 的不重复三元组
    private func threeSum(_ nums: [Int], target: Int) -> [[Int]] {
        let n = nums.count
        var res: [[Int]] = []

        for i in 0..<n {
            // 跳过重复的首元素，防止三元组重复（需数组已排序）
            if i > 0 && nums[i] == nums[i - 1] { continue }

            // 数组已排序：首元素已超过 target/3 的上界时可提前退出
            if target == 0 && nums[i] > 0 { break }

            let pairs = twoSum(nums, start: i + 1, target: target - nums[i])
            for pair in pairs {
                res.append([nums[i]] + pair)
            }
        }
        return res
    }

    /// 在已排序的 nums[start...] 中用双指针找所有和为 target 的不重复二元组
    private func twoSum(_ nums: [Int], start: Int, target: Int) -> [[Int]] {
        var low = start
        var high = nums.count - 1
        var res: [[Int]] = []

        while low < high {
            let left = nums[low]
            let right = nums[high]
            let sum = left + right

            if sum < target {
                // 和偏小，右移左指针；同时跳过相同值避免重复记录
                while low < high && nums[low] == left { low += 1 }
            } else if sum > target {
                // 和偏大，左移右指针；同时跳过相同值避免重复记录
                while low < high && nums[high] == right { high -= 1 }
            } else {
                res.append([left, right])
                // 找到一对后，两端各自跳过重复值再继续搜索
                while low < high && nums[low] == left  { low += 1 }
                while low < high && nums[high] == right { high -= 1 }
            }
        }
        return res
    }
}

// MARK: - 测试

/// 对结果做规范化（每个三元组内部升序，三元组间字典序排列），方便无序比较
func normalize(_ triplets: [[Int]]) -> [[Int]] {
    triplets
        .map { $0.sorted() }
        .sorted { $0.lexicographicallyPrecedes($1) }
}

func assertEqual(_ result: [[Int]], _ expected: [[Int]], _ caseName: String) {
    if normalize(result) == normalize(expected) {
        print("✅ \(caseName) passed")
    } else {
        print("❌ \(caseName) FAILED — got \(normalize(result)), expected \(normalize(expected))")
    }
}

let solution = Solution()

// 题目给出的示例
assertEqual(solution.threeSum([-1, 0, 1, 2, -1, -4]), [[-1, -1, 2], [-1, 0, 1]], "示例1：标准用例")
assertEqual(solution.threeSum([0, 1, 1]),              [],                         "示例2：无解")
assertEqual(solution.threeSum([0, 0, 0]),              [[0, 0, 0]],                "示例3：全零")

// 边界 & 去重
assertEqual(solution.threeSum([-2, 0, 1, 1, 2]),       [[-2, 0, 2], [-2, 1, 1]],  "含重复正数")
assertEqual(solution.threeSum([1, 2, -3]),              [[-3, 1, 2]],              "单一三元组")
assertEqual(solution.threeSum([-1, -2, -3]),            [],                        "全负数，无解")
assertEqual(solution.threeSum([0, 0, 0, 0]),            [[0, 0, 0]],               "四个零，去重后只有一组")
assertEqual(solution.threeSum([-4, -1, -1, 0, 1, 2]),  [[-1, -1, 2], [-1, 0, 1]], "多重复值去重")

//: [Next](@next)
