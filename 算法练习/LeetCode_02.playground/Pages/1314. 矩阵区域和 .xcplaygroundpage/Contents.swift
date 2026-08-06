//: [Previous](@previous)

import Foundation

/*
 给你一个 m x n 的矩阵 mat 和一个整数 k ，请你返回一个矩阵 answer ，其中每个 answer[i][j] 是所有满足下述条件的元素 mat[r][c] 的和：

 i - k <= r <= i + k,
 j - k <= c <= j + k 且
 (r, c) 在矩阵内。


 示例 1：

 输入：mat = [[1,2,3],[4,5,6],[7,8,9]], k = 1
 输出：[[12,21,16],[27,45,33],[24,39,28]]
 示例 2：

 输入：mat = [[1,2,3],[4,5,6],[7,8,9]], k = 2
 输出：[[45,45,45],[45,45,45],[45,45,45]]


 提示：

 m == mat.length
 n == mat[i].length
 1 <= m, n, k <= 100
 1 <= mat[i][j] <= 100

 LeetCode: https://leetcode.cn/problems/matrix-block-sum/description/

 算法思路：二维前缀和

 1. 构建二维前缀和矩阵 preSum（大小为 (m+1) x (n+1)，首行首列填 0）：
    preSum[i][j] = 原矩阵左上角 (0,0) 到 (i-1,j-1) 的元素之和
    递推公式：preSum[i][j] = preSum[i-1][j] + preSum[i][j-1] - preSum[i-1][j-1] + mat[i-1][j-1]

 2. 查询矩形区域 (row1,col1) 到 (row2,col2)（0-indexed）的元素之和（容斥原理）：
    sum = preSum[row2+1][col2+1]
        - preSum[row1][col2+1]   // 减去上方矩形
        - preSum[row2+1][col1]   // 减去左方矩形
        + preSum[row1][col1]     // 加回多减的左上角矩形

 3. 对每个 answer[i][j]，将窗口坐标裁剪到矩阵边界后查询前缀和即可。

 时间复杂度：O(m*n)，空间复杂度：O(m*n)
 */

class Solution {
    func matrixBlockSum(_ mat: [[Int]], _ k: Int) -> [[Int]] {
        let rows = mat.count
        let cols = mat[0].count
        var res: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)
        let sumMatrix = NumMatrix(mat)
        for row in 0..<rows {
            for col in 0..<cols {
                // 将窗口边界裁剪到矩阵范围内
                let row1 = max(row - k, 0)
                let col1 = max(col - k, 0)
                let row2 = min(row + k, rows - 1)
                let col2 = min(col + k, cols - 1)
                res[row][col] = sumMatrix.sumRegion(row1, col1, row2, col2)
            }
        }
        return res
    }

    class NumMatrix {
        // preSum[i][j] 表示原矩阵左上角 (0,0) 到 (i-1,j-1) 所有元素之和
        // 首行、首列全为 0，作为边界哨兵，避免越界判断
        var preSum: [[Int]]

        init(_ matrix: [[Int]]) {
            let m = matrix.count
            let n = matrix[0].count
            preSum = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
            // 利用容斥原理递推二维前缀和
            for i in 1...m {
                for j in 1...n {
                    preSum[i][j] = preSum[i - 1][j] + preSum[i][j - 1]
                               - preSum[i - 1][j - 1] + matrix[i - 1][j - 1]
                }
            }
        }

        // 查询 0-indexed 矩形 (row1,col1) 到 (row2,col2) 的区域和
        // 容斥公式：整体 - 上方 - 左方 + 左上角（被减两次）
        func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
            return preSum[row2 + 1][col2 + 1]
                 - preSum[row1][col2 + 1]
                 - preSum[row2 + 1][col1]
                 + preSum[row1][col1]
        }
    }
}

// MARK: - 测试

/// 比较两个二维数组是否相等
func assertEqual(_ result: [[Int]], _ expected: [[Int]], _ caseName: String) {
    if result == expected {
        print("✅ \(caseName) 通过")
    } else {
        print("❌ \(caseName) 失败")
        print("   期望: \(expected)")
        print("   实际: \(result)")
    }
}

let solution = Solution()

// 示例 1：k=1，3x3 矩阵，每个单元格为以其为中心的 3x3 窗口（裁剪后）之和
assertEqual(
    solution.matrixBlockSum([[1,2,3],[4,5,6],[7,8,9]], 1),
    [[12,21,16],[27,45,33],[24,39,28]],
    "示例1 k=1"
)

// 示例 2：k=2 覆盖整个 3x3 矩阵，所有结果均为总和 45
assertEqual(
    solution.matrixBlockSum([[1,2,3],[4,5,6],[7,8,9]], 2),
    [[45,45,45],[45,45,45],[45,45,45]],
    "示例2 k=2"
)

// 边界：1x1 矩阵，任意 k，结果就是自身
assertEqual(
    solution.matrixBlockSum([[7]], 3),
    [[7]],
    "1x1矩阵"
)

// 边界：1 行多列，k=1，验证行方向裁剪
assertEqual(
    solution.matrixBlockSum([[1,2,3,4]], 1),
    [[3,6,9,7]],
    "1行4列 k=1"
)

// 边界：k=0，每个位置只取自身
assertEqual(
    solution.matrixBlockSum([[1,2,3],[4,5,6],[7,8,9]], 0),
    [[1,2,3],[4,5,6],[7,8,9]],
    "k=0 只取自身"
)

// 大 k 超出矩阵范围，等价于全局求和
assertEqual(
    solution.matrixBlockSum([[1,1],[1,1]], 100),
    [[4,4],[4,4]],
    "k超出边界"
)

//: [Next](@next)
