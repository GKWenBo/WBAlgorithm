//: [Previous](@previous)

import Foundation

/*
 给定一个二叉树的 根节点 root，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。



 示例 1：

 输入：root = [1,2,3,null,5,null,4]

 输出：[1,3,4]

 解释：



 示例 2：

 输入：root = [1,2,3,4,null,null,null,5]

 输出：[1,3,4,5]

 解释：



 示例 3：

 输入：root = [1,null,3]

 输出：[1,3]

 示例 4：

 输入：root = []

 输出：[]



 提示:

 二叉树的节点个数的范围是 [0,100]
 -100 <= Node.val <= 100

 LeetCode: https://leetcode.cn/problems/binary-tree-right-side-view/description/
 */

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

class Solution {
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root else { return [] }

        // BFS 层序遍历：每层优先将右子节点入队，保证队首始终是当前层最右节点
        var queue = [root]
        var res: [Int] = []
        while !queue.isEmpty {
            let size = queue.count
            // 队首即为本层最右侧可见节点（右子节点先于左子节点入队）
            let last = queue.first

            for _ in 0..<size {
                let node = queue.removeFirst()
                // 右子节点先入队，下一层的队首仍保持最右节点
                if let right = node.right {
                    queue.append(right)
                }
                if let left = node.left {
                    queue.append(left)
                }
            }

            if let last {
                res.append(last.val)
            }
        }
        return res
    }
}

// MARK: - 测试辅助

/// 按层序数组（nil 表示空节点）构建二叉树
func buildTree(_ vals: [Int?]) -> TreeNode? {
    guard !vals.isEmpty, let rootVal = vals[0] else { return nil }
    let root = TreeNode(rootVal)
    var queue: [TreeNode] = [root]
    var i = 1
    while i < vals.count && !queue.isEmpty {
        let node = queue.removeFirst()
        if i < vals.count {
            if let v = vals[i] {
                node.left = TreeNode(v)
                queue.append(node.left!)
            }
            i += 1
        }
        if i < vals.count {
            if let v = vals[i] {
                node.right = TreeNode(v)
                queue.append(node.right!)
            }
            i += 1
        }
    }
    return root
}

// MARK: - 测试

let solution = Solution()
var passed = 0
var failed = 0

func check(_ label: String, _ got: [Int], _ expected: [Int]) {
    if got == expected {
        print("✅ \(label): \(got)")
        passed += 1
    } else {
        print("❌ \(label): got \(got), expected \(expected)")
        failed += 1
    }
}

// 示例 1: [1,2,3,null,5,null,4] → [1,3,4]
check("示例1", solution.rightSideView(buildTree([1, 2, 3, nil, 5, nil, 4])), [1, 3, 4])

// 示例 2: [1,2,3,4,null,null,null,5] → [1,3,4,5]
check("示例2", solution.rightSideView(buildTree([1, 2, 3, 4, nil, nil, nil, 5])), [1, 3, 4, 5])

// 示例 3: [1,null,3] → [1,3]
check("示例3", solution.rightSideView(buildTree([1, nil, 3])), [1, 3])

// 示例 4: 空树 → []
check("示例4（空树）", solution.rightSideView(nil), [])

// 单节点
check("单节点", solution.rightSideView(buildTree([1])), [1])

// 只有左子树：右视图应返回每层唯一节点
check("纯左子树", solution.rightSideView(buildTree([1, 2, nil, 3])), [1, 2, 3])

print("\n共 \(passed + failed) 个测试，通过 \(passed)，失败 \(failed)")

//: [Next](@next)
