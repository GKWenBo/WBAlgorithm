//: [Previous](@previous)

import Foundation

/*
 给你一个 m 行 n 列的二维网格 grid 和一个整数 k。你需要将 grid 迁移 k 次。

 每次「迁移」操作将会引发下述活动：

 位于 grid[i][j]（j < n - 1）的元素将会移动到 grid[i][j + 1]。
 位于 grid[i][n - 1] 的元素将会移动到 grid[i + 1][0]。
 位于 grid[m - 1][n - 1] 的元素将会移动到 grid[0][0]。
 请你返回 k 次迁移操作后最终得到的 二维网格。

  

 示例 1：



 输入：grid = [[1,2,3],[4,5,6],[7,8,9]], k = 1
 输出：[[9,1,2],[3,4,5],[6,7,8]]
 示例 2：



 输入：grid = [[3,8,1,9],[19,7,2,5],[4,6,11,10],[12,0,21,13]], k = 4
 输出：[[12,0,21,13],[3,8,1,9],[19,7,2,5],[4,6,11,10]]
 示例 3：

 输入：grid = [[1,2,3],[4,5,6],[7,8,9]], k = 9
 输出：[[1,2,3],[4,5,6],[7,8,9]]
  

 提示：

 m == grid.length
 n == grid[i].length
 1 <= m <= 50
 1 <= n <= 50
 -1000 <= grid[i][j] <= 1000
 0 <= k <= 100
 
 LeetCode：https://leetcode.cn/problems/shift-2d-grid/description/
 */

class Solution {
    
    func shiftGrid(_ grid: [[Int]], _ k: Int) -> [[Int]] {
        /// 把二维 grid 抽象成一维数组
        let row = grid.count
        let column = grid[0].count
        let mn = row * column
        var k = k % mn
        
        var grid = grid
        /// 先把最后 k 个数翻转
        reverse(&grid, i: mn - k, j: mn - 1)
        /// 然后把前 mn - k 个数翻转
        reverse(&grid, i: 0, j: mn - k - 1)
        /// 最后把整体翻转
        reverse(&grid, i: 0, j: mn - 1)
        
        var res: [[Int]] = []
        for row in grid {
            var rowList: [Int] = []
            for e in row {
                rowList.append(e)
            }
            res.append(rowList)
        }
        return res
    }
    
    /// 通过一维数组的索引访问二维数组的元素
    func get(_ grid: [[Int]], index: Int) -> Int {
        let column = grid[0].count
        let i = index / column
        let j = index % column
        return grid[i][j]
    }
    
    /// 通过一维数组的索引修改二维数组的元素
    func set(_ grid: inout [[Int]], index: Int, val: Int) {
        let column = grid[0].count
        let i = index / column
        let j = index % column
        grid[i][j] = val
    }
    
    /// 翻转一维数组的索引区间元素
    func reverse(_ grid: inout [[Int]], i: Int, j: Int) {
        var i = i
        var j = j
        while i < j {
            let temp = get(grid, index: i)
            set(&grid, index: i, val: get(grid, index: j))
            set(&grid, index: j, val: temp)
            i += 1
            j -= 1
        }
    }
}

let grid = [[1,2,3],[4,5,6],[7,8,9]]
print(Solution().shiftGrid(grid, 1))

//: [Next](@next)
