//: [Previous](@previous)

import Foundation

/*
 给定两个 非空链表 l1和 l2 来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储一位数字。将这两数相加会返回一个新的链表。
 可以假设除了数字 0 之外，这两个数字都不会以零开头。

 示例 1：



 输入：l1 = [7,2,4,3], l2 = [5,6,4]
 输出：[7,8,0,7]
 示例 2：

 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[8,0,7]
 示例 3：

 输入：l1 = [0], l2 = [0]
 输出：[0]
  

 提示：

 链表的长度范围为 [1, 100]
 0 <= node.val <= 9
 输入数据保证链表代表的数字无前导 0
  

 进阶：如果输入链表不能修改该如何处理？换句话说，不能对列表中的节点进行翻转。
 
 LeetCode：https://leetcode.cn/problems/lMSNwu/description/

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
        var l1 = l1, l2 = l2
        var stack1: [Int] = []
        var stack2: [Int] = []
        /// 虚拟头节点
        var dummy: ListNode? = ListNode(-1)
        var p = dummy
        /// 将单链表节点值入栈
        while let val = l1?.val {
            stack1.append(val)
            l1 = l1?.next
        }
        while let val = l2?.val {
            stack2.append(val)
            l2 = l2?.next
        }
        
        /// 记录进位
        var carry = 0
        
        /// 开始执行加法，两条链表走完且没有进位时才能结束循环
        while !stack1.isEmpty || !stack2.isEmpty || carry > 0 {
            var value = carry
            if let val = stack1.popLast() {
                value += val
            }
            
            if let val = stack2.popLast() {
                value += val
            }
            /// 处理进位情况
            carry = value / 10
            value = value % 10
            let newNode = ListNode(value)
            newNode.next = p?.next
            
            p?.next = newNode
        }
        return dummy?.next
    }
}



//: [Next](@next)
