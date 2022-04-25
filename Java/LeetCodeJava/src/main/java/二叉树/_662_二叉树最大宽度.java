package 二叉树;

import java.util.HashMap;
import java.util.Map;

/**
 * https://leetcode-cn.com/problems/maximum-width-of-binary-tree/
 */
public class _662_二叉树最大宽度 {

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
        int ans;
        Map<Integer, Integer> left;
        public int widthOfBinaryTree(TreeNode root) {
            ans = 0;
            left = new HashMap<>();
            dfs(root, 0, 0);
            return ans;
        }
        public void dfs(TreeNode root, int depth, int pos) {
            if (root == null) return;
            left.computeIfAbsent(depth, x->pos);
            ans = Math.max(ans, pos - left.get(depth) + 1);
            dfs(root.left, depth + 1, 2 * pos);
            dfs(root.right, depth + 1, 2 * pos + 1);
        }
    }
}
