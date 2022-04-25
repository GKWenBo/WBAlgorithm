package 二叉树;

import java.util.LinkedList;
import java.util.Queue;

/**
 * https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/
 */
public class _104_二叉树的最大深度 {

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
        public int maxDepth(TreeNode root) {
            if (root == null) return 0;

            Queue<TreeNode> treeNodeQueue = new LinkedList<>();
            treeNodeQueue.offer(root);

            int height = 0;
            int levelSize = 1;
            while (!treeNodeQueue.isEmpty()) {
                TreeNode node = treeNodeQueue.poll();

                levelSize--;

                if (node.left != null) {
                    treeNodeQueue.offer(node.left);
                }

                if (node.right != null) {
                    treeNodeQueue.offer(node.right);
                }

                if (levelSize == 0) {
                    levelSize = treeNodeQueue.size();
                    height++;
                }
            }

            return height;
        }

        /**
         * 递归解法
         * @param root
         * @return
         */
        private int _maxDepth(TreeNode root) {
            if (root == null) return 0;
            return 1 + Math.max(_maxDepth(root.left), _maxDepth(root.right));
        }
    }

}
