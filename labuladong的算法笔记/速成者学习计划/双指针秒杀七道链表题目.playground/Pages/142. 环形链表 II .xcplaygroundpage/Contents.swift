//: [Previous](@previous)

import Foundation

/*
 LeetCode：https://leetcode.cn/problems/linked-list-cycle-ii/description/
 
 给定一个链表的头节点  head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。

 如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。如果 pos 是 -1，则在该链表中没有环。注意：pos 不作为参数进行传递，仅仅是为了标识链表的实际情况。

 不允许修改 链表。

 示例 1：


 输入：head = [3,2,0,-4], pos = 1
 输出：返回索引为 1 的链表节点
 解释：链表中有一个环，其尾部连接到第二个节点。
 示例 2：



 输入：head = [1,2], pos = 0
 输出：返回索引为 0 的链表节点
 解释：链表中有一个环，其尾部连接到第一个节点。
 示例 3：


 输入：head = [1], pos = -1
 输出：返回 null
 解释：链表中没有环。

 提示：

 链表中节点的数目范围在范围 [0, 104] 内
 -105 <= Node.val <= 105
 pos 的值为 -1 或者链表中的一个有效索引
  
 进阶：你是否可以使用 O(1) 空间解决此题？
 
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
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            
            if slow === fast {
                break
            }
        }
        
        if fast == nil || fast?.next == nil { // fast遇到空指针，说明没有环
            return nil
        }
        
        // 重新指向头结点
        slow = head
        while slow !== fast {
            // 快慢指针同步前进，相交点就是环起点
            slow = slow?.next
            fast = fast?.next
        }
        return slow
    }
}

//: [Next](@next)
