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
        graph[v]
    }
    
    /// 获取总节点数 O(1)
    func size() -> Int {
        graph.count
    }
}

// 使用示例
let graph = WeightedDigraph(nodesCount: 3)
graph.addEdge(from: 0, to: 1, weight: 1)
graph.addEdge(from: 1, to: 2, weight: 2)
graph.addEdge(from: 2, to: 0, weight: 3)
graph.addEdge(from: 2, to: 1, weight: 4)

print("Edge 0->1 exists:", graph.hasEdge(from: 0, to: 1)) // true
print("Edge 1->0 exists:", graph.hasEdge(from: 1, to: 0)) // false

print("Neighbors of 2:")
for edge in graph.neighbors(v: 2) {
    print("2 -> \(edge.to), weight: \(edge.weight)")
}

graph.removeEdge(from: 0, to: 1)
print("After removal, 0->1 exists:", graph.hasEdge(from: 0, to: 1)) // false


//: [Next](@next)
