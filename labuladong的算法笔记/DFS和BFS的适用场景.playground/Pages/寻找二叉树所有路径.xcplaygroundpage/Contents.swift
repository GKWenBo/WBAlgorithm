import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


func findAllPathsDFS(_ root: TreeNode?) -> [[Int]] {
    var res: [[Int]] = []
    var path: [Int] = []
    
    func traverse(_ root: TreeNode?) {
        guard let root else {
            return
        }
        /// 前序位置将节点加入path数组
        path.append(root.val)
        
        /// 遇到叶子节点，添加路径
        if root.left == nil && root.right == nil {
            res.append(path)
        }
        
        traverse(root.left)
        traverse(root.right)
        
        /// 后序位置移除当前值
        path.removeLast()
    }
    
    traverse(root)
    return res
}

struct State {
    let node: TreeNode
    let path: [Int]
}

func findAllPathsBFS(_ root: TreeNode?) -> [[Int]] {
    guard let root else { return [] }
    var res: [[Int]] = []
    
    var queue: [State] = []
    /// 添加根节点到队列
    queue.append(State(node: root, path: [root.val]))
    while !queue.isEmpty {
        let current = queue.removeFirst()
        let node = current.node
        let path = current.path
        
        /// 遇到叶子节点，保存路径
        if node.left == nil && node.right == nil {
            res.append(path)
            continue
        }
        
        /// 处理左子节点
        if let left = node.left {
            let newPath = path + [left.val]
            queue.append(State(node: left, path: newPath))
        }
        
        /// 处理右子节点
        if let right = node.right {
            let newPath = path + [right.val]
            queue.append(State(node: right, path: newPath))
        }
    }
    return res
}


// 示例用法：
let root = TreeNode(10,
                    TreeNode(5,
                             TreeNode(3,
                                      TreeNode(3),
                                      TreeNode(-2)),
                             TreeNode(2,
                                      nil,
                                      TreeNode(1))),
                    TreeNode(-3,
                             nil,
                             TreeNode(6)))
print(findAllPathsDFS(root))
// 输出：[[10,5,3,3], [10,5,3,-2], [10,5,2,1], [10,-3,6]]
