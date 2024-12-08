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
