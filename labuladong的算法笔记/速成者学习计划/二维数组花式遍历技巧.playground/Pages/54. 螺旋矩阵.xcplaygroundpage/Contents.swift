//: [Previous](@previous)

import Foundation

/*
 给你一个 m 行 n 列的矩阵 matrix ，请按照 顺时针螺旋顺序 ，返回矩阵中的所有元素。
 
 
 
 示例 1：
 
 
 输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]
 输出：[1,2,3,6,9,8,7,4,5]
 示例 2：
 
 
 输入：matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
 输出：[1,2,3,4,8,12,11,10,9,5,6,7]
 
 
 提示：
 
 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 10
 -100 <= matrix[i][j] <= 100
 
 LeetCode：https://leetcode.cn/problems/spiral-matrix/description/
 */

class Solution {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        let m = matrix.count
        let n = matrix[0].count
        
        var upper = 0
        var lower = m - 1
        var left = 0
        var right = n - 1
        
        var res = [Int]()
        res.reserveCapacity(m * n)
        
        while res.count < m * n {
            
            // 从左向右
            if upper <= lower {
                if left <= right {
                    for j in left...right {
                        res.append(matrix[upper][j])
                    }
                }
                upper += 1
            }
            
            // 从上向下
            if left <= right {
                if upper <= lower {
                    for i in upper...lower {
                        res.append(matrix[i][right])
                    }
                }
                right -= 1
            }
            
            // 从右向左
            if upper <= lower {
                if left <= right {
                    for j in stride(from: right, through: left, by: -1) {
                        res.append(matrix[lower][j])
                    }
                }
                lower -= 1
            }
            
            // 从下向上
            if left <= right {
                if upper <= lower {
                    for i in stride(from: lower, through: upper, by: -1) {
                        res.append(matrix[i][left])
                    }
                }
                left += 1
            }
        }
        return res
    }
}

let matrix = [[1,2,3],[4,5,6],[7,8,9]]
print(Solution().spiralOrder(matrix))

//: [Next](@next)
