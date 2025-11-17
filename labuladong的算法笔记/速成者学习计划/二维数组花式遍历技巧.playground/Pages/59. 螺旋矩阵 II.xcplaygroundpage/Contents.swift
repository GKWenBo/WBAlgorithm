//: [Previous](@previous)

import Foundation

/*
 给你一个正整数 n ，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的 n x n 正方形矩阵 matrix 。

  

 示例 1：


 输入：n = 3
 输出：[[1,2,3],[8,9,4],[7,6,5]]
 示例 2：

 输入：n = 1
 输出：[[1]]
  

 提示：

 1 <= n <= 20
  
LeetCode：https://leetcode.cn/problems/spiral-matrix-ii/description/
 */

class Solution {
    func generateMatrix(_ n: Int) -> [[Int]] {
        var matrix: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
        
        var upper = 0
        var lower = n - 1
        var left = 0
        var right = n - 1
        var num = 1
        while num <= n * n {
            
            // 从左向右
            if upper <= lower {
                if left <= right {
                    for j in left...right {
                        matrix[upper][j] = num
                        num += 1
                    }
                }
                upper += 1
            }
            
            // 从上向下
            if left <= right {
                if upper <= lower {
                    for i in upper...lower {
                        matrix[i][right] = num
                        num += 1
                    }
                }
                right -= 1
            }
            
            // 从右向左
            if upper <= lower {
                if left <= right {
                    for j in stride(from: right, through: left, by: -1) {
                        matrix[lower][j] = num
                        num += 1
                    }
                }
                lower -= 1
            }
            
            // 从下向上
            if left <= right {
                if upper <= lower {
                    for i in stride(from: lower, through: upper, by: -1) {
                        matrix[i][left] = num
                        num += 1
                    }
                }
                left += 1
            }
        }
        return matrix
    }
}

print(Solution().generateMatrix(3))

//: [Next](@next)
