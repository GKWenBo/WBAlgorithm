//: [Previous](@previous)

import Foundation
/*
 LCR 027. 回文链表
 给定一个链表的 头节点 head ，请判断其是否为回文链表。

 如果一个链表是回文，那么链表节点序列从前往后看和从后往前看是相同的。
 
 LeetCode：
 https://leetcode.cn/problems/aMhZSa/description/
 https://leetcode.cn/problems/palindrome-linked-list/description/
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

/*
 使用快慢指针
 */
class Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        /// 链表为空，直接返回
        guard head != nil, head?.next != nil else {
            return true
        }
        var fast = head, slow = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        /// 如果Fast不为空，说明链表长度为奇数个
        if fast != nil {
            slow = slow?.next
        }
        
        /// 反转后半部分链表
        slow = reverse(slow)
        
        /// 移动快指针到头结点
        fast = head
        while slow != nil {
            /// 判断节点值是否相等
            if fast?.val != slow?.val {
                return false
            }
            fast = fast?.next
            slow = slow?.next
        }
        return true
    }
    
    /// 反转链表
    /// - Parameter head: 链表头结点
    /// - Returns: 反转后的链表
    func reverse(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        var head = head
        var pre: ListNode? = nil
        while head != nil {
            /// 记录头节点的下一个节点
            let next = head?.next
            head?.next = pre
            pre = head
            head = next
        }
        return pre
    }
}

/*
 使用栈实现
 */
class Solution1 {
    func isPalindrome(_ head: ListNode?) -> Bool {
        /// 链表为空，直接返回
        guard head != nil, head?.next != nil else {
            return true
        }
        
        /// 将链表节点值压入栈中
        var stack: [Int] = []
        var temp = head
        while let node = temp { /// 节点不为空
            stack.append(node.val)
            temp = temp?.next
        }
        
        var head = head
        while head != nil {
            if head?.val != stack.popLast() {
                return false
            }
            head = head?.next
        }
        return true
    }
}

/*
 使用栈优化，只需要拿链表的后半部分和前半部分比较即可，没必要全部比较
 */
class Solution2 {
    func isPalindrome(_ head: ListNode?) -> Bool {
        guard head != nil, head?.next != nil else {
            return true
        }
        
        /// 用于存储链表右半部分
        var stack: [Int] = []
        var cur = head, right = head?.next
        /// 通过快慢指针找到中间节点
        while let _ = cur?.next, let _ = right?.next?.next {
            right = right?.next
            cur = cur?.next?.next
        }
        
        /// 存储链表右半部分
        while let r = right {
            stack.append(r.val)
            right = right?.next
        }
        
        var head = head
        while !stack.isEmpty {
            if head?.val != stack.popLast() {
                return false
            }
            head = head?.next
        }
        return true
    }
}

func printListNode(_ head: ListNode?) {
    guard head != nil else {
        return
    }
    printListNode(head?.next)
    print(head?.val ?? 0)
}

/*
 使用递归方式实现
 */
func isPalindrome(_ head: ListNode?) -> Bool {
    temp = head
    return check(head)
}

var temp: ListNode?
func check(_ head: ListNode?) -> Bool {
    guard head != nil else {
        return true
    }
    let res = check(head?.next) && (temp?.val == head?.val)
    temp = temp?.next
    return res
}

/// Test
let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(2)
let node4 = ListNode(1)

node1.next = node2
node2.next = node3
node3.next = node4

printListNode(node1)

Solution2().isPalindrome(node1)

isPalindrome(node1)

//: [Next](@next)
