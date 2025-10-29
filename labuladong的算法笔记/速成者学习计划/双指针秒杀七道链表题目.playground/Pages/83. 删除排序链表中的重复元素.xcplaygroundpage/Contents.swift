//: [Previous](@previous)

import Foundation

/*
 给定一个已排序的链表的头 head ， 删除所有重复的元素，使每个元素只出现一次 。返回 已排序的链表 。

 示例 1：


 输入：head = [1,1,2]
 输出：[1,2]
 示例 2：


 输入：head = [1,1,2,3,3]
 输出：[1,2,3]

 提示：

 链表中节点数目在范围 [0, 300] 内
 -100 <= Node.val <= 100
 题目数据保证链表已经按升序 排列
 */

/// 单链表节点
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard head != nil else {
            return head
        }
        var slow = head, fast = head
        while fast != nil {
            if fast?.val != slow?.val {
                slow?.next = fast
                
                /// slow++
                slow = slow?.next
            }
            fast = fast?.next
        }
        /// 断掉无用链接节点
        slow?.next = nil
        return head
    }
}

//: [Next](@next)
