package com.wb;

import mj.printer.BinaryTreeInfo;

import java.util.Comparator;
import java.util.LinkedList;
import java.util.Queue;

public class WBBinarySearchTree<E> implements BinaryTreeInfo {
    private int size;
    private Node<E> root;
    private Comparator<E> comparator;

    // 构造方法
    public WBBinarySearchTree() {
        this(null);
    }

    public WBBinarySearchTree(Comparator<E> comparator) {
        this.comparator = comparator;
    }

    // 元素个数
    public int size() {
        return size;
    }
    // 是否为空
    public Boolean isEmpty() {
        return size == 0;
    }

    public void  clear() {
        root = null;
        size = 0;
    }

    /**
     * 添加元素
     * @param element
     */
    public void add(E element) {
        elementNotNullCheck(element);

        // 添加第一个节点
        if (root == null) {
            root = new Node<>(element, null);
            size++;
            return;
        }

        // 添加的不是第一个节点
        // 找到父节点
        Node<E> parent = root;
        Node<E> node = parent;
        int cmp = 0;
        do {
            cmp = compare(element, node.element);
            parent = node;
            if (cmp > 0) {
                node = node.right;
            } else if (cmp < 0) {
                node = node.left;
            } else  {
                node.element = element;
            }
        } while (node != null);

        Node<E> newNode = new Node<>(element, parent);
        if (cmp > 0) {
            parent.right = newNode;
        } else  {
            parent.left = newNode;
        }
        size++;
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

    public void preOrderTraversal1(Visitor<E> visitor) {
        if (visitor == null) return;
        preOrderTraversal1(root, visitor);
    }

    private void preOrderTraversal1(Node<E> root, Visitor<E> visitor) {
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

    public void inOrderTraversal1(Visitor<E> visitor) {
        if (visitor == null) return;
        inOrderTraversal1(root, visitor);
    }

    private void inOrderTraversal1(Node<E> root, Visitor<E> visitor) {
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

    public void postOrderTraversal1(Visitor<E> visitor) {
        if (visitor == null) return;
        postOrderTraversal1(root, visitor);
    }

    private void postOrderTraversal1(Node<E> root, Visitor<E> visitor) {
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

    public void levelTraversal1(Node<E> root, Visitor<E> visitor) {
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
     * @return
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

    /**
    私有方法
     */
    // 检查插入值不为空
    private void elementNotNullCheck(E element) {
        if (element == null) {
            throw new IllegalArgumentException("element must not be null");
        }
    }

    /**
     * @return 返回值等于0，代表e1和e2相等；返回值大于0，代表e1大于e2；返回值小于于0，代表e1小于e2
     */
    private int compare(E e1, E e2) {
        if (comparator != null) {
            return comparator.compare(e1, e2);
        }
        return ((Comparable<E>)e1).compareTo(e2);
    }

    private Node<E> predecessor(Node<E> node) {
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

    private Node<E> successor(Node<E> node) {
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

    @Override
    public Object root() {
        return root;
    }

    @Override
    public Object left(Object node) {
        return ((Node<E>)node).left;
    }

    @Override
    public Object right(Object node) {
        return ((Node<E>)node).right;
    }

    @Override
    public Object string(Object node) {
        Node<E> myNode = (Node<E>)node;
        String parentString = "null";
        if (myNode.parent != null) {
            parentString = myNode.parent.element.toString();
        }
        return myNode.element + "_p(" + parentString + ")";
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
    private static class Node<E> {
        E element;
        Node<E> left;
        Node<E> right;
        Node<E> parent;
        public Node(E element, Node<E> parent) {
            this.element = element;
            this.parent = parent;
        }

        public boolean isLeaf() {
            return left == null && right == null;
        }

        public boolean hasTwoChildren() {
            return left != null && right != null;
        }
    }
}
