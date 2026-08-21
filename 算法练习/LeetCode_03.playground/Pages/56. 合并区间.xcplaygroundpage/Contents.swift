//: [Previous](@previous)

import Foundation


/*
 以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回 一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间 。



 示例 1：

 输入：intervals = [[1,3],[2,6],[8,10],[15,18]]
 输出：[[1,6],[8,10],[15,18]]
 解释：区间 [1,3] 和 [2,6] 重叠, 将它们合并为 [1,6].
 示例 2：

 输入：intervals = [[1,4],[4,5]]
 输出：[[1,5]]
 解释：区间 [1,4] 和 [4,5] 可被视为重叠区间。
 示例 3：

 输入：intervals = [[4,7],[1,4]]
 输出：[[1,7]]
 解释：区间 [1,4] 和 [4,7] 可被视为重叠区间。


 提示：

 1 <= intervals.length <= 104
 intervals[i].length == 2
 0 <= starti <= endi <= 104

 LeetCode: https://leetcode.cn/problems/merge-intervals/description/

 ────────────────────────────────────────────────
 思路：排序 + 线性扫描
 1. 按区间左端点升序排序，保证相邻区间才可能重叠
 2. 将第一个区间放入结果集，逐个检查后续区间：
    - 若当前区间左端点 ≤ 结果集末尾区间的右端点 → 两者重叠，
      更新末尾区间右端点为两者最大值（原地修改 res）
    - 否则无重叠，直接追加到结果集

 时间复杂度：O(n log n)  — 排序主导，后续线性扫描 O(n)
 空间复杂度：O(n)        — 排序内部使用 O(log n) 栈空间，结果数组最坏 O(n)
 ────────────────────────────────────────────────
 */

class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        // 按左端点升序排序，确保可合并的区间相邻
        let sorted = intervals.sorted { $0[0] < $1[0] }

        var res: [[Int]] = [sorted[0]]

        for i in 1..<sorted.count {
            let cur = sorted[i]
            // 当前区间左端点 ≤ 结果末尾区间右端点，说明有重叠
            if cur[0] <= res.last![1] {
                // 原地更新末尾区间右端点（注意：不能用 var last = res.last!，
                // 那样只是值拷贝，修改不会反映到 res）
                res[res.count - 1][1] = max(res.last![1], cur[1])
            } else {
                res.append(cur)
            }
        }

        return res
    }
}

// MARK: - 测试

let s = Solution()

/// 辅助：比较两个二维数组是否相等
func equal(_ a: [[Int]], _ b: [[Int]]) -> Bool {
    guard a.count == b.count else { return false }
    return zip(a, b).allSatisfy { $0 == $1 }
}

/// 辅助：打印测试结果
func check(_ desc: String, input: [[Int]], expected: [[Int]]) {
    let result = s.merge(input)
    let pass = equal(result, expected)
    print("[\(pass ? "PASS" : "FAIL")] \(desc)")
    if !pass {
        print("  期望: \(expected)")
        print("  实际: \(result)")
    }
}

// 示例 1：标准重叠合并
check("示例1 - 普通重叠",
      input: [[1,3],[2,6],[8,10],[15,18]],
      expected: [[1,6],[8,10],[15,18]])

// 示例 2：端点相邻（视为重叠）
check("示例2 - 端点相邻",
      input: [[1,4],[4,5]],
      expected: [[1,5]])

// 示例 3：输入无序，需先排序
check("示例3 - 输入无序",
      input: [[4,7],[1,4]],
      expected: [[1,7]])

// 边界：只有一个区间
check("只有1个区间",
      input: [[2,5]],
      expected: [[2,5]])

// 所有区间完全重叠，合并成一个
check("所有区间完全重叠",
      input: [[1,10],[2,8],[3,6]],
      expected: [[1,10]])

// 无任何重叠，原样输出（但需按左端点排序）
check("无重叠 - 输入已有序",
      input: [[1,2],[3,4],[5,6]],
      expected: [[1,2],[3,4],[5,6]])

// 无重叠 - 输入无序
check("无重叠 - 输入无序",
      input: [[5,6],[1,2],[3,4]],
      expected: [[1,2],[3,4],[5,6]])

// 多个连续区间最终合并为一个
check("级联重叠合并为一个",
      input: [[1,3],[2,5],[4,8],[6,10]],
      expected: [[1,10]])

// 包含被完全包含的子区间
check("子区间被完全包含",
      input: [[1,10],[2,3],[4,6]],
      expected: [[1,10]])

//: [Next](@next)
