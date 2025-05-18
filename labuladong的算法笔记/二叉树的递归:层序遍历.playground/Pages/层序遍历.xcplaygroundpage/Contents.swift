//: [Previous](@previous)

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// 写法1
func levelOrderTraverse(root: TreeNode?) {
    guard let root else {
        return
    }
    var queue: [TreeNode] = []
    queue.append(root)
    while !queue.isEmpty {
        let cur = queue.removeFirst()
        // 访问 cur 节点
        print(cur.val)
        
        if let left = cur.left {
            queue.append(left)
        }
        
        if let right = cur.right {
            queue.append(right)
        }
    }
}

// 写法2 计算二叉树最小深度
func levelOrderTraverse1(root: TreeNode?) {
    guard let root else {
        return
    }
    var queue: [TreeNode] = []
    queue.append(root)
    
    var depth = 1
    while !queue.isEmpty {
        let size = queue.count
        for i in 0..<size {
            let cur = queue.removeFirst()
            
            print("depth = \(depth), var = \(cur.val)")
            
            if let left = cur.left {
                queue.append(left)
            }
            
            if let right = cur.right {
                queue.append(right)
            }
        }
        
        depth += 1
    }
}

class State {
    var node: TreeNode
    var depth: Int = 1
    
    init(node: TreeNode, depth: Int = 1) {
        self.node = node
        self.depth = depth
    }
}

/// 写法3
func levelOrderTraverse2(root: TreeNode?) {
    guard let root else { return }
    
    var queue: [State] = []
    /// 根节点的路径权重和是 1
    queue.append(State(node: root, depth: 1))
    while !queue.isEmpty {
        let cur = queue.removeFirst()
        let depth = cur.depth
        /// 访问 cur 节点，同时知道它的路径权重和
        print("depth = \(depth), val = \(cur.node.val)")
        
        /// 把 cur 的左右子节点加入队列
        if let left = cur.node.left {
            queue.append(State(node: left, depth: depth + 1))
        }
        if let right = cur.node.right {
            queue.append(State(node: right, depth: depth + 1))
        }
    }
}

// 构造测试树
let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left?.left = TreeNode(4)

// 执行层序遍历
levelOrderTraverse2(root: root)

// 预期正确输出：1 2 3 4
// 当前错误输出：1 2 3 2 3 2 3 ...（无限循环）


//: [Next](@next)
