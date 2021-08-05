//: [Previous](@previous)

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/// 双指针迭代法
/// - Parameters:
///   - l1: 链表1
///   - l2: 链表2
/// - Returns: 合并之后的链表
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    let dum = ListNode(-1)
    var cur: ListNode? = dum
    
    var p1: ListNode? = l1
    var p2: ListNode? = l2
    while p1 != nil && p2 != nil {
        if p1!.val < p2!.val {
            cur?.next = p1
            p1 = p1?.next
        } else {
            cur?.next = p2
            p2 = p2?.next
        }
        cur = cur?.next
    }
    
    cur?.next = p1 ?? p2
    
    return dum.next
}

//: [Next](@next)

