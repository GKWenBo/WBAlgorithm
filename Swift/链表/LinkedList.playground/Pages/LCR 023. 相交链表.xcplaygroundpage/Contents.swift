//: [Previous](@previous)

import Foundation
/*
 给定两个单链表的头节点 headA 和 headB ，请找出并返回两个单链表相交的起始节点。如果两个链表没有交点，返回 null
 
 leetcode：
 https://leetcode.cn/problems/3u1WK4/description/
 https://leetcode.cn/problems/intersection-of-two-linked-lists/description/
 https://leetcode.cn/problems/intersection-of-two-linked-lists-lcci/description/
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

extension ListNode: Equatable, Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(ObjectIdentifier(self))
    }
    
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs === rhs
    }
}

/// 通过双指针
class Solution {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        /// 两个链表任何一个不能为空
        guard headA != nil, headB != nil else {
            return nil
        }
        
        var nodeA = headA, nodeB = headB
        while nodeA != nodeB {
            nodeA = nodeA != nil ? nodeA?.next : headB
            nodeB = nodeB != nil ? nodeB?.next : headA
        }
        return nodeA
    }
}

// 通过哈希集合
class Solution1 {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var temp = headA
        var set = Set<ListNode>()
        while temp != nil {
            set.insert(temp!)
            temp = temp?.next
        }
        
        temp = headB
        while temp != nil {
            if set.contains(temp!) {
                return temp
            }
            temp = temp?.next
        }
        return nil
    }
}


/// 找到链表第一个入环节点，如果无环，返回null
/// - Parameter head: 链表头节点
/// - Returns: 第一个入环节点
func getLoopNode(_ head: ListNode?) -> ListNode? {
    guard head != nil, head?.next != nil, head?.next?.next != nil else {
        return nil
    }
    var slow = head
    var fast = head?.next?.next
    while slow != fast {
        if fast?.next == nil || fast?.next?.next == nil {
            return nil
        }
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    /// 快指针重置为头节点
    fast = head
    while slow != fast {
        slow = slow?.next
        fast = fast?.next
    }
    return slow
}

func noLoop(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    guard headA != nil, headB != nil else {
        return nil
    }
    var curA = headA
    var curB = headB
    var n = 0
    while curA?.next != nil {
        n += 1
        curA = curA?.next
    }
    
    while curB?.next != nil {
        n -= 1
        curB = curB?.next
    }
    
    /// 尾结点不相等，说明链表未相交
    if curA != curB {
        return nil
    }
    
    /// 链表谁长谁变为curA
    curA = n > 0 ? headA : headB
    curB = curA == headA ? headB : headA
    
    n = abs(n)
    while n != 0 {
        n -= 1
        curA = curA?.next
    }
    
    while curA != curB {
        curA = curA?.next
        curB = curB?.next
    }
    return curA
}

/// 求两个链表都有环的第一个相交节点
/// - Parameters:
///   - headA: 第一个链表头结点
///   - loopA: 第一个链表入环节点
///   - headB: 第二个链表头结点
///   - loopB: 第二个链表入环节点
/// - Returns: 相交节点
func bothLoop(_ headA: ListNode?, loopA: ListNode?, headB: ListNode?, loopB: ListNode?) -> ListNode? {
    var curA: ListNode? = nil
    var curB: ListNode? = nil
    if loopA == loopB {
        curA = headA
        curB = headB
        var n = 0
        while curA != loopA {
            n += 1
            curA = curA?.next
        }
        while curB != loopB {
            n -= 1
            curB = curB?.next
        }
        
        curA = n > 0 ? headA : headB
        curB = curA == headA ? headB : headA
        n = abs(n)
        while n != 0 {
            n -= 1
            curA = curA?.next
        }
        
        while curA != curB {
            curA = curA?.next
            curB = curB?.next
        }
        return curA
    } else {
        curA = loopA?.next
        while curA != loopA {
            if curA == loopB {
                return loopA
            }
            curA = curA?.next
        }
        return nil
    }
}

/// 求两个链表相交节点
func getIntersectNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    guard headA != nil, headB != nil else {
        return nil
    }
    /// 获取入环节点
    let loopA = getLoopNode(headA)
    let loopB = getLoopNode(headB)
    if loopA == nil && loopB == nil {
        return noLoop(headA, headB)
    }
    if loopA != nil && loopB != nil {
        return bothLoop(headA, loopA: loopA, headB: headB, loopB: loopB)
    }
    return nil
}

// Test
let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(3)

let node5 = ListNode(5)
let node6 = ListNode(6)

let node8 = ListNode(8)

// NodeA
node1.next = node2
// 设置相交节点
node2.next = node3

// NodeB
node5.next = node6
// 设置相交节点
node6.next = node3

node3.next = node8

let result = Solution().getIntersectionNode(node1, node5)

getIntersectNode(node1, node5)
