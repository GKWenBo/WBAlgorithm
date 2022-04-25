package 二叉树;

import com.sun.source.tree.Tree;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

/**
 * https://leetcode-cn.com/problems/binary-tree-postorder-traversal/
 */
public class _145_二叉树的后序遍历 {
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
        public List<Integer> postorderTraversal(TreeNode root) {
            List<Integer> res = new ArrayList<>();
            postorderTraversal(root, res);
            return res;
        }

        /**
         * 递归解法
         * @param root
         * @param res
         */
        private void postorderTraversal(TreeNode root, List<Integer> res) {
            if (root == null) return;

            postorderTraversal(root.left, res);
            postorderTraversal(root.right, res);
            res.add(root.val);
        }

        /**
         * 非递归写法
         * @param root
         * @return
         */
        public List<Integer> postorderTraversal1(TreeNode root) {
            List<Integer> res = new ArrayList<>();
            if (root == null) return res;
            Stack<TreeNode> nodeStack = new Stack<>();
            TreeNode node = root;
            TreeNode lastVisit = root;
            while (node != null || !nodeStack.isEmpty()) {
                while (node != null) {
                    nodeStack.push(node);
                    node = node.left;
                }

                // 查看当前栈顶元素
                node = nodeStack.peek();
                // 如果其右子树也为空，或者右子树已经访问
                // 则可以直接输出当前节点的值
                if (node.right == null || node.right == lastVisit) {
                    res.add(node.val);
                    nodeStack.pop();
                    lastVisit = node;
                    node = null;
                } else  {
                    // 否则，继续遍历右子树
                    node = node.right;
                }
            }
            return res;
        }
    }

}
