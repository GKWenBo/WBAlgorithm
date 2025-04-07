//: [Previous](@previous)

/*
 将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。

 示例 1：

 输入：l1 = [1,2,4], l2 = [1,3,4]
 输出：[1,1,2,3,4,4]
 示例 2：

 输入：l1 = [], l2 = []
 输出：[]
 示例 3：

 输入：l1 = [], l2 = [0]
 输出：[0]
  
 提示：
 两个链表的节点数目范围是 [0, 50]
 -100 <= Node.val <= 100
 l1 和 l2 均按 非递减顺序 排列

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-two-sorted-lists
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/*
 双指针迭代法
 */
class Solution {
    /// 双指针迭代法
    /// - Parameters:
    ///   - l1: 链表1
    ///   - l2: 链表2
    /// - Returns: 合并之后的链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        /// 利用哨兵节点简化实现难度
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
        /// 链接剩余未合并的链表节点
        cur?.next = p1 ?? p2
        return dum.next
    }
}

/*
 递归法
 */
class Solution1 {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
    
        if l1!.val < l2!.val {
            l1?.next = mergeTwoLists(l1?.next, l2)
            return                                                               l1
        } else {
            l2?.next = mergeTwoLists(l1, l2?.next)
            return l2
        }
    }
}

//: [Next](@next)
