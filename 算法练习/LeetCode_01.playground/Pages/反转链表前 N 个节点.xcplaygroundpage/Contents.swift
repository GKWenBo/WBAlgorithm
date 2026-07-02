//: [Previous](@previous)

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    /// 反转链表前 N 个节点（递归法）。
    ///
    /// 递归深入到第 N 个节点时触发 base case：记录第 N+1 个节点为 `successor`
    /// （反转段之后的首个节点），并以第 N 个节点为新头开始回溯。
    /// 回溯阶段每一层完成两件事：
    /// 1. 将下一节点的 `next` 指回当前节点（局部反转）。
    /// 2. 将当前节点的 `next` 指向 `successor`（断开与后续链表的旧连接）。
    ///
    /// - 时间复杂度: O(N)
    /// - 空间复杂度: O(N)，递归调用栈深度等于 N。
    ///
    /// - Parameters:
    ///   - head: 链表头节点，可为 `nil`。
    ///   - n: 需要反转的前 N 个节点数，要求 1 ≤ n ≤ 链表长度。
    /// - Returns: 反转后链表的新头节点。
    ///
    /// - Example:
    ///   ```swift
    ///   // 1 -> 2 -> 3 -> 4 -> 5, n = 3  →  3 -> 2 -> 1 -> 4 -> 5
    ///   let result = Solution().reverseList(buildList([1,2,3,4,5]), 3)
    ///   ```
//    func reverseList(_ head: ListNode?, _ n: Int) -> ListNode? {
//        // 空链表或单节点无需反转
//        guard head != nil, head?.next != nil else {
//            return head
//        }
//
//        var n = n
//        var cur = head          // 当前待处理节点
//        var pre: ListNode? = nil // 已反转部分的新头（初始为 nil，作为反转段的哨兵尾）
//        var next = head?.next   // 提前保存下一节点，防止断链后丢失
//
//        // 依次将前 n 个节点的指针翻转
//        while n > 0 {
//            cur?.next = pre     // 当前节点指向前驱（完成一次局部反转）
//            pre = cur           // pre 前进
//            cur = next          // cur 前进
//            if next != nil {
//                next = next?.next
//            }
//            n -= 1
//        }
//
//        // head 是反转段的尾节点，将其 next 接回第 n+1 个节点（cur 此时指向该节点）
//        head?.next = cur
//        return pre  // pre 是反转段的新头节点
//    }
    
    // 记录反转段之后的第一个节点，回溯时用于接回链表尾部
    var successor: ListNode?

    func reverseList(_ head: ListNode?, _ n: Int) -> ListNode? {
        // base case：到达第 N 个节点
        // 此时 head 就是反转后的新尾节点，保存其后继供回溯使用
        if n == 1 {
            successor = head?.next
            return head
        }

        // 递归处理从第 2 个节点开始的前 n-1 个节点，返回反转段的新头
        let last = reverseList(head?.next, n - 1)
        // 回溯：将下一节点的 next 指回当前节点，完成局部指针反转
        head?.next?.next = head
        // 将当前节点（反转后成为尾节点）接上 successor，断开旧的前向指针
        head?.next = successor
        return last
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

// 测试1：正常情况 — 反转前 3 个节点
// [1,2,3,4,5], n=3  →  [3,2,1,4,5]
let r1 = toArray(solution.reverseList(buildList([1, 2, 3, 4, 5]), 3))
assert(r1 == [3, 2, 1, 4, 5], "测试1失败：\(r1)")
print("测试1通过：[1,2,3,4,5] 前3个反转 → \(r1)")

// 测试2：n = 1，不改变顺序
// [1,2,3], n=1  →  [1,2,3]
let r2 = toArray(solution.reverseList(buildList([1, 2, 3]), 1))
assert(r2 == [1, 2, 3], "测试2失败：\(r2)")
print("测试2通过：[1,2,3] 前1个反转 → \(r2)")

// 测试3：n 等于链表长度，相当于完整反转
// [1,2,3], n=3  →  [3,2,1]
let r3 = toArray(solution.reverseList(buildList([1, 2, 3]), 3))
assert(r3 == [3, 2, 1], "测试3失败：\(r3)")
print("测试3通过：[1,2,3] 前3个反转（全部）→ \(r3)")

// 测试4：单节点链表
// [42], n=1  →  [42]
let r4 = toArray(solution.reverseList(buildList([42]), 1))
assert(r4 == [42], "测试4失败：\(r4)")
print("测试4通过：[42] 前1个反转 → \(r4)")

// 测试5：两节点，反转前 2 个
// [1,2], n=2  →  [2,1]
let r5 = toArray(solution.reverseList(buildList([1, 2]), 2))
assert(r5 == [2, 1], "测试5失败：\(r5)")
print("测试5通过：[1,2] 前2个反转 → \(r5)")

// 测试6：反转前 2 个，后续节点保持不变
// [1,2,3,4,5], n=2  →  [2,1,3,4,5]
let r6 = toArray(solution.reverseList(buildList([1, 2, 3, 4, 5]), 2))
assert(r6 == [2, 1, 3, 4, 5], "测试6失败：\(r6)")
print("测试6通过：[1,2,3,4,5] 前2个反转 → \(r6)")

// 测试7：含负数
// [-3,-2,-1,0,1], n=3  →  [-1,-2,-3,0,1]
let r7 = toArray(solution.reverseList(buildList([-3, -2, -1, 0, 1]), 3))
assert(r7 == [-1, -2, -3, 0, 1], "测试7失败：\(r7)")
print("测试7通过：[-3,-2,-1,0,1] 前3个反转 → \(r7)")

print("\n所有测试通过 ✓")

//: [Next](@next)
