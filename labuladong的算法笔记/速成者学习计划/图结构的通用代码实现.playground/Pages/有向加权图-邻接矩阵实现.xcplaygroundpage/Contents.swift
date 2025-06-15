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

// 测试代码
func testWeightedDigraph() {
    var graph = WeightedDigraph(n: 3)
    graph.addEdge(from: 0, to: 1, weight: 1)
    graph.addEdge(from: 1, to: 2, weight: 2)
    graph.addEdge(from: 2, to: 0, weight: 3)
    graph.addEdge(from: 2, to: 1, weight: 4)
    
    print(graph.hasEdge(from: 0, to: 1)) // true
    print(graph.hasEdge(from: 1, to: 0)) // false
    
    for edge in graph.neighbors(2) {
        print("2 -> \(edge.to), weight: \(edge.weight)")
    }
    // 输出:
    // 2 -> 0, weight: 3
    // 2 -> 1, weight: 4
    
    graph.removeEdge(from: 0, to: 1)
    print(graph.hasEdge(from: 0, to: 1)) // false
}

// 执行测试
testWeightedDigraph()
