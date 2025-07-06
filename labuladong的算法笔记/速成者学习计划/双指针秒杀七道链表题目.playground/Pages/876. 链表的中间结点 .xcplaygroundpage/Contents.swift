//: [Previous](@previous)

import Foundation

/*
 LeetCode: https://leetcode.cn/problems/middle-of-the-linked-list/
 
 给你单链表的头结点 head ，请你找出并返回链表的中间结点。

 如果有两个中间结点，则返回第二个中间结点。
  

 示例 1：


 输入：head = [1,2,3,4,5]
 输出：[3,4,5]
 解释：链表只有一个中间结点，值为 3 。
 示例 2：


 输入：head = [1,2,3,4,5,6]
 输出：[4,5,6]
 解释：该链表有两个中间结点，值分别为 3 和 4 ，返回第二个结点。
  

 提示：

 链表的结点数范围是 [1, 100]
 1 <= Node.val <= 100
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
    
    /// 使用快慢指针
    func middleNode(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        return slow
    }
}

//: [Next](@next)
