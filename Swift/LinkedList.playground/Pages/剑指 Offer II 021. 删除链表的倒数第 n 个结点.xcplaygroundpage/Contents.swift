//: [Previous](@previous)

import Foundation

public class ListNode: CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    public var description: String {
        return "\(val)"
    }
}

class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var slow = head
        var fast = head
        var pos = 1
        while fast != nil, pos < n {
            fast = fast?.next
            pos += 1
        }
        
        var preNode: ListNode?
        while fast != nil {
            preNode = slow
            fast = fast?.next
            slow = slow?.next
        }
        
        preNode?.next = slow?.next
        
        return head
    }
}

var head = ListNode(-1)

let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(3)
let node4 = ListNode(4)

head.next = node1

let solution = Solution()
var node = solution.removeNthFromEnd(head, 3)
while node?.next != nil {
    print(node ?? "")
    node = node?.next
}

//: [Next](@next)
