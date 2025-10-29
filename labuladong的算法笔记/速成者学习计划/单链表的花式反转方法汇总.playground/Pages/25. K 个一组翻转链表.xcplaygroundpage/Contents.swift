//: [Previous](@previous)

import Foundation

/*
 给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。

 k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。

 你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。

  

 示例 1：


 输入：head = [1,2,3,4,5], k = 2
 输出：[2,1,4,3,5]
 示例 2：



 输入：head = [1,2,3,4,5], k = 3
 输出：[3,2,1,4,5]
  

 提示：
 链表中的节点数目为 n
 1 <= k <= n <= 5000
 0 <= Node.val <= 1000
  

 进阶：你可以设计一个只用 O(1) 额外内存空间的算法解决此问题吗？
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


class Solution {
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil else { return nil }
        
        /// 区间 [a, b) 包含 k 个待反转元素
        var a = head, b = head
        for _ in 0..<k {
            /// 不足 k 个，不需要反转了
            if b == nil {
                return head
            }
            b = b?.next
        }
        
        /// 反转前 k 个元素
        let newHead = reverseN(a, k)
        /// 此时 b 指向下一组待反转的头结点
        /// 递归反转后续链表并连接起来
        a?.next = reverseKGroup(b, k)
        return newHead
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

//: [Next](@next)
