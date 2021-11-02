//: [Previous](@previous)

/*
 给定一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。

 示例 1：
 输入：head = [1,2,3,4,5], n = 2
 输出：[1,2,3,5]
 
 示例 2：
 输入：head = [1], n = 1
 输出：[]
 
 示例 3：
 输入：head = [1,2], n = 1
 输出：[1]

 提示：
 链表中结点的数目为 sz
 1 <= sz <= 30
 0 <= Node.val <= 100
 1 <= n <= sz


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/SLwz0R
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

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
        let dummy = ListNode(-1)
        dummy.next = head
        var fast: ListNode? = dummy
        var slow: ListNode? = dummy
        var pos = 0
        while fast != nil, pos <= n {
            fast = fast?.next
            pos += 1
        }
        
        while fast != nil {
            fast = fast?.next
            slow = slow?.next
        }
        
        slow?.next = slow?.next?.next
        
        return dummy.next
    }
}

var head = ListNode(-1)

let node1 = ListNode(1)
let node2 = ListNode(2)
//let node3 = ListNode(3)
//let node4 = ListNode(4)

node1.next = node2
//node2.next = node3
//node3.next = node4

head = node1

let solution = Solution()
var node = solution.removeNthFromEnd(head, 1)
while node != nil {
    print(node ?? "")
    node = node?.next
}

//: [Next](@next)
