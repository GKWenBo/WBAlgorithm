//: [Previous](@previous)

import Foundation

class Vertex {
    let id: Int
    var neighbors: [Vertex]
    
    init(id: Int, neighbors: [Vertex] = []) {
        self.id = id
        self.neighbors = neighbors
    }
}

// MARK: - DFS遍历
func dfsTraverse(_ vertex: Vertex?, visited: inout Set<Int>) {
    guard let vertex else { return }
    
    guard !visited.contains(vertex.id) else { return } /// 防止死循环
    
    /// 前序位置
    visited.insert(vertex.id)
    print("DFS visit \(vertex.id)")
    
    /// 递归遍历邻居
    for neighbor in vertex.neighbors {
        dfsTraverse(neighbor, visited: &visited)
    }
}

// MARK: - 遍历所有的边（二维visited 数组）
func traverseEdges(start: Vertex?, visited: inout [[Bool]]) {
    guard let s = start else { return }
    
    for neighbor in s.neighbors {
        /// 检查边是否已访问
        if visited[s.id][neighbor.id] {
            continue
        }
        
        /// 标记并访问边
        visited[s.id][neighbor.id] = true
        print("访问边：\(s.id) -> \(neighbor.id)")
        
        /// 递归遍历邻居
        traverseEdges(start: neighbor, visited: &visited)
    }
}

// 测试代码
//func testGraphTraversal() {
//    // 创建测试节点
//    let node0 = Vertex(id: 0)
//    let node1 = Vertex(id: 1)
//    let node2 = Vertex(id: 2)
//    let node3 = Vertex(id: 3)
//    
//    // 构建图结构
//    node0.neighbors = [node1, node2]
//    node1.neighbors = [node2]
//    node2.neighbors = [node0, node3]  // 包含环：0->2->0
//    node3.neighbors = [node2]         // 包含环：3->2->3
//    
//    // 测试遍历
//    var visited = Set<Int>()
//    print("Traverse from node0:")
//    dfsTraverse(node0, visited: &visited)
//    
//    // 测试孤立节点
//    let isolatedNode = Vertex(id: 99)
//    var newVisited = Set<Int>()
//    print("\nTraverse isolated node:")
//    dfsTraverse(isolatedNode, visited: &newVisited)
//    
//    // 测试空节点
//    var emptyVisited = Set<Int>()
//    print("\nTraverse nil node:")
//    dfsTraverse(nil, visited: &emptyVisited)
//}

func testGraphTraversal() {
    // 1. 创建图节点
    let v0 = Vertex(id: 0)
    let v1 = Vertex(id: 1)
    let v2 = Vertex(id: 2)
    let v3 = Vertex(id: 3)
    
    // 2. 构建图结构
    v0.neighbors = [v1, v2]
    v1.neighbors = [v0, v3] // 环状结构
    v2.neighbors = [v0, v3]
    v3.neighbors = [v1, v2]
    
    // 3. 初始化 visited 数组 (假设最大节点ID=3)
    var visited = Array(
        repeating: Array(repeating: false, count: 4),
        count: 4
    )
    
    // 4. 从 v0 开始遍历
    print("===== 开始遍历 =====")
    traverseEdges(start: v0, visited: &visited)
    print("===== 遍历结束 =====")
}

// 执行测试
testGraphTraversal()

//: [Next](@next)
