//: [Previous](@previous)

import Foundation

/*
 给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。
 
 
 示例 1：
 
 
 输入：head = [1,2,3,4,5], left = 2, right = 4
 输出：[1,4,3,2,5]
 示例 2：
 
 输入：head = [5], left = 1, right = 1
 输出：[5]
 
 
 提示：
 
 链表中节点数目为 n
 1 <= n <= 500
 -500 <= Node.val <= 500
 1 <= left <= right <= n
 
 LeetCode: https://leetcode.cn/problems/reverse-linked-list-ii/description/
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {

    /// 反转链表第 `left` 到第 `right` 位置之间的节点。
    ///
    /// 将问题转化为「反转前 N 个节点」：
    /// - 若 `left == 1`，直接对整个链表调用 `reverseList(_:_:)` 反转前 `right` 个节点。
    /// - 否则，先走 `left - 2` 步找到第 `left - 1` 个节点（反转段的前驱），
    ///   再对其后继调用 `reverseList(_:_:)` 反转 `right - left + 1` 个节点，
    ///   最后将前驱的 `next` 接上反转结果。
    ///
    /// - 时间复杂度: O(n)
    /// - 空间复杂度: O(1)
    ///
    /// - Parameters:
    ///   - head: 链表头节点，可为 `nil`。
    ///   - left: 反转起始位置（1-indexed），满足 1 ≤ left ≤ right。
    ///   - right: 反转结束位置（1-indexed），满足 left ≤ right ≤ 链表长度。
    /// - Returns: 反转后链表的头节点。
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        // 反转段从头部开始，直接复用 reverseList
        if left == 1 {
            return reverseList(head, right)
        }

        // 走到第 left-1 个节点（反转段的前驱），循环执行 left-2 次
        var pre = head
        for _ in 1..<left - 1 {
            pre = pre?.next
        }
        // 对从第 left 个节点起的 (right - left + 1) 个节点执行反转，并接回前驱
        pre?.next = reverseList(pre?.next, right - left + 1)
        return head
    }

    /// 反转链表前 `n` 个节点（迭代法），辅助函数。
    ///
    /// 使用三指针（`pre`、`cur`、`next`）在原地翻转前 `n` 个节点，
    /// 反转完成后将原头节点（此时已成为尾节点）的 `next` 接回第 `n+1` 个节点。
    ///
    /// - Parameters:
    ///   - head: 待反转子链表的头节点。
    ///   - n: 需要反转的节点数，要求 1 ≤ n ≤ 子链表长度。
    /// - Returns: 反转后子链表的新头节点。
    func reverseList(_ head: ListNode?, _ n: Int) -> ListNode? {
        // 空链表或单节点无需反转
        guard head != nil, head?.next != nil else {
            return head
        }

        var n = n
        var cur = head           // 当前待处理节点
        var pre: ListNode? = nil // 已反转部分的新头（初始 nil 作为反转段哨兵尾）
        var next = head?.next    // 提前保存下一节点，防止断链后丢失

        // 依次将前 n 个节点的指针翻转
        while n > 0 {
            cur?.next = pre      // 当前节点指向前驱，完成一次局部反转
            pre = cur            // pre 前进
            cur = next           // cur 前进
            if next != nil {
                next = next?.next
            }
            n -= 1
        }

        // head 已成为反转段尾节点，将其 next 接回第 n+1 个节点
        head?.next = cur
        return pre               // pre 是反转段的新头节点
    }
}

// MARK: - Test Helpers

func buildList(_ vals: [Int]) -> ListNode? {
    guard !vals.isEmpty else { return nil }
    let dummy = ListNode(0)
    var cur: ListNode? = dummy
    for v in vals {
        cur?.next = ListNode(v)
        cur = cur?.next
    }
    return dummy.next
}

func toArray(_ head: ListNode?) -> [Int] {
    var result: [Int] = []
    var node = head
    while let n = node {
        result.append(n.val)
        node = n.next
    }
    return result
}

// MARK: - Tests

let solution = Solution()

// 测试1：题目示例 — 反转中间段
// [1,2,3,4,5], left=2, right=4  →  [1,4,3,2,5]
let r1 = toArray(solution.reverseBetween(buildList([1, 2, 3, 4, 5]), 2, 4))
assert(r1 == [1, 4, 3, 2, 5], "测试1失败：\(r1)")
print("测试1通过：[1,2,3,4,5] left=2 right=4 → \(r1)")

// 测试2：left == right，无需反转
// [1,2,3,4,5], left=3, right=3  →  [1,2,3,4,5]
let r2 = toArray(solution.reverseBetween(buildList([1, 2, 3, 4, 5]), 3, 3))
assert(r2 == [1, 2, 3, 4, 5], "测试2失败：\(r2)")
print("测试2通过：[1,2,3,4,5] left=3 right=3（无变化）→ \(r2)")

// 测试3：left == 1，从头部开始反转
// [1,2,3,4,5], left=1, right=3  →  [3,2,1,4,5]
let r3 = toArray(solution.reverseBetween(buildList([1, 2, 3, 4, 5]), 1, 3))
assert(r3 == [3, 2, 1, 4, 5], "测试3失败：\(r3)")
print("测试3通过：[1,2,3,4,5] left=1 right=3 → \(r3)")

// 测试4：right == 链表长度，反转到尾部
// [1,2,3,4,5], left=3, right=5  →  [1,2,5,4,3]
let r4 = toArray(solution.reverseBetween(buildList([1, 2, 3, 4, 5]), 3, 5))
assert(r4 == [1, 2, 5, 4, 3], "测试4失败：\(r4)")
print("测试4通过：[1,2,3,4,5] left=3 right=5 → \(r4)")

// 测试5：left=1 且 right==链表长度，相当于完整反转
// [1,2,3,4,5], left=1, right=5  →  [5,4,3,2,1]
let r5 = toArray(solution.reverseBetween(buildList([1, 2, 3, 4, 5]), 1, 5))
assert(r5 == [5, 4, 3, 2, 1], "测试5失败：\(r5)")
print("测试5通过：[1,2,3,4,5] left=1 right=5（全部反转）→ \(r5)")

// 测试6：单节点链表（题目示例2）
// [5], left=1, right=1  →  [5]
let r6 = toArray(solution.reverseBetween(buildList([5]), 1, 1))
assert(r6 == [5], "测试6失败：\(r6)")
print("测试6通过：[5] left=1 right=1 → \(r6)")

// 测试7：两节点链表，反转全部
// [1,2], left=1, right=2  →  [2,1]
let r7 = toArray(solution.reverseBetween(buildList([1, 2]), 1, 2))
assert(r7 == [2, 1], "测试7失败：\(r7)")
print("测试7通过：[1,2] left=1 right=2 → \(r7)")

// 测试8：含负数
// [-1,-2,-3,-4,-5], left=2, right=4  →  [-1,-4,-3,-2,-5]
let r8 = toArray(solution.reverseBetween(buildList([-1, -2, -3, -4, -5]), 2, 4))
assert(r8 == [-1, -4, -3, -2, -5], "测试8失败：\(r8)")
print("测试8通过：[-1,-2,-3,-4,-5] left=2 right=4 → \(r8)")

print("\n所有测试通过 ✓")

//: [Next](@next)
