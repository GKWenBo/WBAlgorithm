//: [Previous](@previous)

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


/*
 使用DFS递归遍历解法
 */
class Solution {
    
    var minDepth = Int.max
    var currentDepth = 0
    
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 }
        traverse(root)
        return minDepth
    }
    
    func traverse(_ root: TreeNode?) {
        guard let root else { return }
        
        /// 前序位置进入节点时，增加当前深度
        currentDepth += 1
        
        /// 如果当前节点是叶子节点，更新最小深度
        if root.left == nil && root.right == nil {
            minDepth = min(currentDepth, minDepth)
        }
        
        traverse(root.left)
        traverse(root.right)
        
        /// 后序位置离开节点时，减少当前深度
        currentDepth -= 1
    }
}

/*
 使用BFS解法
 */
class Solution1 {
    
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 }
        
        var queue: [TreeNode] = []
        
        queue.append(root)
        /// root本身就是一层，depth初始化为1
        var depth = 1
        while !queue.isEmpty {
            let size = queue.count
            
            /// 遍历当前层的节点
            for i in 0..<size {
                let cur = queue.removeFirst()
                /// 判断是否达到叶子节点
                if cur.left == nil && cur.right == nil {
                    return depth
                }
                
                if let left = cur.left {
                    queue.append(left)
                }
                
                if let right = cur.right {
                    queue.append(right)
                }
            }
            /// 增加步数
            depth += 1
        }
        return depth
    }
}

//: [Next](@next)
