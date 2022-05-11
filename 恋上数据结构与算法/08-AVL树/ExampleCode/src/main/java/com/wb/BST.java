package com.wb;

import mj.printer.BinaryTreeInfo;

import java.util.Comparator;
import java.util.LinkedList;
import java.util.Queue;

// 二叉搜索树
public class BST<E> extends BinaryTree<E> {
    private Comparator<E> comparator;

    // 构造方法
    public BST() {
        this(null);
    }

    public BST(Comparator<E> comparator) {
        this.comparator = comparator;
    }

    /**
     * 添加元素
     * @param element
     */
    public void add(E element) {
        elementNotNullCheck(element);

        // 添加第一个节点
        if (root == null) {
            root = createNode(element, null);
            size++;

            // 新添加节点之后处理
            afterAdd(root);
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

        Node<E> newNode = createNode(element, parent);
        if (cmp > 0) {
            parent.right = newNode;
        } else  {
            parent.left = newNode;
        }
        size++;

        // 新添加节点之后处理
        afterAdd(newNode);
    }

    /**
     * 删除node之后的调整
     * @param node 被删除的节点
     */
    protected void afterAdd(Node<E> node) {}

    /**
     * 删除node之后的调整
     * @param node 被删除的节点
     */
    protected void afterRemove(Node<E> node) {}

    /**
     * 移除节点
     * @param element
     */
    public void remove(E element) {
        remove(node(element));
    }

    private void remove(Node<E> node) {
        if (node == null) return;

        size--;

        if (node.hasTwoChildren()) { // 度为2的节点
            // 找到后继节点
            Node<E> s = successor(node);
            // 用后继节点的值覆盖度为2的值
            node.element = s.element;
            // 删除后继节点
            node = s;
        }

        // 删除node节点（node的度必然是1或者0）
        Node<E> replacement = node.left != null ? node.left : node.right;
        if (replacement != null) {
            // 更改parent
            replacement.parent = node.parent;
            // 更改parent的left、right的指向
            if (node.parent == null) { // node是度为1的根节点
                root = replacement;
            } else if (node == node.parent.left) {
                node.parent.left = replacement;
            } else  {
                node.parent.right = replacement;
            }

            // 删除节点之后处理
            afterRemove(node);
        } else if (node.parent == null) { // node是叶子节点并且是根节点
            root = null;

            // 删除节点之后处理
            afterRemove(node);
        } else  { // node是叶子节点，但不是根节点
            if (node == node.parent.left) {
                node.parent.left = null;
            } else {
                node.parent.right = null;
            }

            // 删除节点之后处理
            afterRemove(node);
        }
    }

    public Boolean contains(E element) {
        return node(element) != null;
    }

    /**
     * 根据元素获取节点
     * @param element
     * @return
     */
    private Node<E> node(E element) {
        Node<E> node = root;
        while (node != null) {
            int cmp = compare(element, node.element);
            if (cmp == 0) return node;
            if (cmp > 0) {
                node = node.right;
            } else { // cmp < 0
                node = node.left;
            }
        }
        return null;
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
}
