package com.wb;

import mj.printer.BinaryTreeInfo;

import java.util.LinkedList;
import java.util.Queue;

public class BinaryTree<E> implements BinaryTreeInfo {
    protected int size;
    protected Node<E> root;

    // 元素个数
    public int size() {
        return size;
    }

    /**
     * 是否为空
     * @return
     */
    public Boolean isEmpty() {
        return size == 0;
    }

    /**
     * 清空二叉树
     */
    public void clear() {
        root = null;
        size = 0;
    }

    /**
     * 创建节点
     * @param element
     * @param parent
     * @return
     */
    protected Node<E> createNode(E element, Node<E> parent) {
        return new Node<>(element, parent);
    }

    /**
     * 前序遍历
     */
    public void preOrderTraversal() {
        preOrderTraversal(root);
    }

    private void preOrderTraversal(Node<E> root) {
        if (root == null) return;
        System.out.println(root.element);
        preOrderTraversal(root.left);
        preOrderTraversal(root.right);
    }

    public void preOrderTraversal1(BST.Visitor<E> visitor) {
        if (visitor == null) return;
        preOrderTraversal1(root, visitor);
    }

    private void preOrderTraversal1(Node<E> root, BST.Visitor<E> visitor) {
        if (root == null || visitor.stop) return;
        visitor.stop = visitor.visit(root.element);
        preOrderTraversal(root.left);
        preOrderTraversal(root.right);
    }

    /**
     * 中序遍历
     */
    public void inOrderTraversal() {
        inOrderTraversal(root);
    }

    private void inOrderTraversal(Node<E> root) {
        if (root == null) return;
        inOrderTraversal(root.left);
        System.out.println(root.element);
        inOrderTraversal(root.right);
    }

    public void inOrderTraversal1(BST.Visitor<E> visitor) {
        if (visitor == null) return;
        inOrderTraversal1(root, visitor);
    }

    private void inOrderTraversal1(Node<E> root, BST.Visitor<E> visitor) {
        if (root == null || visitor.stop) return;
        inOrderTraversal(root.left);
        if (visitor.stop) return;
        visitor.stop = visitor.visit(root.element);
        inOrderTraversal(root.right);
    }

    /**
     * 后序遍历
     */
    public void postOrderTraversal() {
        postOrderTraversal(root);
    }

    private void postOrderTraversal(Node<E> root) {
        if (root == null) return;
        postOrderTraversal(root.left);
        postOrderTraversal(root.right);
        System.out.println(root.element);
    }

    public void postOrderTraversal1(BST.Visitor<E> visitor) {
        if (visitor == null) return;
        postOrderTraversal1(root, visitor);
    }

    private void postOrderTraversal1(Node<E> root, BST.Visitor<E> visitor) {
        if (root == null || visitor.stop) return;
        postOrderTraversal(root.left);
        postOrderTraversal(root.right);
        if (visitor.stop) return;
        visitor.stop = visitor.visit(root.element);
    }

