//: [Previous](@previous)

/*
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
 请你将两个数相加，并以相同形式返回一个表示和的链表。
 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
  
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


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else {
            return l2
        }
        
        guard let l2 = l2 else {
            return l1
        }

        let outputNode = ListNode((l1.val + l2.val) % 10)
        if l1.val + l2.val > 9 {
            outputNode.next = addTwoNumbers(addTwoNumbers(l1.next, l2.next), ListNode(1))
        } else {
            outputNode.next = addTwoNumbers(l1.next, l2.next)
        }
        return outputNode
    }
}


// test
var l1 = ListNode(2)
var l1_1 = ListNode(4)
l1.next = l1_1
var l1_2 = ListNode(3)
l1_1.next = l1_2


var l2 = ListNode(5)
var l2_1 = ListNode(6)
l2.next = l2_1
var l2_2 = ListNode(4)
l2_1.next = l2_2

let s = Solution()
var res = s.addTwoNumbers(l1, l2)
while res != nil {
    print(res?.val as Any)
    res = res?.next
}

//: [Next](@next)
