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

// 递归遍历（DFS）：先左后右
func traverse(root: TreeNode?) {
    guard let root else { return }
    traverse(root: root.left)
    traverse(root: root.right)
}

// 递归遍历（DFS）：先右后左
func traverseFlip(root: TreeNode?) {
    guard let root else { return }
    traverseFlip(root: root.right)
    traverseFlip(root: root.left)
}


/// 因为前序位置的代码是刚进入节点时执行的，所以前序遍历的顺序就是 root 指针在树上移动的顺序
func preOrderTraverse(root: TreeNode?) {
    guard let root else { return }
    /// 打印前序遍历结果
    print(root.val)
    preOrderTraverse(root: root.left)
    preOrderTraverse(root: root.right)
}

/// 中序位置的代码是左子树遍历完成后，还未遍历右子树时执行的。请你点开下面的可视化面板，多次点击  这一行代码，可以看到 root 指针在树上移动的顺序和刚才一致；节点变蓝的顺序，就是中序遍历的结果，你会发现一个节点在它的左子树遍历完时才会变蓝
func inOrderTraverse(root: TreeNode?) {
    guard let root else { return }
    inOrderTraverse(root: root.left)
    /// 打印中序遍历结果
    print(root.val)
    inOrderTraverse(root: root.right)
}

// 后序位置的代码是左右子树都遍历完，即将离开节点时执行的。请你点开下面的可视化面板，多次点击  这一行代码，可以看到 root 指针在树上移动的顺序和刚才一致；节点变红的顺序，就是后序遍历的结果，你会发现一个节点在它的左右子树都遍历完时才会变红
func postOrderTraverse(root: TreeNode?) {
    guard let root else { return }
    postOrderTraverse(root: root.left)
    postOrderTraverse(root: root.right)
    /// 打印后序遍历结果
    print(root.val)
}


