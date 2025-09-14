//: [Previous](@previous)

import Foundation

/*
 82. 删除排序链表中的重复元素 II
 中等
 相关标签
 premium lock icon
 相关企业
 给定一个已排序的链表的头 head ， 删除原始链表中所有重复数字的节点，只留下不同的数字 。返回 已排序的链表 。

 示例 1：

 输入：head = [1,2,3,3,4,4,5]
 输出：[1,2,5]
 示例 2：

 输入：head = [1,1,1,2,3]
 输出：[2,3]
  

 提示：
 链表中节点数目在范围 [0, 300] 内
 -100 <= Node.val <= 100
 题目数据保证链表已经按升序 排列
 
 LeetCode：https://leetcode.cn/problems/remove-duplicates-from-sorted-list-ii/description/
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


/// 通用链表分解
class Solution {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        /// 存储不重复的节点
        var dummyUniq = ListNode(101)
        /// 存储重复的节点
        var dummyDup = ListNode(101)
        var pUniq: ListNode? = dummyUniq
        var pDup: ListNode? = dummyDup
        var p = head
        while p != nil {
            if (p?.next != nil && p?.val == p?.next?.val) || pDup?.val == p?.val { /// 发现重复节点，接到重复节点后面
                pDup?.next = p
                pDup = pDup?.next
            } else { /// 不是重复节点，接到重复节点后面
                pUniq?.next = p
                pUniq = pUniq?.next
            }
            
            p = p?.next
            /// 将原链表和新链表断开
            pDup?.next = nil
            pUniq?.next = nil
        }
        return dummyUniq.next
    }
}


/// 快慢双指针解法
class Solution1 {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var dummy = ListNode(-1)
        var pre: ListNode? = dummy
        var cur = head
        while cur != nil {
            if cur?.next != nil && cur?.val == cur?.next?.val {
                /// 发现重复节点，跳过这些重复节点
                while cur?.next != nil &&  cur?.val == cur?.next?.val {
                    cur = cur?.next
                }
                cur = cur?.next
                /// 此时q跳过了这一段重复元素
                if cur == nil {
                    pre?.next = nil
                }
                /// 不过下一段元素也可能重复，等下一轮 while 循环判断
            } else {
                /// 不是重复节点，接到dummy后面
                pre?.next = cur
                cur = cur?.next
                pre = pre?.next
            }
        }
        return dummy.next
    }
}


/// 递归解法
class Solution2 {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        var head = head
        if head?.val != head?.next?.val { /// 如果头结点和身后节点的值不同，则对之后的链表去重即可
            head?.next = deleteDuplicates(head?.next)
        }
        // 如果如果头结点和身后节点的值相同，则说明从 head 开始存在若干重复节点
        // 越过重复节点，找到 head 之后那个不重复的节点
        while head?.next != nil && head?.val == head?.next?.val {
            head = head?.next
        }
        // 直接返回那个不重复节点开头的链表的去重结果，就把重复节点删掉了
        return deleteDuplicates(head?.next)
    }
}

//: [Next](@next)
