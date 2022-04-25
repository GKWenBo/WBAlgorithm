package 二叉树;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

/**
 * https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/
 */
public class _107_二叉树的层序遍历II {

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
        public List<List<Integer>> levelOrderBottom(TreeNode root) {
            // 结果二维数组
            List<List<Integer>> res = new ArrayList<>();
            if (root == null) return res;
            // 辅助遍历队列
            Queue<TreeNode> treeNodeQueue = new LinkedList<>();
            // 根节点入队
            treeNodeQueue.offer(root);
            while (!treeNodeQueue.isEmpty()) {
                List<Integer> level = new ArrayList<>();
                int currentSize = treeNodeQueue.size();
                for (int i = 0; i < currentSize; i++) {
                    TreeNode node = treeNodeQueue.poll();
                    level.add(node.val);
                    if (node.left != null) {
                        treeNodeQueue.offer(node.left);
                    }

                    if (node.right != null) {
                        treeNodeQueue.offer(node.right);
                    }
                }

                res.add(0, level);
            }
            return res;
        }
    }
}
