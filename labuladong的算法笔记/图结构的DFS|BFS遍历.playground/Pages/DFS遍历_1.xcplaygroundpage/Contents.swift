//: [Previous](@previous)

import Foundation

// 加权边结构体
struct Edge {
    let to: Int // 目标节点
    let weight: Int // 边权重
}

enum GraphError: Error {
    case edgeNotFound
}

// 定义图协议
protocol Graph {
    func addEdge(from: Int, to: Int, weight: Int)
    func removeEdge(from: Int, to: Int)
    func hasEdge(from: Int, to: Int) -> Bool
    func weight(from: Int, to: Int) throws -> Int
    func neighbors(v: Int) -> [Edge]
    func size() -> Int
}

class WeightedDigraph: Graph {
    private var graph: [[Edge]]
    
    init(nodesCount n: Int) {
        graph = Array(repeating: [Edge](), count: n)
    }
    
    /// 添加边 O(1)
    func addEdge(from: Int, to: Int, weight: Int) {
        graph[from].append(Edge(to: to, weight: weight))
    }
    
    /// 删除边 O(n)
    func removeEdge(from: Int, to: Int) {
        if let index = graph[from].firstIndex(where: { $0.to == to }) {
            graph[from].remove(at: index)
        }
    }
    
    /// 判断边是否存在 O(n)
    func hasEdge(from: Int, to: Int) -> Bool {
        return graph[from].contains(where: { $0.to == to })
    }
    
    /// 获取边权重 O(n)
    func weight(from: Int, to: Int) throws -> Int {
        guard let edge = graph[from].first(where: { $0.to == to }) else {
            throw GraphError.edgeNotFound
        }
        return edge.weight
    }
    
    /// 获取邻居节点 O(1)
    func neighbors(v: Int) -> [Edge] {
        guard v >= 0 && v < graph.count else { return [] }
        return graph[v]
    }
    
    /// 获取总节点数 O(1)
    func size() -> Int {
        graph.count
    }
}

func traverse(_ graph: Graph, s: Int, visited: inout[Bool]) {
    if s < 0 || s >= graph.size() {
        return
    }
    
    if visited[s] {
        return
    }
    
    // 前序位置: 标记访问并处理节点
    visited[s] = true
    print("Visit node \(s)")
    
    
    // 递归遍历所有邻居
    for neighbor in graph.neighbors(v: s) {
        traverse(graph, s: neighbor.to, visited: &visited)
    }
}

// MARK: - 遍历所有的边
func traverseEdges(graph: Graph, s: Int, visited: inout [[Bool]]) {
    if s < 0 || s >= graph.size() {
        return
    }
    
    for e in graph.neighbors(v: s) {
        /// 遍历过则跳过
        if visited[s][e.to] {
            continue
        }
        
        /// 标记访问的边
        visited[s][e.to] = true
        print("visit edge: \(s) -> \(e.to)")
        traverseEdges(graph: graph, s: e.to, visited: &visited)
    }
}

// 测试代码
func testGraphTraversal() {
    // 创建包含5个节点的图
    let graph = WeightedDigraph(nodesCount: 5)
    
    // 添加边
    graph.addEdge(from: 0, to: 1, weight: 3)
    graph.addEdge(from: 0, to: 2, weight: 2)
    graph.addEdge(from: 1, to: 3, weight: 4)
    graph.addEdge(from: 2, to: 3, weight: 1)
    graph.addEdge(from: 3, to: 4, weight: 5)
    graph.addEdge(from: 4, to: 0, weight: 1) // 创建环
    
    // 测试1: 从节点0开始遍历
    print("===== 测试1: 从节点0开始遍历 =====")
    var visited1 = Array(repeating: false, count: graph.size())
    traverse(graph, s: 0, visited: &visited1)
    
    // 测试2: 从节点3开始遍历
    print("\n===== 测试2: 从节点3开始遍历 =====")
    var visited2 = Array(repeating: false, count: graph.size())
    traverse(graph, s: 3, visited: &visited2)
    
    // 测试3: 无效节点
    print("\n===== 测试3: 无效节点 (5) =====")
    var visited3 = Array(repeating: false, count: graph.size())
    traverse(graph, s: 5, visited: &visited3)  // 应该没有输出
    
    // 测试4: 孤立节点
    print("\n===== 测试4: 孤立节点 =====")
    let graph2 = WeightedDigraph(nodesCount: 3)
    graph2.addEdge(from: 0, to: 1, weight: 1)
    var visited4 = Array(repeating: false, count: graph2.size())
    traverse(graph2, s: 2, visited: &visited4)
    
    // 测试5: 图操作功能
    print("\n===== 测试5: 图操作功能 =====")
    let graph3 = WeightedDigraph(nodesCount: 2)
    graph3.addEdge(from: 0, to: 1, weight: 10)
    
    // 测试边是否存在
    print("边 0->1 存在: \(graph3.hasEdge(from: 0, to: 1))") // true
    print("边 1->0 存在: \(graph3.hasEdge(from: 1, to: 0))") // false
    
    // 测试获取权重
    do {
        let weight = try graph3.weight(from: 0, to: 1)
        print("边 0->1 权重: \(weight)") // 10
    } catch {
        print("权重获取失败: \(error)")
    }
    
    // 测试删除边
    graph3.removeEdge(from: 0, to: 1)
    print("删除后边 0->1 存在: \(graph3.hasEdge(from: 0, to: 1))") // false
}

// 执行测试
testGraphTraversal()

//: [Next](@next)
