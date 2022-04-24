package 二叉树;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

/**
 * https://leetcode-cn.com/problems/binary-tree-inorder-traversal/
 */

public class _94_二叉树的中序遍历 {

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
        public List<Integer> inorderTraversal(TreeNode root) {
            List<Integer> res = new ArrayList<>();
            inorderTraversal(root, res);
            return res;
        }

        /**
         * 递归解法
         * @param root
         * @param res
         */
        private void inorderTraversal(TreeNode root, List<Integer> res) {
            if (root == null) return;

            inorderTraversal(root.left, res);
            res.add(root.val);
            inorderTraversal(root.right, res);
        }

        /**
         * 遍历解法
         * @param root
         * @return
         */
        public List<Integer> inorderTraversal1(TreeNode root) {
            List<Integer> res = new ArrayList<>();
            Stack<TreeNode> nodeStack = new Stack<>();
            TreeNode node = root;
            while (node != null || !nodeStack.isEmpty()) {
                while (node != null) {
                    nodeStack.push(node);
                    node = node.left;
                }

                if (!nodeStack.isEmpty()) {
                    node = nodeStack.pop();
                    res.add(node.val);
                    node = node.right;
                }
            }
            return res;
        }
    }
}
