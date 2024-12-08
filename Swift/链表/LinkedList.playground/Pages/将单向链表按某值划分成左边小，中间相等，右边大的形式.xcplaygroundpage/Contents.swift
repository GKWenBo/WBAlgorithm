//: [Previous](@previous)

import Foundation

/*
 【进阶】在实现原有功能的基础上增加如下要求
 【要求】调整后所有小于pivot的节点之间的相对顺序和调整前一样
 【要求】调整后所有等于pivot的节点之间的相对顺序和调整前一样
 【要求】调整后所有大于pivot的节点之间的相对顺序和调整前一样
 【要求】时间复杂度是O(N)，额外空间复杂度请达到O(1)
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func listPartition(_ head: ListNode?, pivot: Int) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        var sH: ListNode? = nil
        var sT: ListNode? = nil
        var eH: ListNode? = nil
        var eT: ListNode? = nil
        var mH: ListNode? = nil
        var mT: ListNode? = nil
        var head = head
        var next: ListNode? = nil
        while let h = head {
            next = head?.next
            head?.next = nil
            if h.val < pivot { /// 小于分区节点
                if sH == nil {
                    sH = h
                    sT = h
                } else  {
                    sT?.next = h
                    sT = h
                }
            } else if h.val == pivot {
                if eH == nil {
                    eH = h
                    eT = h
                } else {
                    eT?.next = h
                    eT = h
                }
            } else { /// 大于分区
                if mH == nil {
                    mH = h
                    mT = h
                } else {
                    mT?.next = h
                    mT = h
                }
            }
            head = next
        }
        
        if let sT { /// 如果有小于区
            sT.next = eH
            eT = eT == nil ? sT : eT // 下一步，谁去连大于区域的头，谁就变成eT
        }
        if let eT {
            eT.next = mH
        }
        return sH != nil ? sH : (eH != nil ? eH : mH)
    }
}


func printListNode(_ head: ListNode?) {
    guard head != nil else {
        return
    }
    printListNode(head?.next)
    print(head?.val ?? 0)
}

// Test
let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(2)
let node4 = ListNode(1)
let node5 = ListNode(0)

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5

let head = Solution().listPartition(node1, pivot: 0)
printListNode(head)

//: [Next](@next)
