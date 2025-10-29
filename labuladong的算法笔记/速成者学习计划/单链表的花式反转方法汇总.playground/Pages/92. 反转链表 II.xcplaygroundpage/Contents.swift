//: [Previous](@previous)

import Foundation

/*
 给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。
  

 示例 1：


 输入：head = [1,2,3,4,5], left = 2, right = 4
 输出：[1,4,3,2,5]
 示例 2：

 输入：head = [5], left = 1, right = 1
 输出：[5]
  

 提示：

 链表中节点数目为 n
 1 <= n <= 500
 -500 <= Node.val <= 500
 1 <= left <= right <= n
  

 进阶： 你可以使用一趟扫描完成反转吗？
 
 LeetCode：https://leetcode.cn/problems/reverse-linked-list-ii/
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

/// 迭代解法
class Solution {
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        if left == 1 {
            return reverseN(head, right)
        }
        // 找到第 m 个节点的前驱
        var pre = head
        for _ in 1..<left - 1 {
            pre = pre?.next
        }
        // 从第 m 个节点开始反转
        pre?.next = reverseN(pre?.next, right - left + 1)
        return head
    }
    
    func reverseN(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        var pre: ListNode?
        var cur = head
        var nxt = head?.next
        var n = k
        while n > 0 {
            cur?.next = pre
            pre = cur
            cur = nxt
            if nxt != nil {
                nxt = nxt?.next
            }
            n -= 1
        }
        // 此时的 cur 是第 n + 1 个节点，head 是反转后的尾结点
        head?.next = cur
        // 此时的 pre 是反转后的头结点
        return pre
    }
}

class Solution1 {
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        // base case
        if left == 1 {
            return reverseN(head, right)
        }
        // 前进到反转的起点触发 base case
        head?.next = reverseBetween(head?.next, left - 1, right - 1)
        return head
    }
    
    var successor: ListNode?
    
    func reverseN(_ head: ListNode?, _ k: Int) -> ListNode? {
        // 记录第 n + 1 个节点
        if k == 1 {
            successor = head?.next
            return head
        }
        // 以 head.next 为起点，需要反转前 n - 1 个节点
        let last = reverseN(head?.next, k - 1)
        head?.next?.next = head
        // 让反转之后的 head 节点和后面的节点连起来
        head?.next = successor
        return last
    }
}

//: [Next](@next)
