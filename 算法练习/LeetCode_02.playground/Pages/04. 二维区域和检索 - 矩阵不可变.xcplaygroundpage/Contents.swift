//: [Previous](@previous)

import Foundation

/*
 给定一个二维矩阵 matrix，以下类型的多个请求：

 计算其子矩形范围内元素的总和，该子矩阵的 左上角 为 (row1, col1) ，右下角 为 (row2, col2) 。
 实现 NumMatrix 类：

 NumMatrix(int[][] matrix) 给定整数矩阵 matrix 进行初始化
 int sumRegion(int row1, int col1, int row2, int col2) 返回 左上角 (row1, col1) 、右下角 (row2, col2) 所描述的子矩阵的元素 总和 。


 示例 1：



 输入:
 ["NumMatrix","sumRegion","sumRegion","sumRegion"]
 [[[[3,0,1,4,2],[5,6,3,2,1],[1,2,0,1,5],[4,1,0,1,7],[1,0,3,0,5]]],[2,1,4,3],[1,1,2,2],[1,2,2,4]]
 输出:
 [null, 8, 11, 12]

 解释:
 NumMatrix numMatrix = new NumMatrix([[3,0,1,4,2],[5,6,3,2,1],[1,2,0,1,5],[4,1,0,1,7],[1,0,3,0,5]]);
 numMatrix.sumRegion(2, 1, 4, 3); // return 8 (红色矩形框的元素总和)
 numMatrix.sumRegion(1, 1, 2, 2); // return 11 (绿色矩形框的元素总和)
 numMatrix.sumRegion(1, 2, 2, 4); // return 12 (蓝色矩形框的元素总和)


 提示：

 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 200
 -105 <= matrix[i][j] <= 105
 0 <= row1 <= row2 < m
 0 <= col1 <= col2 < n
 最多调用 104 次 sumRegion 方法

 LeetCode: https://leetcode.cn/problems/range-sum-query-2d-immutable/description/
 */

/*
 算法思路：二维前缀和

 构建一个 (m+1) x (n+1) 的前缀和数组 preSum，首行首列全为 0 作为哨兵边界，避免越界判断。

 preSum[i][j] 表示从 matrix[0][0] 到 matrix[i-1][j-1] 构成的子矩阵的元素总和。

 填表公式（容斥原理）：
   preSum[i][j] = preSum[i-1][j] + preSum[i][j-1] - preSum[i-1][j-1] + matrix[i-1][j-1]

 查询公式（将大矩形减去两个多余的边，再补回多减的角）：
   sumRegion(r1,c1,r2,c2)
     = preSum[r2+1][c2+1]
     - preSum[r1][c2+1]
     - preSum[r2+1][c1]
     + preSum[r1][c1]

 时间复杂度：初始化 O(m*n)，每次查询 O(1)
 空间复杂度：O(m*n)
 */

class NumMatrix {

    // 前缀和数组，大小为 (m+1) x (n+1)，首行首列为 0
    var preSum: [[Int]]

    init(_ matrix: [[Int]]) {
        let m = matrix.count
        let n = matrix[0].count
        // 多出一行一列作为边界哨兵，下标从 1 开始对应 matrix[0][0]
        preSum = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        for i in 1...m {
            for j in 1...n {
                // 容斥原理：加上上方和左方，减去重叠的左上角，再加上当前格
                preSum[i][j] = preSum[i - 1][j] + preSum[i][j - 1] - preSum[i - 1][j - 1] + matrix[i - 1][j - 1]
            }
        }
    }

    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        // 用容斥原理从预处理的前缀和中 O(1) 求出子矩阵之和
        return preSum[row2 + 1][col2 + 1] - preSum[row1][col2 + 1] - preSum[row2 + 1][col1] + preSum[row1][col1]
    }
}

// MARK: - 测试

/// 辅助：断言并打印结果
func check(_ label: String, result: Int, expected: Int) {
    if result == expected {
        print("✅ \(label): \(result)")
    } else {
        print("❌ \(label): got \(result), expected \(expected)")
    }
}

// 测试 1：题目示例
let matrix1: [[Int]] = [
    [3, 0, 1, 4, 2],
    [5, 6, 3, 2, 1],
    [1, 2, 0, 1, 5],
    [4, 1, 0, 1, 7],
    [1, 0, 3, 0, 5]
]
let nm1 = NumMatrix(matrix1)
check("示例 sumRegion(2,1,4,3)", result: nm1.sumRegion(2, 1, 4, 3), expected: 8)
check("示例 sumRegion(1,1,2,2)", result: nm1.sumRegion(1, 1, 2, 2), expected: 11)
check("示例 sumRegion(1,2,2,4)", result: nm1.sumRegion(1, 2, 2, 4), expected: 12)

// 测试 2：整个矩阵求和
// matrix1 所有元素之和 = 3+0+1+4+2+5+6+3+2+1+1+2+0+1+5+4+1+0+1+7+1+0+3+0+5 = 58
check("整个矩阵之和 sumRegion(0,0,4,4)", result: nm1.sumRegion(0, 0, 4, 4), expected: 58)

// 测试 3：单个元素
check("单元素 sumRegion(0,0,0,0)", result: nm1.sumRegion(0, 0, 0, 0), expected: 3)
check("单元素 sumRegion(2,2,2,2)", result: nm1.sumRegion(2, 2, 2, 2), expected: 0)
check("单元素 sumRegion(4,4,4,4)", result: nm1.sumRegion(4, 4, 4, 4), expected: 5)

// 测试 4：单行 / 单列
check("单行 sumRegion(0,0,0,4)", result: nm1.sumRegion(0, 0, 0, 4), expected: 10)
check("单列 sumRegion(0,0,4,0)", result: nm1.sumRegion(0, 0, 4, 0), expected: 14)

// 测试 5：包含负数的矩阵
let matrix2: [[Int]] = [
    [-1, -2],
    [-3, -4]
]
let nm2 = NumMatrix(matrix2)
check("负数矩阵 sumRegion(0,0,1,1)", result: nm2.sumRegion(0, 0, 1, 1), expected: -10)
check("负数矩阵 sumRegion(0,0,0,1)", result: nm2.sumRegion(0, 0, 0, 1), expected: -3)

// 测试 6：1x1 矩阵
let matrix3: [[Int]] = [[7]]
let nm3 = NumMatrix(matrix3)
check("1x1 矩阵 sumRegion(0,0,0,0)", result: nm3.sumRegion(0, 0, 0, 0), expected: 7)

//: [Next](@next)
