//: [Previous](@previous)

import Foundation

/*
 整数数组 nums 按升序排列，数组中的值 互不相同 。

 在传递给函数之前，nums 在预先未知的某个下标 k（0 <= k < nums.length）上进行了 向左旋转，使数组变为 [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]（下标 从 0 开始 计数）。例如， [0,1,2,4,5,6,7] 下标 3 上向左旋转后可能变为 [4,5,6,7,0,1,2] 。

 给你 旋转后 的数组 nums 和一个整数 target ，如果 nums 中存在这个目标值 target ，则返回它的下标，否则返回 -1 。

 你必须设计一个时间复杂度为 O(log n) 的算法解决此问题。



 示例 1：

 输入：nums = [4,5,6,7,0,1,2], target = 0
 输出：4
 示例 2：

 输入：nums = [4,5,6,7,0,1,2], target = 3
 输出：-1
 示例 3：

 输入：nums = [1], target = 0
 输出：-1


 提示：

 1 <= nums.length <= 5000
 -104 <= nums[i] <= 104
 nums 中的每个值都 独一无二
 题目数据保证 nums 在预先未知的某个下标上进行了旋转
 -104 <= target <= 104

 LeetCode: https://leetcode.cn/problems/search-in-rotated-sorted-array/description/
 */

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target {
                return mid
            }

            // 判断 mid 落在左半段（有序部分）还是右半段
            if nums[mid] >= nums[left] {
                // [left, mid] 有序，判断 target 是否在此范围内
                if target >= nums[left] && target < nums[mid] {
                    right = mid - 1  // target 在左有序区间
                } else {
                    left = mid + 1   // target 在右侧（含旋转点）
                }
            } else {
                // [mid, right] 有序，判断 target 是否在此范围内
                if target <= nums[right] && target > nums[mid] {
                    left = mid + 1   // target 在右有序区间
                } else {
                    right = mid - 1  // target 在左侧（含旋转点）
                }
            }
        }
        return -1
    }
}

// MARK: - 测试

let solution = Solution()
var passed = 0
var failed = 0

@MainActor func check(_ label: String, _ got: Int, _ expected: Int) {
    if got == expected {
        print("✅ \(label): \(got)")
        passed += 1
    } else {
        print("❌ \(label): got \(got), expected \(expected)")
        failed += 1
    }
}

// LeetCode 示例
check("示例1 目标在旋转后半段",        solution.search([4,5,6,7,0,1,2], 0),  4)
check("示例2 目标不存在",              solution.search([4,5,6,7,0,1,2], 3), -1)
check("示例3 单元素不匹配",            solution.search([1], 0),              -1)

// 边界：单元素命中
check("单元素命中",                    solution.search([1], 1),               0)

// 边界：两个元素
check("两元素命中左",                  solution.search([3,1], 3),             0)
check("两元素命中右",                  solution.search([3,1], 1),             1)
check("两元素不存在",                  solution.search([3,1], 2),            -1)

// 无旋转（完全有序）
check("无旋转 命中中间",               solution.search([1,2,3,4,5], 3),       2)
check("无旋转 命中首位",               solution.search([1,2,3,4,5], 1),       0)
check("无旋转 命中末位",               solution.search([1,2,3,4,5], 5),       4)
check("无旋转 不存在",                 solution.search([1,2,3,4,5], 6),      -1)

// 旋转点在中间
check("旋转 命中左段首位",             solution.search([4,5,6,7,0,1,2], 4),   0)
check("旋转 命中左段末位",             solution.search([4,5,6,7,0,1,2], 7),   3)
check("旋转 命中右段末位",             solution.search([4,5,6,7,0,1,2], 2),   6)

// 旋转点在末尾附近（几乎有序）
check("旋转靠末 命中右段",             solution.search([2,3,4,5,6,7,0,1], 0), 6)
check("旋转靠末 命中左段",             solution.search([2,3,4,5,6,7,0,1], 5), 3)

// 旋转点在头部附近
check("旋转靠头 命中",                 solution.search([6,7,0,1,2,3,4,5], 3), 5)
check("旋转靠头 不存在",               solution.search([6,7,0,1,2,3,4,5], 8),-1)

print("\n共 \(passed + failed) 个测试，通过 \(passed)，失败 \(failed)")

//: [Next](@next)
