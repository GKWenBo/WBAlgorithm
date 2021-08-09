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

func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
    if head?.val == val {
        return head?.next
    }
    
    var pre = head
    var cur = head?.next
    while cur != nil && cur?.val != val {
        pre = cur
        cur = cur?.next
    }
    
    if cur != nil {
        pre?.next = cur?.next
    }
    
    return head
}


//: [Next](@next)
