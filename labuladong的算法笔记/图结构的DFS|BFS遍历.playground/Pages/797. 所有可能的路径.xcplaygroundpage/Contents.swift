//: [Previous](@previous)

import Foundation

/*
 LeetCode：https://leetcode.cn/problems/all-paths-from-source-to-target/description/
 
 给你一个有 n 个节点的 有向无环图（DAG），请你找出所有从节点 0 到节点 n-1 的路径并输出（不要求按特定顺序）

  graph[i] 是一个从节点 i 可以访问的所有节点的列表（即从节点 i 到节点 graph[i][j]存在一条有向边）。


 示例 1：


 输入：graph = [[1,2],[3],[3],[]]
 输出：[[0,1,3],[0,2,3]]
 解释：有两条路径 0 -> 1 -> 3 和 0 -> 2 -> 3
 示例 2：



 输入：graph = [[4,3,1],[3,2,4],[3],[4],[]]
 输出：[[0,4],[0,3,4],[0,1,3,4],[0,1,2,3,4],[0,1,4]]
  

 提示：

 n == graph.length
 2 <= n <= 15
 0 <= graph[i][j] < n
 graph[i][j] != i（即不存在自环）
 graph[i] 中的所有元素 互不相同
 保证输入为 有向无环图（DAG）
 */

class Solution {
    
    var res: [[Int]] = []
    var path: [Int] = []
    
    func allPathsSourceTarget(_ graph: [[Int]]) -> [[Int]] {
        traverse(graph: graph, s: 0)
        return res
    }
    
    func traverse(graph: [[Int]], s: Int) {
        /// 添加节点s到路径
        path.append(s)
        
        let n = graph.count
        
        if s == n - 1 {
            /// 到达终点
            res.append(path)
            path.removeLast()
            return
        }
        
        /// 递归遍历相邻节点
        for v in graph[s] {
            traverse(graph: graph, s: v)
        }
        
        /// 从路径移除节点s
        path.removeLast()
    }
}

let graph = [[1,2],[3],[3],[]]
let graph1 = [[4,3,1],[3,2,4],[3],[4],[]]
let solution = Solution()

print(solution.allPathsSourceTarget(graph))
print(solution.allPathsSourceTarget(graph1))

//: [Next](@next)
