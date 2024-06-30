package Map;

import java.util.Objects;

public class LinkedHashMap<K, V> extends HashMap<K, V> {
    private LinkedNode<K, V> head;

    private LinkedNode<K, V> tail;

    @Override
    public void clear() {
        super.clear();

        head = null;
        tail = null;
    }

    @Override
    public boolean containsValue(Object value) {
        LinkedNode<K, V> node = head;
        while (node != null) {
            if (Objects.equals(node.value, value)) {
                return true;
            }
            node = node.next;
        }
        return false;
    }

    @Override
    public void traversal(Visitor visitor) {
        if (visitor == null) {
            return;
        };

        LinkedNode<K, V> node = head;
        while (node != null) {
            if (visitor.visit(node.key, node.value)) return;
            node = node.next;
        }
    }

    @Override
    protected Node<K, V> createNode(K key, V value, Node<K, V> parent) {
        LinkedNode<K, V> node = new LinkedNode<K, V>(key, value, parent);
        if (head == null) {
            head = tail = node;
        } else {
            tail.next = node;
            node.prev = tail;

            tail = node;
        }
        return node;
    }

    @Override
    protected void afterRemove(Node<K, V> willNode, Node<K, V> removedNode) {
        LinkedNode<K, V> node1 = (LinkedNode<K, V>)willNode;
        LinkedNode<K, V> node2 = (LinkedNode<K, V>)removedNode;

        if (node1 != node2) {
            // 交换linkedWillNode和linkedRemovedNode在链表中的位置
            // 交换prev
            LinkedNode<K, V> tmp = node1.prev;
            node1.prev = node2.prev;
            node2.prev = tmp;
            if (node1.prev == null) {
                head = node1;
            } else  {
                node1.prev.next = node1;
            }
            if (node2.prev == null) {
                head = node2;
            } else  {
                node2.prev.next = node2;
            }

            // 交换next
            tmp = node1.next;
            node1.next = node2.next;
            node2.next = tmp;
            if (node1.next == null) {
                tail = node1;
            } else  {
                node1.next.prev = node1;
            }
            if (node2.next == null) {
                tail = node2;
            } else  {
                node2.next.prev = node2;
            }
        }

        LinkedNode<K, V> pre = node2.prev;
        LinkedNode<K, V> next = node2.next;

        if (pre == null) {
            head = next;
        } else  {
            pre.next = next;
        }

        if (next == null) {
            tail = pre;
        } else {
            next.prev = pre;
        }
    }

    private static class LinkedNode<K, V> extends Node<K, V> {
        LinkedNode<K, V> prev;
        LinkedNode<K, V> next;

        public LinkedNode(K key, V value, Node<K, V> parent) {
            super(key, value, parent);
        }
    }
}
