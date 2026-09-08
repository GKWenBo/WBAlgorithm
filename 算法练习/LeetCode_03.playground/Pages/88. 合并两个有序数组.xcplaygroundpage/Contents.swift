//: [Previous](@previous)

import Foundation

/*
 给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。

 请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。

 注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。

  

 示例 1：

 输入：nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
 输出：[1,2,2,3,5,6]
 解释：需要合并 [1,2,3] 和 [2,5,6] 。
 合并结果是 [1,2,2,3,5,6] ，其中斜体加粗标注的为 nums1 中的元素。
 示例 2：

 输入：nums1 = [1], m = 1, nums2 = [], n = 0
 输出：[1]
 解释：需要合并 [1] 和 [] 。
 合并结果是 [1] 。
 示例 3：

 输入：nums1 = [0], m = 0, nums2 = [1], n = 1
 输出：[1]
 解释：需要合并的数组是 [] 和 [1] 。
 合并结果是 [1] 。
 注意，因为 m = 0 ，所以 nums1 中没有元素。nums1 中仅存的 0 仅仅是为了确保合并结果可以顺利存放到 nums1 中。
  

 提示：

 nums1.length == m + n
 nums2.length == n
 0 <= m, n <= 200
 1 <= m + n <= 200
 -109 <= nums1[i], nums2[j] <= 109
  

 进阶：你可以设计实现一个时间复杂度为 O(m + n) 的算法解决此问题吗？
 
 LeetCode：https://leetcode.cn/problems/merge-sorted-array/description/
 */

class Solution {
    // 方法一：逆向双指针（原地合并）
    // 从尾部向前填充，避免覆盖 nums1 中尚未处理的元素
    // 时间复杂度：O(m + n)，每个元素恰好被写入一次
    // 空间复杂度：O(1)，直接在 nums1 上操作，无额外空间
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = m - 1      // nums1 有效部分的末尾指针
        var j = n - 1      // nums2 的末尾指针
        var k = m + n - 1  // nums1 写入位置（从末尾开始）
        while j >= 0 {
            // 当 nums1[i] 更大时，将其移到 k 位置；否则填入 nums2[j]
            if i >= 0 && nums1[i] > nums2[j] {
                nums1[k] = nums1[i]
                i -= 1
            } else {
                nums1[k] = nums2[j]
                j -= 1
            }
            k -= 1
        }
        // j < 0 时，nums2 已全部合并，nums1 剩余部分已在原位，无需处理
    }

    // 方法二：正向双指针（借助辅助数组）
    // 同时遍历两个数组，按序写入辅助数组，最后拷回 nums1
    // 时间复杂度：O(m + n)，每个元素被访问一次
    // 空间复杂度：O(m + n)，需要额外的 result 数组存储合并结果
    func merge1(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = 0
        var j = 0
        var result: [Int] = []
        result.reserveCapacity(m + n)
        while i < m && j < n {
            if nums1[i] <= nums2[j] {
                result.append(nums1[i])
                i += 1
            } else {
                result.append(nums2[j])
                j += 1
            }
        }
        // 将剩余元素追加（两个 while 最多只有一个有剩余）
        result.append(contentsOf: nums1[i..<m])
        result.append(contentsOf: nums2[j...])
        for (index, num) in result.enumerated() {
            nums1[index] = num
        }
    }
}

// MARK: - 测试

/// 辅助：用指定方法合并，返回合并后的 nums1
func runMerge(method: (inout [Int], Int, [Int], Int) -> Void,
              nums1: [Int], m: Int,
              nums2: [Int], n: Int) -> [Int] {
    var arr = nums1
    method(&arr, m, nums2, n)
    return arr
}

/// 断言并打印结果
func assertEqual(_ result: [Int], _ expected: [Int], _ label: String) {
    if result == expected {
        print("✅ \(label): \(result)")
    } else {
        print("❌ \(label): expected \(expected), got \(result)")
    }
}

let solution = Solution()

// 测试方法一（逆向双指针）
print("=== 方法一：逆向双指针 ===")
assertEqual(
    runMerge(method: solution.merge, nums1: [1,2,3,0,0,0], m: 3, nums2: [2,5,6], n: 3),
    [1,2,2,3,5,6], "示例1"
)
assertEqual(
    runMerge(method: solution.merge, nums1: [1], m: 1, nums2: [], n: 0),
    [1], "示例2：nums2 为空"
)
assertEqual(
    runMerge(method: solution.merge, nums1: [0], m: 0, nums2: [1], n: 1),
    [1], "示例3：nums1 有效部分为空"
)
assertEqual(
    runMerge(method: solution.merge, nums1: [4,5,6,0,0,0], m: 3, nums2: [1,2,3], n: 3),
    [1,2,3,4,5,6], "nums2 全部小于 nums1"
)
assertEqual(
    runMerge(method: solution.merge, nums1: [1,2,3,0,0,0], m: 3, nums2: [4,5,6], n: 3),
    [1,2,3,4,5,6], "nums2 全部大于 nums1"
)
assertEqual(
    runMerge(method: solution.merge, nums1: [2,2,2,0,0], m: 3, nums2: [2,2], n: 2),
    [2,2,2,2,2], "所有元素相等"
)
assertEqual(
    runMerge(method: solution.merge, nums1: [-3,-1,0,0,0,0], m: 3, nums2: [-2,0,2], n: 3),
    [-3,-2,-1,0,0,2], "含负数"
)

// 测试方法二（正向双指针 + 辅助数组）
print("\n=== 方法二：正向双指针 ===")
assertEqual(
    runMerge(method: solution.merge1, nums1: [1,2,3,0,0,0], m: 3, nums2: [2,5,6], n: 3),
    [1,2,2,3,5,6], "示例1"
)
assertEqual(
    runMerge(method: solution.merge1, nums1: [1], m: 1, nums2: [], n: 0),
    [1], "示例2：nums2 为空"
)
assertEqual(
    runMerge(method: solution.merge1, nums1: [0], m: 0, nums2: [1], n: 1),
    [1], "示例3：nums1 有效部分为空"
)
assertEqual(
    runMerge(method: solution.merge1, nums1: [4,5,6,0,0,0], m: 3, nums2: [1,2,3], n: 3),
    [1,2,3,4,5,6], "nums2 全部小于 nums1"
)
assertEqual(
    runMerge(method: solution.merge1, nums1: [1,2,3,0,0,0], m: 3, nums2: [4,5,6], n: 3),
    [1,2,3,4,5,6], "nums2 全部大于 nums1"
)
assertEqual(
    runMerge(method: solution.merge1, nums1: [2,2,2,0,0], m: 3, nums2: [2,2], n: 2),
    [2,2,2,2,2], "所有元素相等"
)
assertEqual(
    runMerge(method: solution.merge1, nums1: [-3,-1,0,0,0,0], m: 3, nums2: [-2,0,2], n: 3),
    [-3,-2,-1,0,0,2], "含负数"
)

//: [Next](@next)
