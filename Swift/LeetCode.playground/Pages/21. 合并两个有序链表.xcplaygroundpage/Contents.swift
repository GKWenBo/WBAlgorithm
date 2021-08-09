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

//func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
//    if l1 == nil {
//        return l2
//    }
//    if l2 == nil {
//        return l1
//    }
//
//    if l1!.val < l2!.val {
//        l1?.next = mergeTwoLists(l1?.next, l2)
//        return l1
//    } else {
//        l2?.next = mergeTwoLists(l1, l2?.next)
//        return l2
//    }
//}

//: [Next](@next)
