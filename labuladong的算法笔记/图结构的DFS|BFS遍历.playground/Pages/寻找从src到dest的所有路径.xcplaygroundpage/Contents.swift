import Foundation

struct Edge {
    let to: Int
}

class Graph {
    private var adjacencyList: [[Edge]]
    let size: Int
    
    init(size: Int) {
        self.adjacencyList = Array(repeating: [], count: size)
        self.size = size
    }
    
    func addEdge(from: Int, to: Int) {
        guard from >= 0 && from < size && to >= 0 && to < size else { return }
        adjacencyList[from].append(Edge(to: to))
    }
    
    func neighbors(of node: Int) -> [Edge] {
        guard node >= 0 && node < size else { return [] }
        return adjacencyList[node]
    }
}


func findAllPaths(graph: Graph, src: Int, dest: Int) {
    guard src >= 0 && src < graph.size else {
        return
    }
    var onPath = [Bool](repeating: false, count: graph.size)
    var path = [Int]()
    
    func traverse(_ current: Int) {
        /// 避免环路和越界
        guard current >= 0 && current < graph.size else { return }
        
        guard !onPath[current] else { return }
        
        onPath[current] = true
        
        path.append(current)
        
        /// 找到路径
        if current == dest {
            print("找到路径：\(path)")
        }
        
        for e in graph.neighbors(of: current) {
            traverse(e.to)
        }
        
        path.removeLast()
        onPath[current] = false
    }
    
    traverse(src)
}

// 测试代码
func testGraphPaths() {
    // 创建图（5个节点）
    let graph = Graph(size: 5)
    
    // 添加边
    graph.addEdge(from: 0, to: 1)
    graph.addEdge(from: 0, to: 2)
    graph.addEdge(from: 1, to: 3)
    graph.addEdge(from: 2, to: 3)
    graph.addEdge(from: 3, to: 4)
    graph.addEdge(from: 1, to: 4) // 添加一条直达路径
    graph.addEdge(from: 4, to: 0) // 添加环路测试
    
    print("===== 从节点0到节点4的所有路径 =====")
    findAllPaths(graph: graph, src: 0, dest: 4)
}

// 执行测试
testGraphPaths()
