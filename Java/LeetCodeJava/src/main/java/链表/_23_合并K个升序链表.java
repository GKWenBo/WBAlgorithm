package 链表;

import java.util.PriorityQueue;

/**
 * https://leetcode-cn.com/problems/merge-k-sorted-lists/
 */
public class _23_合并K个升序链表 {

    public class ListNode {
        int val;
        ListNode next;

        ListNode() {
        }

        ListNode(int val) {
            this.val = val;
        }

        ListNode(int val, ListNode next) {
            this.val = val;
            this.next = next;
        }
    }

    class Status implements Comparable<Status> {
        int val;
        ListNode ptr;

        Status(int val, ListNode ptr) {
            this.val = val;
            this.ptr = ptr;
        }

        public int compareTo(Status o) {
            return this.val - o.val;
        }
    }

    class Solution {
        /**
         * 顺序合并
         * @param lists
         * @return
         */
        public ListNode mergeKLists(ListNode[] lists) {
            // 保存合并结果
            ListNode res = null;
            for (ListNode list:lists
                 ) {
                res = mergeTwoList(res, list);
            }
            return res;
        }

        /**
         * 合并两个链表
         * @param leftList
         * @param rightList
         * @return
         */
        private ListNode mergeTwoList(ListNode leftList, ListNode rightList) {
            if (leftList == null || rightList == null) {
                return leftList == null ? rightList : leftList;
            }

            // 哨兵节点
            ListNode head = new ListNode(0);
            // 当前尾结点
            ListNode tail = head;
            ListNode leftPtr = leftList;
            ListNode rightPtr = rightList;

            while (leftPtr != null && rightPtr != null) {
                if (leftPtr.val < rightPtr.val) {
                    tail.next = leftPtr;
                    leftPtr = leftPtr.next;
                } else {
                    tail.next = rightPtr;
                    rightPtr = rightPtr.next;
                }
                tail = tail.next;
            }

            tail.next = leftPtr == null ? rightPtr : leftPtr;

            return head.next;
        }

        /**
         * 解法2：分治合并
         * @param lists
         * @return
         */
        public ListNode mergeKLists1(ListNode[] lists) {
            return merge(lists, 0, lists.length - 1);
        }
        /**
         * 分治合并
         * @param lists
         * @param l
         * @param r
         * @return
         */
        private ListNode merge(ListNode[] lists, int l, int r) {
            if (l == r) {
                return lists[l];
            }

            if (l > r) {
                return null;
            }

            int mid = (l + r) >> 1;
            return mergeTwoList(merge(lists,l, mid), merge(lists, mid + 1, r));
        }


        PriorityQueue<Status> priorityQueue = new PriorityQueue<>();
        /**
         * 解法3：优先级队列
         * @param lists
         * @return
         */
        public ListNode mergeKLists2(ListNode[] lists) {
            for (ListNode node:lists) {
                if (node != null) {
                    priorityQueue.offer(new Status(node.val, node));
                }
            }

            ListNode head = new ListNode(0);
            ListNode tail = head;
            while (!priorityQueue.isEmpty()) {
                Status f = priorityQueue.poll();
                tail.next = f.ptr;
                tail = tail.next;
                if (f.ptr.next != null) {
                    priorityQueue.offer(new Status(f.ptr.next.val, f.ptr.next));
                }
            }
            return head.next;
        }
    }
}
