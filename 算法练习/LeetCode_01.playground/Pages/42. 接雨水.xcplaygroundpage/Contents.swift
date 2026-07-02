//: [Previous](@previous)

import Foundation

/*
 给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能接多少雨水。

  

 示例 1：



 输入：height = [0,1,0,2,1,0,1,3,2,1,2,1]
 输出：6
 解释：上面是由数组 [0,1,0,2,1,0,1,3,2,1,2,1] 表示的高度图，在这种情况下，可以接 6 个单位的雨水（蓝色部分表示雨水）。
 示例 2：

 输入：height = [4,2,0,3,2,5]
 输出：9
  

 提示：

 n == height.length
 1 <= n <= 2 * 104
 0 <= height[i] <= 105
 
 LeetCode：https://leetcode.cn/problems/trapping-rain-water/description/
 */

/// 解法一：动态规划（预计算左右最大值数组）
/// 时间复杂度：O(n)，空间复杂度：O(n)
///
/// 核心思路：位置 i 能接的雨水 = min(左侧最高柱, 右侧最高柱) - height[i]
/// 预先计算每个位置的 lMax[i]（含 i 在内向左最大值）和 rMax[i]（含 i 在内向右最大值）
class Solution {
    func trap(_ height: [Int]) -> Int {
        guard height.count > 0 else {
            return 0
        }

        var res = 0
        let count = height.count
        // lMax[i]：height[0..i] 中的最大值
        var lMax: [Int] = Array(repeating: 0, count: count)
        // rMax[i]：height[i..count-1] 中的最大值
        var rMax: [Int] = Array(repeating: 0, count: count)

        lMax[0] = height[0]
        rMax[count - 1] = height[count - 1]

        // 从左向右填充 lMax
        for i in 1..<count {
            lMax[i] = max(height[i], lMax[i - 1])
        }

        // 从右向左填充 rMax
        for i in stride(from: count - 2, through: 0, by: -1) {
            rMax[i] = max(height[i], rMax[i + 1])
        }

        // 每个位置能接的水量 = 左右最高柱的较小值 - 当前柱高
        for i in 0..<count {
            res += min(lMax[i], rMax[i]) - height[i]
        }

        return res
    }
}

/// 解法二：双指针（空间优化）
/// 时间复杂度：O(n)，空间复杂度：O(1)
///
/// 核心思路：用双指针从两端向中间收拢，哪侧的最大值更小就处理哪侧
/// 若 lMax < rMax，左侧位置的积水由 lMax 决定，可以直接计算并移动左指针
class Solution2 {
    func trap(_ height: [Int]) -> Int {
        var left = 0, right = height.count - 1
        var lMax = 0, rMax = 0
        var res = 0

        while left < right {
            lMax = max(lMax, height[left])
            rMax = max(rMax, height[right])

            if lMax < rMax {
                // 左侧短板决定积水高度
                res += lMax - height[left]
                left += 1
            } else {
                // 右侧短板决定积水高度
                res += rMax - height[right]
                right -= 1
            }
        }

        return res
    }
}

// MARK: - 测试

let s1 = Solution()
let s2 = Solution2()

/// 对两种解法同时断言
@MainActor func assertEqual(_ height: [Int], expected: Int, label: String) {
    let r1 = s1.trap(height)
    let r2 = s2.trap(height)
    let pass1 = r1 == expected
    let pass2 = r2 == expected
    print("\(label): 解法一 \(pass1 ? "✅" : "❌")(\(r1))  解法二 \(pass2 ? "✅" : "❌")(\(r2))  期望: \(expected)")
}

// 示例 1：典型多峰场景，期望 6
assertEqual([0,1,0,2,1,0,1,3,2,1,2,1], expected: 6, label: "示例1")

// 示例 2：两端夹中间低谷，期望 9
assertEqual([4,2,0,3,2,5], expected: 9, label: "示例2")

// 边界：空数组，期望 0
assertEqual([], expected: 0, label: "空数组")

// 边界：单个元素，无法积水，期望 0
assertEqual([5], expected: 0, label: "单元素")

// 边界：两个元素，无法积水，期望 0
assertEqual([3,4], expected: 0, label: "两元素")

// 全部等高，无法积水，期望 0
assertEqual([3,3,3,3], expected: 0, label: "全等高")

// 单调递增，无法积水，期望 0
assertEqual([1,2,3,4,5], expected: 0, label: "单调递增")

// 单调递减，无法积水，期望 0
assertEqual([5,4,3,2,1], expected: 0, label: "单调递减")

// V 形（两端高中间低），期望 3
assertEqual([3,0,3], expected: 3, label: "V形")

// 多个低谷：lMax=[3,3,3,3,4], rMax=[4,4,4,4,4]，期望 7
assertEqual([3,0,2,0,4], expected: 7, label: "多低谷")

//: [Next](@next)
