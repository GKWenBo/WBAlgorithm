//: [Previous](@previous)

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

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-linked-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    
    /// 非递归实现
    /// - Parameter head: 链表头部
    /// - Returns: 新头节点
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        var head = head
        
        var newHead: ListNode? = nil
        while head != nil {
            let temp = head?.next
            head?.next = newHead
            newHead = head
            head = temp
        }
        return newHead
    }
    
    /// 递归翻转
    /// - Parameter head: 头结点
    /// - Returns: 新头节点
    func reverseList1(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let newHead = reverseList1(head?.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
}

//: [Next](@next)