    public void levelTraversal(Node<E> root) {
        if (root == null) return;

        Queue<Node<E>> queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()) {
            Node<E> node = queue.poll();
            System.out.println(node.element);

            if (root.left != null) {
                queue.offer(node.left);
            }

            if (root.right != null) {
                queue.offer(node.right);
            }
        }
    }

    public void levelTraversal1(Node<E> root, BST.Visitor<E> visitor) {
        if (root == null || visitor == null) return;

        Queue<Node<E>> queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()) {
            Node<E> node = queue.poll();
            if (visitor.visit(node.element)) return;

            if (root.left != null) {
                queue.offer(node.left);
            }

            if (root.right != null) {
                queue.offer(node.right);
            }
        }
    }

    /**
     * 树的高度
     */
    public int height() {
        if (root == null) return 0;
        // 树的高度
        int height = 0;
        int levelSize = 1;
        Queue<Node<E>> queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()) {
            Node<E> node = queue.poll();
            levelSize--;

            if (node.left != null) {
                queue.offer(node.left);
            }

            if (node.right != null) {
                queue.offer(node.right);
            }
            if (levelSize == 0) {
                levelSize = queue.size();
                height++;
            }
        }
        return height;
    }

    public int height1() {
        return height1(root);
    }

    public int height1(Node<E> root) {
        if (root == null) return 0;
        return 1 + Math.max(height1(root.left), height1(root.right));
    }

    /**
     *
     * @return
     */
    public boolean isComplete() {
        if (root == null) return false;
        boolean leaf = false;
        Queue<Node<E>> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            Node<E> node = queue.poll();
            if (leaf && !node.isLeaf()) return false;

            if (node.left != null && node.right != null) {
                queue.offer(node.left);
                queue.offer(node.right);
            } else if (node.left == null && node.right != null) {
                return false;
            } else  {
                leaf = true;
                if (node.left != null) {
                    queue.offer(node.left);
                }
            }
        }
        return true;
    }

    public boolean isComplete1() {
        if (root == null) return false;
        boolean leaf = false;
        Queue<Node<E>> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            Node<E> node = queue.poll();
            if (leaf && !node.isLeaf()) return false;

            if (node.left != null) {
                queue.offer(node.left);
            } else if (node.right != null) {
                return false;
            }

            if (node.right != null) {
                queue.offer(node.right);
            } else  {
                leaf = true;
            }
        }
        return true;
    }

    protected Node<E> predecessor(Node<E> node) {
        if (node == null) return null;

        // 前驱节点在左子树当中（left.right.right.right....）
        Node<E> p = node.left;
        if (p != null) {
            while (p.right != null) {
                p = p.right;
            }
            return p;
        }

        // 从父节点、祖父节点寻找前驱节点
        while (node.parent != null && node == node.parent.left) {
            node = node.parent;
        }

        // node.parent == null
        // node == node.parent.right
        return node.parent;
    }

    protected Node<E> successor(Node<E> node) {
        if (node == null) return null;

        // 前驱节点在左子树当中（right.left.left.left....）
        Node<E> p = node.right;
        if (p != null) {
            while (p.left != null) {
                p = p.left;
            }
            return p;
        }

        // 从父节点、祖父节点寻找前驱节点
        while (node.parent != null && node == node.parent.right) {
            node = node.parent;
        }

        // node.parent == null
        // node == node.parent.right
        return node.parent;
    }

    public static abstract class Visitor<E> {
        boolean stop;
        /**
         * 返回true就停止遍历
         * @param element
         * @return
         */
        public abstract boolean visit(E element);
    }

    /**
     * 节点类
     * @param <E>
     */
    protected static class Node<E> {
        E element;
        Node<E> left;
        Node<E> right;
        Node<E> parent;
        public Node(E element, Node<E> parent) {
            this.element = element;
            this.parent = parent;
        }

        /**
         * 是否是叶子节点
         * @return
         */
        public boolean isLeaf() {
            return left == null && right == null;
        }

        /**
         * 是否有左右子节点
         * @return
         */
        public boolean hasTwoChildren() {
            return left != null && right != null;
        }

        public boolean isLeftChild() {
            return parent != null && this == parent.left;
        }

        public  boolean isRightChild() {
            return parent != null && this == parent.right;
        }

        public  Node<E> sibling() {
            if (isLeftChild()) {
                return parent.right;
            }

            if (isRightChild()) {
                return parent.left;
            }
            return null;
        }
    }

    /**
     * BinaryTreeInfo
     */
    @Override
    public Object root() {
        return root;
    }

    @Override
    public Object left(Object node) {
        return ((BST.Node<E>)node).left;
    }

    @Override
    public Object right(Object node) {
        return ((BST.Node<E>)node).right;
    }

    @Override
    public Object string(Object node) {
        BST.Node<E> myNode = (BST.Node<E>)node;
        String parentString = "null";
        if (myNode.parent != null) {
            parentString = myNode.parent.element.toString();
        }
        return myNode.element + "_p(" + parentString + ")";
    }
}
