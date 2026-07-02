//: [Previous](@previous)

import Foundation

/*
 给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。

 百度百科中最近公共祖先的定义为："对于有根树 T 的两个节点 p、q，最近公共祖先表示为一个节点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。"



 示例 1：


 输入：root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 输出：3
 解释：节点 5 和节点 1 的最近公共祖先是节点 3 。
 示例 2：


 输入：root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
 输出：5
 解释：节点 5 和节点 4 的最近公共祖先是节点 5 。因为根据定义最近公共祖先节点可以为节点本身。
 示例 3：

 输入：root = [1,2], p = 1, q = 2
 输出：1


 提示：

 树中节点数目在范围 [2, 105] 内。
 -109 <= Node.val <= 109
 所有 Node.val 互不相同 。
 p != q
 p 和 q 均存在于给定的二叉树中。

 LeetCode: https://leetcode.cn/problems/lowest-common-ancestor-of-a-binary-tree/description/
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

    // 存储最终找到的最近公共祖先，用于剪枝优化
    // 注意：Solution 实例有状态，每次查询需要创建新实例
    var lca: TreeNode?

    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        return find(root, p?.val, q?.val)
    }

    // 算法思路（后序遍历）：
    //   1. 若当前节点就是 p 或 q，直接返回（节点本身可以是自己的祖先）
    //   2. 递归在左右子树中查找 p 和 q
    //   3. 若左右子树分别各找到一个，当前节点即为 LCA
    //   4. 若只有一侧找到，说明两者都在该侧，继续向上返回
    // 时间复杂度：O(n)，空间复杂度：O(n)（递归栈深度）
    func find(_ root: TreeNode?, _ pVal: Int?, _ qVal: Int?) -> TreeNode? {
        guard let root else {
            return nil
        }

        // 当前节点命中 p 或 q，直接返回，不再深入（因为题目保证两者都在树中）
        if root.val == pVal || root.val == qVal {
            return root
        }

        // 已找到 LCA，剪枝：不再继续递归
        if lca != nil {
            return nil
        }

        let left = find(root.left, pVal, qVal)
        let right = find(root.right, pVal, qVal)

        // 左右子树各找到一个节点，当前节点就是最近公共祖先
        if left != nil && right != nil {
            lca = root
            return root
        }

        // 返回非空的一侧，继续向上传递
        return left == nil ? right : left
    }
}

// MARK: - 辅助工具

/// 按层序数组（nil 表示空节点）构建二叉树
func buildTree(_ values: [Int?]) -> TreeNode? {
    guard !values.isEmpty, let rootVal = values[0] else { return nil }
    let root = TreeNode(rootVal)
    var queue: [TreeNode] = [root]
    var i = 1
    while i < values.count && !queue.isEmpty {
        let node = queue.removeFirst()
        if i < values.count, let leftVal = values[i] {
            node.left = TreeNode(leftVal)
            queue.append(node.left!)
        }
        i += 1
        if i < values.count, let rightVal = values[i] {
            node.right = TreeNode(rightVal)
            queue.append(node.right!)
        }
        i += 1
    }
    return root
}

/// 在树中按值查找节点（BFS）
func findNode(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root else { return nil }
    if root.val == val { return root }
    return findNode(root.left, val) ?? findNode(root.right, val)
}

// MARK: - 测试
/*
 测试树结构（示例 1 & 2）：
          3
         / \
        5   1
       / \ / \
      6  2 0  8
        / \
       7   4
 */

let treeValues: [Int?] = [3, 5, 1, 6, 2, 0, 8, nil, nil, 7, 4]
let root = buildTree(treeValues)

// 示例 1：p=5, q=1，LCA 在 p 和 q 的上方，期望输出 3
let sol1 = Solution()
let result1 = sol1.lowestCommonAncestor(root, findNode(root, 5), findNode(root, 1))
assert(result1?.val == 3, "示例1失败：期望3，实际\(result1?.val ?? -1)")
print("示例1通过：p=5, q=1 -> LCA =", result1!.val)

// 示例 2：p=5, q=4（4 是 5 的子孙），p 本身即为 LCA，期望输出 5
let sol2 = Solution()
let result2 = sol2.lowestCommonAncestor(root, findNode(root, 5), findNode(root, 4))
assert(result2?.val == 5, "示例2失败：期望5，实际\(result2?.val ?? -1)")
print("示例2通过：p=5, q=4 -> LCA =", result2!.val)

// 示例 3：root=[1,2]，根节点就是 LCA，期望输出 1
let root3 = buildTree([1, 2])
let sol3 = Solution()
let result3 = sol3.lowestCommonAncestor(root3, findNode(root3, 1), findNode(root3, 2))
assert(result3?.val == 1, "示例3失败：期望1，实际\(result3?.val ?? -1)")
print("示例3通过：p=1, q=2 -> LCA =", result3!.val)

// 额外测试：p 和 q 在同一侧子树（7 和 4 都在 5 的子树中），期望 LCA = 2
let sol4 = Solution()
let result4 = sol4.lowestCommonAncestor(root, findNode(root, 7), findNode(root, 4))
assert(result4?.val == 2, "额外测试失败：期望2，实际\(result4?.val ?? -1)")
print("额外测试通过：p=7, q=4 -> LCA =", result4!.val)

print("\n所有测试用例通过 ✓")

//: [Next](@next)
