//: [Previous](@previous)

import Foundation

/*
 LeetCode：https://leetcode.cn/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof/description/
 给定一个头节点为 head 的链表用于记录一系列核心肌群训练项目编号，请查找并返回倒数第 cnt 个训练项目编号。
 
 示例 1：

 输入：head = [2,4,7,8], cnt = 1
 输出：8
  

 提示：

 1 <= head.length <= 100
 0 <= head[i] <= 100
 1 <= cnt <= head.length

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
    /// 双指针解法，时间复杂度O（N）
    func trainingPlan(_ head: ListNode?, _ cnt: Int) -> ListNode? {
        guard head != nil else { return nil }
        var p1 = head
        var p2 = head
        /// p1先走k步
        for _ in 0..<cnt {
            p1 = p1?.next
        }
        
        /// p1 和 p2同时走n - k步
        while p1 != nil {
            p1 = p1?.next
            p2 = p2?.next
        }
        // p2 现在指向第 n - k + 1 个节点，即倒数第 k 个节点
        return p2
    }
}

//: [Next](@next)
