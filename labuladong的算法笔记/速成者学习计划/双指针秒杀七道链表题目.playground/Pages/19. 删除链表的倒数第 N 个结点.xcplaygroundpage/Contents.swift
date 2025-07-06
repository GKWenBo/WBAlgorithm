//: [Previous](@previous)

import Foundation

/*
 LeetCode：http://leetcode.cn/problems/remove-nth-node-from-end-of-list/description/
 
 给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。

 示例 1：


 输入：head = [1,2,3,4,5], n = 2
 输出：[1,2,3,5]
 示例 2：

 输入：head = [1], n = 1
 输出：[]
 示例 3：

 输入：head = [1,2], n = 1
 输出：[1]
  

 提示：

 链表中结点的数目为 sz
 1 <= sz <= 30
 0 <= Node.val <= 100
 1 <= n <= sz
  

 进阶：你能尝试使用一趟扫描实现吗？
 */

/// 单链表节点
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        /// 虚拟头节点
        let dumpy = ListNode(-1)
        dumpy.next = head
        /// 删除倒数第n个，要找到倒数第 n + 1个
        let node = findFromEnd(dumpy, n + 1)
        /// 删掉倒数第 n 个节点
        node?.next = node?.next?.next
        return dumpy.next
    }
    
    /// 获取链表倒数第k个节点
    /// - Parameters:
    ///   - head: 头结点
    ///   - n: 倒数第几个节点
    /// - Returns: 查找的节点
    func findFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var p1 = head
        var p2 = head
        for _ in 0..<n {
            p1 = p1?.next
        }
        while p1 != nil {
            p1 = p1?.next
            p2 = p2?.next
        }
        return p2
    }
}

//: [Next](@next)
