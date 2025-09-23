//: [Previous](@previous)

import Foundation

/*
 给你一个单链表的头节点 head ，请你判断该链表是否为回文链表。如果是，返回 true ；否则，返回 false 。

 示例 1：


 输入：head = [1,2,2,1]
 输出：true
 示例 2：


 输入：head = [1,2]
 输出：false
  

 提示：

 链表中节点数目在范围[1, 105] 内
 0 <= Node.val <= 9
  

 进阶：你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？
 
 LeetCode：https://leetcode.cn/problems/palindrome-linked-list/description/
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    
    /// 从左往右移动指针
    var left: ListNode?
    
    /// 记录是否是回文
    var res = true
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        left = head
        traverse(head?.next)
        return res
    }
    
    func traverse(_ right: ListNode?) {
        guard right != nil else {
            return
        }
        
        traverse(right?.next)
        /// 后续遍历位置，此时right指针指向链表的尾部
        /// 所以可以和left指针比较，判断是否是回文链表
        if left?.val != right?.val {
            res = false
        }
        /// 移动左指针
        left = left?.next
    }
}

class Solution1 {
    func isPalindrome(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head
        
        /// 获取链表中间节点
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        if fast?.next != nil {
            slow = slow?.next
        }
        
        var left = head
        /// 反转链表右半部分
        var right = reverse(slow)
        while right != nil {
            if left?.val != right?.val {
                return false
            }
            left = left?.next
            right = right?.next
        }
        return true
    }
    
    func reverse(_ head: ListNode?) -> ListNode? {
        var pre: ListNode? = nil
        var cur = head
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        return pre
    }
}

//: [Next](@next)
