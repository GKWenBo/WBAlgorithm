package 二叉树;

/**
 * https://leetcode.cn/problems/balanced-binary-tree/
 */
public class _110_平衡二叉树 {

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
        public boolean isBalanced(TreeNode root) {
//            return preOrder(root) != -1;

            if (root == null) {
                return true;
            }
            return Math.abs(depth(root.left) - depth(root.right)) < 2 && isBalanced(root.left) && isBalanced(root.right);
        }

        /**
         * 方法一，从底至上遍历
         * @param root
         * @return
         */
        private int preOrder(TreeNode root) {
            if (root == null) {
                return 0;
            }
            int left = preOrder(root.left);
            if (left == -1) {
                return -1;
            }

            int right = preOrder(root.right);
            if (right == -1) {
                return -1;
            }

            return Math.abs(left - right) <= 1 ? Math.max(left, right) + 1 : -1;
        }

        private int depth(TreeNode node) {
            if (node == null) {
                return 0;
            }
            return Math.max(depth(node.left), depth(node.right)) + 1;
        }
    }
}
