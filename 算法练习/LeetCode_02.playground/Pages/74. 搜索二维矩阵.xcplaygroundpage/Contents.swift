//: [Previous](@previous)

import Foundation

/*
 给你一个满足下述两条属性的 m x n 整数矩阵：

 每行中的整数从左到右按非严格递增顺序排列。
 每行的第一个整数大于前一行的最后一个整数。
 给你一个整数 target ，如果 target 在矩阵中，返回 true ；否则，返回 false 。

  

 示例 1：


 输入：matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
 输出：true
 示例 2：


 输入：matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
 输出：false
  

 提示：

 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 100
 -104 <= matrix[i][j], target <= 104
 
 LeetCode: https://leetcode.cn/problems/search-a-2d-matrix/description/
 */

class Solution {
    /// 二分查找：将 m×n 矩阵视为长度为 m*n 的有序数组，对虚拟下标做标准二分。
    /// 时间复杂度 O(log(m*n))，空间复杂度 O(1)
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        var left = 0
        var right = matrix.count * matrix[0].count - 1

        while left <= right {
            let mid = left + (right - left) / 2
            let midValue = element(at: mid, in: matrix)

            if midValue == target {
                return true
            } else if midValue < target {
                left = mid + 1  // target 在右半段
            } else {
                right = mid - 1 // target 在左半段
            }
        }
        return false
    }

    /// 将一维虚拟下标映射回二维坐标并返回对应元素
    private func element(at index: Int, in matrix: [[Int]]) -> Int {
        let cols = matrix[0].count
        return matrix[index / cols][index % cols]
    }
}

// MARK: - 测试

let solution = Solution()

// 辅助：断言并打印测试结果
func check(_ result: Bool, expected: Bool, caseName: String) {
    let passed = result == expected
    print("\(passed ? "✅" : "❌") \(caseName): result=\(result), expected=\(expected)")
}

// 基础示例
let matrix1 = [[1,3,5,7],[10,11,16,20],[23,30,34,60]]
check(solution.searchMatrix(matrix1, 3),   expected: true,  caseName: "示例1 - target=3 存在")
check(solution.searchMatrix(matrix1, 13),  expected: false, caseName: "示例2 - target=13 不存在")

// 边界：target 是矩阵第一个元素
check(solution.searchMatrix(matrix1, 1),   expected: true,  caseName: "首元素 target=1")

// 边界：target 是矩阵最后一个元素
check(solution.searchMatrix(matrix1, 60),  expected: true,  caseName: "末元素 target=60")

// 边界：target 小于矩阵最小值
check(solution.searchMatrix(matrix1, 0),   expected: false, caseName: "target 小于最小值")

// 边界：target 大于矩阵最大值
check(solution.searchMatrix(matrix1, 100), expected: false, caseName: "target 大于最大值")

// 单元素矩阵 - 命中
check(solution.searchMatrix([[5]], 5),     expected: true,  caseName: "单元素矩阵 - 命中")

// 单元素矩阵 - 未命中
check(solution.searchMatrix([[5]], 3),     expected: false, caseName: "单元素矩阵 - 未命中")

// 单行矩阵
check(solution.searchMatrix([[1,3,5,7]], 5), expected: true,  caseName: "单行矩阵 - 命中")
check(solution.searchMatrix([[1,3,5,7]], 4), expected: false, caseName: "单行矩阵 - 未命中")

// 单列矩阵
check(solution.searchMatrix([[1],[3],[5]], 3), expected: true,  caseName: "单列矩阵 - 命中")
check(solution.searchMatrix([[1],[3],[5]], 2), expected: false, caseName: "单列矩阵 - 未命中")

// 负数元素
let matrix2 = [[-10,-5,0],[1,4,9],[12,20,30]]
check(solution.searchMatrix(matrix2, -5),  expected: true,  caseName: "负数矩阵 - 命中")
check(solution.searchMatrix(matrix2, -1),  expected: false, caseName: "负数矩阵 - 未命中")

//: [Next](@next)
