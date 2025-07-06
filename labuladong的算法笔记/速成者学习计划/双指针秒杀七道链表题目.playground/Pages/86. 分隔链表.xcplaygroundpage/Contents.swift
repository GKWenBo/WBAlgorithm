import Foundation

/*
 LeetCode: https://leetcode.cn/problems/partition-list/description/
 
 给你一个链表的头节点 head 和一个特定值 x ，请你对链表进行分隔，使得所有 小于 x 的节点都出现在 大于或等于 x 的节点之前。

 你应当 保留 两个分区中每个节点的初始相对位置。
 
 示例 1：


 输入：head = [1,4,3,2,5,2], x = 3
 输出：[1,2,2,4,3,5]
 示例 2：

 输入：head = [2,1], x = 2
 输出：[1,2]
  

 提示：

 链表中节点的数目在范围 [0, 200] 内
 -100 <= Node.val <= 100
 -200 <= x <= 200
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
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        /// 创建虚拟头节点，存放小于x的节点
        var dumpy1 = ListNode(-1)
        /// 存放大于等于x的节点
        var dumpy2 = ListNode(-1)
        /// p1,p2指针负责生成结果链表
        var p1: ListNode? = dumpy1
        var p2: ListNode? = dumpy2
        /// p负责遍历原链表，类似合并两个有序链表逻辑
        var p = head
        while p != nil {
            if p!.val < x {
                p1?.next = p
                p1 = p1?.next
            } else {
                p2?.next = p
                p2 = p2?.next
            }
            
            /// 不能直接让p指针前进
            /// p = p.next
            /// 断开原链表中的每个节点的next指针
            let temp = p?.next
            p?.next = nil
            p = temp
        }
        
        p1?.next = dumpy2.next
        
        return dumpy1.next
    }
}
