//: [Previous](@previous)

import Foundation

// 加权有向图的通用实现（邻接矩阵）
struct WeightedDigraph {
    // 边结构体
    struct Edge {
        let to: Int
        let weight: Int
    }
    
    // 邻接矩阵存储权重，0 表示没有连接
    private var matrix: [[Int]]
    
    // 初始化 n 个节点的图
    init(n: Int) {
        matrix = Array(repeating: Array(repeating: 0, count: n), count: n)
    }
    
    // 添加带权重的有向边（复杂度 O(1)）
    mutating func addEdge(from: Int, to: Int, weight: Int) {
        matrix[from][to] = weight
    }
    
    // 删除有向边（复杂度 O(1)）
    mutating func removeEdge(from: Int, to: Int) {
        matrix[from][to] = 0
    }
    
    // 检查边是否存在（复杂度 O(1)）
    func hasEdge(from: Int, to: Int) -> Bool {
        return matrix[from][to] != 0
    }
    
    // 获取边的权重（复杂度 O(1)）
    func weight(from: Int, to: Int) -> Int {
        return matrix[from][to]
    }
    
    // 获取节点的所有邻居（复杂度 O(V)）
    func neighbors(_ v: Int) -> [Edge] {
        var res: [Edge] = []
        for (to, weight) in matrix[v].enumerated() {
            if weight > 0 {
                res.append(Edge(to: to, weight: weight))
            }
        }
        return res
    }
}

// 无向加权图的通用实现
struct WeightedUndigraph {
    
    var graph: WeightedDigraph
    
    init(n: Int) {
        graph = WeightedDigraph(n: n)
    }
    
    // 增，添加一条带权重的无向边
    mutating func addEdge(from: Int, to: Int, weight: Int) {
        graph.addEdge(from: from, to: to, weight: weight)
        graph.addEdge(from: to, to: from, weight: weight)
    }
    
    // 删，删除一条无向边
    mutating func removeEdge(from: Int, to: Int) {
        graph.removeEdge(from: from, to: to)
        graph.removeEdge(from: to, to: from)
    }
    
    // 查，判断两个节点是否相邻
    func hasEdge(from: Int, to: Int) -> Bool {
        return graph.hasEdge(from: from, to: to)
    }
    
    // 查，返回一条边的权重
    func weight(from: Int, to: Int) -> Int {
        return graph.weight(from: from, to: to)
    }
    
    // 查，返回某个节点的所有邻居节点
    func neighbors(_ v: Int) -> [WeightedDigraph.Edge] {
        return graph.neighbors(v)
    }
}

// 测试无向加权图
func testWeightedUndigraph() {
    print("=== 开始测试无向加权图 ===")
    
    // 创建4个节点的无向图
    var graph = WeightedUndigraph(n: 4)
    
    // 添加边
    graph.addEdge(from: 0, to: 1, weight: 5)
    graph.addEdge(from: 1, to: 2, weight: 3)
    graph.addEdge(from: 2, to: 3, weight: 7)
    graph.addEdge(from: 0, to: 3, weight: 2)
    
    // 测试1: 检查边是否存在（对称性）
    print("测试1: 边存在性检查")
    print("0-1 存在: \(graph.hasEdge(from: 0, to: 1))") // true
    print("1-0 存在: \(graph.hasEdge(from: 1, to: 0))") // true
    print("0-2 不存在: \(graph.hasEdge(from: 0, to: 2))") // false
    print("3-0 存在: \(graph.hasEdge(from: 3, to: 0))") // true
    
    // 测试2: 检查权重（对称性）
    print("\n测试2: 权重检查")
    print("0-1 权重: \(graph.weight(from: 0, to: 1))") // 5
    print("1-0 权重: \(graph.weight(from: 1, to: 0))") // 5
    print("2-3 权重: \(graph.weight(from: 2, to: 3))") // 7
    
    // 测试3: 检查邻居节点
    print("\n测试3: 邻居节点检查")
    print("节点0的邻居: \(graph.neighbors(0).map { "\($0.to)(\($0.weight))" })") // [1(5), 3(2)]
    print("节点1的邻居: \(graph.neighbors(1).map { "\($0.to)(\($0.weight))" })") // [0(5), 2(3)]
    print("节点2的邻居: \(graph.neighbors(2).map { "\($0.to)(\($0.weight))" })") // [1(3), 3(7)]
    print("节点3的邻居: \(graph.neighbors(3).map { "\($0.to)(\($0.weight))" })") // [2(7), 0(2)]
    
    // 测试4: 删除边
    print("\n测试4: 删除边")
    graph.removeEdge(from: 0, to: 3)
    print("删除0-3边后，0-3存在: \(graph.hasEdge(from: 0, to: 3))") // false
    print("删除0-3边后，3-0存在: \(graph.hasEdge(from: 3, to: 0))") // false
    print("节点0的邻居: \(graph.neighbors(0).map { "\($0.to)(\($0.weight))" })") // [1(5)]
    print("节点3的邻居: \(graph.neighbors(3).map { "\($0.to)(\($0.weight))" })") // [2(7)]
    
    // 测试5: 添加重复边（覆盖权重）
    print("\n测试5: 更新边权重")
    graph.addEdge(from: 1, to: 2, weight: 8) // 更新权重
    print("1-2新权重: \(graph.weight(from: 1, to: 2))") // 8
    print("2-1新权重: \(graph.weight(from: 2, to: 1))") // 8
    print("节点1的邻居: \(graph.neighbors(1).map { "\($0.to)(\($0.weight))" })") // [0(5), 2(8)]
    print("节点2的邻居: \(graph.neighbors(2).map { "\($0.to)(\($0.weight))" })") // [1(8), 3(7)]
    
    // 测试6: 添加自环边
    print("\n测试6: 自环边")
    graph.addEdge(from: 0, to: 0, weight: 4)
    print("0-0存在: \(graph.hasEdge(from: 0, to: 0))") // true
    print("0-0权重: \(graph.weight(from: 0, to: 0))") // 4
    print("节点0的邻居: \(graph.neighbors(0).map { "\($0.to)(\($0.weight))" })") // [0(4), 1(5)]
    
    print("=== 测试完成 ===")
}

// 执行测试
testWeightedUndigraph()

//: [Next](@next)
