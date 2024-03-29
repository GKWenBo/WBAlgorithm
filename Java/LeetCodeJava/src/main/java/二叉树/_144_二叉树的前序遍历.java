package 二叉树;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

/**
 * https://leetcode-cn.com/problems/binary-tree-preorder-traversal/
 */
public class _144_二叉树的前序遍历 {

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode() {}
        TreeNode(int val) { this.val = val; }
        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }

    class Solution {
        public List<Integer> preorderTraversal(TreeNode root) {
            List<Integer> res = new ArrayList<>();
            preorderTraversal(root, res);
            return res;
        }

        /**
         * 递归解法
         * @param root
         * @param res
         */
        private void preorderTraversal(TreeNode root, List<Integer> res) {
            if (root == null) return;
            res.add(root.val);
            preorderTraversal(root.left, res);
            preorderTraversal(root.right, res);
        }

        private List<Integer> preorderTraversal1(TreeNode root) {
            List<Integer> res = new ArrayList<>();
            // 用来暂存节点的栈
            Stack<TreeNode> nodeStack = new Stack<>();
            TreeNode node = root;
            // 当遍历到最后一个节点的时候，无论它的左右子树都为空，并且栈也为空
            // 所以，只要不同时满足这两点，都需要进入循环
            while (node != null || !nodeStack.isEmpty()) {
                // 若当前考查节点非空，则输出该节点的值
                // 由考查顺序得知，需要一直往左走
                while (node != null) {
                    res.add(node.val);
                    // 为了之后能找到该节点的右子树，暂存该节点
                    nodeStack.push(node);
                    node = node.left;
                }

                // 一直到左子树为空
                // 如果栈为空，就不需要考虑
                // 弹出栈顶元素，将游标等于节点右子树
                if (!nodeStack.isEmpty()) {
                    node = nodeStack.pop();
                    node = node.right;
                }
            }
            return res;
        }
    }

}
