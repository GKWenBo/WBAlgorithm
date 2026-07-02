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
        var fast = head
        var slow = head
        for _ in 0..<cnt { fast = fast?.next }
        while fast != nil {
            fast = fast?.next
            slow = slow?.next
        }
        return slow
    }
}

// MARK: - Test Helpers

func makeList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    let dummy = ListNode(0)
    var cur: ListNode? = dummy
    for v in values {
        cur?.next = ListNode(v)
        cur = cur?.next
    }
    return dummy.next
}

// MARK: - Tests

let solution = Solution()

// [2,4,7,8], cnt=1 → 8
assert(solution.trainingPlan(makeList([2,4,7,8]), 1)?.val == 8, "Test 1 failed")

// [2,4,7,8], cnt=2 → 7
assert(solution.trainingPlan(makeList([2,4,7,8]), 2)?.val == 7, "Test 2 failed")

// [2,4,7,8], cnt=4 → 2（倒数第4个，即第一个节点）
assert(solution.trainingPlan(makeList([2,4,7,8]), 4)?.val == 2, "Test 3 failed")

// 单节点链表，cnt=1 → 该节点本身
assert(solution.trainingPlan(makeList([5]), 1)?.val == 5, "Test 4 failed")

// [1,2,3,4,5], cnt=3 → 3
assert(solution.trainingPlan(makeList([1,2,3,4,5]), 3)?.val == 3, "Test 5 failed")

print("All tests passed ✓")

//: [Next](@next)
