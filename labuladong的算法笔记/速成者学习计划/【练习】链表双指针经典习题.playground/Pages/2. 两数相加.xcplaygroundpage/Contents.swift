//: [Previous](@previous)

import Foundation

/*
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。

 请你将两个数相加，并以相同形式返回一个表示和的链表。

 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

 示例 1：


 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.
 示例 2：

 输入：l1 = [0], l2 = [0]
 输出：[0]
 示例 3：

 输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 输出：[8,9,9,9,0,0,0,1]
  

 提示：

 每个链表中的节点数在范围 [1, 100] 内
 0 <= Node.val <= 9
 题目数据保证列表表示的数字不含前导零
 
 LeetCode：http://leetcode.cn/problems/add-two-numbers/description/
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        /// 虚拟头结点
        var dummy: ListNode? = ListNode(-1)
        /// 在两条链表上的指针
        var p1 = l1
        var p2 = l2
        var p = dummy
        /// // 记录进位
        var carry = 0
        /// 开始执行加法，两条链表走完且没有进位时才能结束循环
        while p1 != nil || p2 != nil || carry > 0 {
            var value = carry
            if p1 != nil {
                value += p1!.val
                p1 = p1?.next
            }
            if p2 != nil {
                value += p2!.val
                p2 = p2?.next
            }
            /// 计算进位
            carry = value / 10
            value = value % 10
            
            /// 构建新节点
            let node = ListNode(value)
            p?.next = node
            p = p?.next
        }
        return dummy?.next
    }
}

//: [Next](@next)
