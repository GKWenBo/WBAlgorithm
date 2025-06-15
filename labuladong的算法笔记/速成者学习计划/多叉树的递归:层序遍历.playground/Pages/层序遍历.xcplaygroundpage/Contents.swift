import Foundation

class Node {
    var val: Int
    var children: [Node]
    
    init(val: Int, children: [Node]) {
        self.val = val
        self.children = children
    }
}


/// 写法一，无法记录层数
func levelOrderTraverse(_ root: Node?) {
    guard let root else {
        return
    }
    var queue: [Node] = []
    queue.append(root)
    while !queue.isEmpty {
        /// 访问qur队列
        let cur = queue.removeFirst()
        print(cur.val)
        
        /// 将cur的所有子节点加入队列
        for node in cur.children {
            queue.append(node)
        }
    }
}


/// 写法二，可记录层数
/// - Parameter root: 多叉树根节点
func levelOrderTraverse1(_ root: Node?) {
    guard let root else {
        return
    }
    var queue: [Node] = []
    queue.append(root)
    var depth = 1
    while !queue.isEmpty {
        /// 访问qur队列
        let cur = queue.removeFirst()
        print("depth = \(depth), val = \(cur.val)")
        
        /// 将cur的所有子节点加入队列
        for node in cur.children {
            queue.append(node)
        }
        
        depth += 1
    }
}


class State {
    var node: Node
    var depth: Int
    
    init(node: Node, depth: Int) {
        self.node = node
        self.depth = depth
    }
}

func levelOrderTraverse2(_ root: Node?) {
    guard let root else { return }
    
    var queue: [State] = []
    /// 记录当前遍历层数，根节点视为第1层
    queue.append(State(node: root, depth: 1))
    while !queue.isEmpty {
        let state = queue.removeFirst()
        let node = state.node
        let depath = state.depth
        /// 访问cur节点，同时知道它所在的层数
        print("depth = \(depath), val = \(node.val)")
        
        for node in node.children {
            queue.append(State(node: node, depth: depath + 1))
        }
    }
}
