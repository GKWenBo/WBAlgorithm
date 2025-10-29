//: [Previous](@previous)

import Foundation

/*
 给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
 
 示例 1：
 
 输入：head = [1,2,3,4,5]
 输出：[5,4,3,2,1]
 示例 2：
 
 
 输入：head = [1,2]
 输出：[2,1]
 示例 3：
 
 输入：head = []
 输出：[]
 
 
 提示：
 
 链表中节点的数目范围是 [0, 5000]
 -5000 <= Node.val <= 5000
 
 
 进阶：链表可以选用迭代或递归方式完成反转。你能否用两种方法解决这道题？
 
 LeetCode：https://leetcode.cn/problems/reverse-linked-list/description/
 */


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        // 由于单链表的结构，至少要用三个指针才能完成迭代反转
        // cur 是当前遍历的节点，pre 是 cur 的前驱结点，nxt 是 cur 的后继结点
        var pre: ListNode?
        var cur = head
        var next = head?.next
        while cur != nil {
            // 逐个结点反转
            cur?.next = pre
            // 更新指针位置
            pre = cur
            cur = next
            // 返回反转后的头结点
            if next != nil {
                next = next?.next
            }
        }
        return pre
    }
}

/// 递归解法
class Solution1 {
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        let last = reverseList(head?.next)
        head?.next?.next = head
        head?.next = nil
        return last
    }
}


//: [Next](@next)
