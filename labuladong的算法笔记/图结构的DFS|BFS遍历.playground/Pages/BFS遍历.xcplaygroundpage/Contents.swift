//: [Previous](@previous)

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

func bfs(graph: Graph, s: Int) {
    var visited: [Bool] = Array(repeating: false, count: graph.size)
    var queue: [Int] = []
    
    queue.append(s)
    visited[s] = true
    
    while !queue.isEmpty {
        let cur = queue.removeFirst()
        print("visit \(cur)")
        
        for e in graph.neighbors(of: cur) {
            if visited[e.to] {
                continue
            }
            visited[e.to] = true
            queue.append(e.to)
        }
    }
}

// MARK: - 写法二，记录遍历步数
func bfs1(graph: Graph, s: Int) {
    var visited: [Bool] = Array(repeating: false, count: graph.size)
    var queue: [Int] = []
    
    queue.append(s)
    visited[s] = true
    
    // 记录从s开始走到当前节点的步数
    var step = 0
    
    while !queue.isEmpty {
        let size = queue.count
        for i in 0..<size {
            let cur = queue.removeFirst()
            print("visit \(cur) at step \(step)")
            
            for e in graph.neighbors(of: cur) {
                if visited[e.to] {
                    continue
                }
                visited[e.to] = true
                queue.append(e.to)
            }
        }
        step += 1
    }
}

// MARK: - 写法三
// 图结构的 BFS 遍历，从节点 s 开始进行 BFS，且记录遍历步数（从起点 s 到当前节点的边的条数）
// 每个节点自行维护 State 类，记录从 s 走来的遍历步数
struct State {
    
    /// 当前节点id
    var node: Int
    
    /// 从七点s到当前节点的遍历步数
    var step: Int
    
    init(node: Int, step: Int) {
        self.node = node
        self.step = step
    }
}

func bfs2(graph: Graph, s: Int) {
    var visited: [Bool] = Array(repeating: false, count: graph.size)
    var queue: [State] = []
    
    queue.append(State(node: s, step: 0))
    visited[s] = true
    
    while !queue.isEmpty {
        let state = queue.removeFirst()
        let cur = state.node
        let step = state.step
        print("visit \(cur) with step\(step)")
        for e in graph.neighbors(of: cur) {
            if visited[e.to] {
                continue
            }
            visited[e.to] = true
            queue.append(State(node: e.to, step: step + 1))
        }
    }
}

// 测试BFS图遍历
func testBFS() {
    // ===== 测试用例1：简单有向图（无环）=====
    print("\n===== 测试用例1：简单有向图（无环）=====")
    let graph1 = Graph(size: 4)
    graph1.addEdge(from: 0, to: 1)
    graph1.addEdge(from: 0, to: 2)
    graph1.addEdge(from: 1, to: 3)
    graph1.addEdge(from: 2, to: 3)
    
    print("从节点0开始BFS遍历：")
    bfs1(graph: graph1, s: 0)
    // 预期：0 -> 1 -> 2 -> 3 或 0 -> 2 -> 1 -> 3（取决于邻居顺序）
    
    // ===== 测试用例2：有环图 =====
    print("\n===== 测试用例2：有环图 =====")
    let graph2 = Graph(size: 4)
    graph2.addEdge(from: 0, to: 1)
    graph2.addEdge(from: 1, to: 2)
    graph2.addEdge(from: 2, to: 3)
    graph2.addEdge(from: 3, to: 0)  // 形成环
    
    print("从节点0开始BFS遍历：")
    bfs1(graph: graph2, s: 0)
    // 预期：0 -> 1 -> 2 -> 3（不会无限循环）
    
    // ===== 测试用例3：不连通图 =====
    print("\n===== 测试用例3：不连通图 =====")
    let graph3 = Graph(size: 5)
    graph3.addEdge(from: 0, to: 1)
    graph3.addEdge(from: 1, to: 2)
    graph3.addEdge(from: 3, to: 4)  // 另一个连通分量
    
    print("从节点0开始BFS遍历：")
    bfs1(graph: graph3, s: 0)
    // 预期：只访问0,1,2
    
    print("\n从节点3开始BFS遍历：")
    bfs1(graph: graph3, s: 3)
    // 预期：只访问3,4
    
    // ===== 测试用例4：单节点图 =====
    print("\n===== 测试用例4：单节点图 =====")
    let graph4 = Graph(size: 1)
    print("从节点0开始BFS遍历：")
    bfs1(graph: graph4, s: 0)
    // 预期：0
    
    // ===== 测试用例5：空图 =====
    print("\n===== 测试用例5：空图 =====")
    let graph5 = Graph(size: 0)
    print("尝试在空图上执行BFS：")
    bfs1(graph: graph5, s: 0)  // 应安全处理
    // 预期：无输出
}

// 执行测试
testBFS()

//: [Next](@next)
