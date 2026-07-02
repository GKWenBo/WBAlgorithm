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
 给你二叉树的根节点 root ，返回其节点值的 锯齿形层序遍历 。（即先从左往右，再从右往左进行下一层遍历，以此类推，层与层之间交替进行）。

 示例 1：


 输入：root = [3,9,20,null,null,15,7]
 输出：[[3],[20,9],[15,7]]
 示例 2：

 输入：root = [1]
 输出：[[1]]
 示例 3：

 输入：root = []
 输出：[]


 提示：

 树中节点数目在范围 [0, 2000] 内
 -100 <= Node.val <= 100

 LeetCode: https://leetcode.cn/problems/binary-tree-zigzag-level-order-traversal/description/

 思路：BFS 层序遍历 + 方向标志
 - 使用队列按层处理节点，每层收集所有节点值
 - 用 reverse 标志控制当前层是否需要翻转
 - 奇数层（第1、3、5...层）从左到右，偶数层（第2、4、6...层）从右到左
 - 时间复杂度：O(n)，每个节点访问一次
 - 空间复杂度：O(n)，队列最多存储一层节点
 */

class Solution {

    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root else { return [] }

        var res: [[Int]] = []
        var currentLevel: [TreeNode] = [root]
        // false 表示从左到右（正向），true 表示从右到左（反向）
        var reverse = false

        while !currentLevel.isEmpty {
            var nextLevel: [TreeNode] = []
            var values: [Int] = []

            // 遍历当前层所有节点，收集值并将子节点加入下一层
            for node in currentLevel {
                values.append(node.val)
                if let left = node.left {
                    nextLevel.append(left)
                }
                if let right = node.right {
                    nextLevel.append(right)
                }
            }

            // 偶数层需要反转，实现锯齿效果
            if reverse {
                values.reverse()
            }

            reverse.toggle()
            res.append(values)
            currentLevel = nextLevel
        }
        return res
    }
}

// MARK: - 辅助工具

/// 通过数组构建二叉树（-1 表示 null），层序构建
func buildTree(_ values: [Int?]) -> TreeNode? {
    guard let first = values.first, let rootVal = first else { return nil }
    let root = TreeNode(rootVal)
    var queue: [TreeNode] = [root]
    var i = 1
    while i < values.count && !queue.isEmpty {
        let node = queue.removeFirst()
        // 左子节点
        if i < values.count {
            if let val = values[i] {
                node.left = TreeNode(val)
                queue.append(node.left!)
            }
            i += 1
        }
        // 右子节点
        if i < values.count {
            if let val = values[i] {
                node.right = TreeNode(val)
                queue.append(node.right!)
            }
            i += 1
        }
    }
    return root
}

// MARK: - 测试

let solution = Solution()
var passCount = 0
var failCount = 0

@MainActor func test(_ desc: String, root: TreeNode?, expected: [[Int]]) {
    let result = solution.zigzagLevelOrder(root)
    if result == expected {
        print("✅ \(desc)")
        passCount += 1
    } else {
        print("❌ \(desc)")
        print("   期望: \(expected)")
        print("   实际: \(result)")
        failCount += 1
    }
}

// 测试用例 1：示例1 - 标准三层树
// 树结构：
//       3
//      / \
//     9  20
//        / \
//       15   7
// 期望输出：[[3], [20,9], [15,7]]
test("示例1 - 三层锯齿遍历",
     root: buildTree([3, 9, 20, nil, nil, 15, 7]),
     expected: [[3], [20, 9], [15, 7]])

// 测试用例 2：示例2 - 单节点
test("示例2 - 单节点",
     root: buildTree([1]),
     expected: [[1]])

// 测试用例 3：示例3 - 空树
test("示例3 - 空树",
     root: nil,
     expected: [])

// 测试用例 4：只有左子树的链状树
// 树结构：1 -> 2 -> 3 -> 4
// 期望：[[1], [2], [3], [4]]（锯齿方向交替，但每层只有一个节点结果不变）
let linkedLeft = TreeNode(1, TreeNode(2, TreeNode(3, TreeNode(4), nil), nil), nil)
test("左链状树 - 四层",
     root: linkedLeft,
     expected: [[1], [2], [3], [4]])

// 测试用例 5：四层完全二叉树
// 树结构：
//         1
//        / \
//       2   3
//      / \ / \
//     4  5 6  7
// 期望：[[1], [3,2], [4,5,6,7]]
test("四层完全二叉树",
     root: buildTree([1, 2, 3, 4, 5, 6, 7]),
     expected: [[1], [3, 2], [4, 5, 6, 7]])

// 测试用例 6：只有右子树
// 树结构：1 -> 右2 -> 右3
// 期望：[[1], [2], [3]]
let linkedRight = TreeNode(1, nil, TreeNode(2, nil, TreeNode(3)))
test("右链状树 - 三层",
     root: linkedRight,
     expected: [[1], [2], [3]])

// 测试用例 7：含负数节点值
// 树结构：
//      0
//     / \
//   -3   9
//   /   /
//  -10  5
// 期望：[[0], [9,-3], [-10,5]]
test("含负数节点值",
     root: buildTree([0, -3, 9, -10, nil, 5]),
     expected: [[0], [9, -3], [-10, 5]])

// 打印汇总
print("\n共 \(passCount + failCount) 个测试，\(passCount) 个通过，\(failCount) 个失败")

//: [Next](@next)
