//: [Previous](@previous)

import Foundation

/*
 给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
 
 示例 1：
 
 输入：head = [1,2,3,4,5]
 输出：[5,4,3,2,1]
 示例 2：
 
 
 输入：head = [1,2]
 输出：[2,1]
 示例 3：
 
 输入：head = []
 输出：[]
 
 
 提示：
 
 链表中节点的数目范围是 [0, 5000]
 -5000 <= Node.val <= 5000
 
 
 进阶：链表可以选用迭代或递归方式完成反转。你能否用两种方法解决这道题？
 
 LeetCode：https://leetcode.cn/problems/reverse-linked-list/description/
 */


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
//    func reverseList(_ head: ListNode?) -> ListNode? {
//        guard head != nil, head?.next != nil else { return head }
//        
//        var cur = head
//        var pre: ListNode? = nil
//        var next = head?.next
//        while cur != nil {
//            cur?.next = pre
//            pre = cur
//            cur = next
//            if next != nil {
//                next = next?.next
//            }
//        }
//        return pre
//    }
    
    /// 递归反转单链表。
    ///
    /// 递归到链表尾部后，在回溯阶段将每个节点的 `next` 指向前驱节点，
    /// 并断开原有的前向指针，从而完成整体反转。
    ///
    /// - 时间复杂度: O(n)，其中 n 为链表节点数。
    /// - 空间复杂度: O(n)，递归调用栈深度等于链表长度。
    ///
    /// - Parameter head: 待反转链表的头节点，可为 `nil`。
    /// - Returns: 反转后链表的新头节点；若原链表为空或只含一个节点，则原样返回。
    ///
    /// - Example:
    ///   ```swift
    ///   // 1 -> 2 -> 3 -> nil  反转后  3 -> 2 -> 1 -> nil
    ///   let result = Solution().reverseList(buildList([1, 2, 3]))
    ///   ```
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }

        let last = reverseList(head?.next)
        head?.next?.next = head
        head?.next = nil
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

// 测试1：[1,2,3,4,5] → [5,4,3,2,1]
let r1 = toArray(solution.reverseList(buildList([1, 2, 3, 4, 5])))
assert(r1 == [5, 4, 3, 2, 1], "测试1失败：\(r1)")
print("测试1通过：[1,2,3,4,5] → \(r1)")

// 测试2：[1,2] → [2,1]
let r2 = toArray(solution.reverseList(buildList([1, 2])))
assert(r2 == [2, 1], "测试2失败：\(r2)")
print("测试2通过：[1,2] → \(r2)")

// 测试3：空链表 → []
let r3 = toArray(solution.reverseList(nil))
assert(r3 == [], "测试3失败：\(r3)")
print("测试3通过：[] → \(r3)")

// 测试4：单节点 [1] → [1]
let r4 = toArray(solution.reverseList(buildList([1])))
assert(r4 == [1], "测试4失败：\(r4)")
print("测试4通过：[1] → \(r4)")

// 测试5：两个相同值 [7,7] → [7,7]
let r5 = toArray(solution.reverseList(buildList([7, 7])))
assert(r5 == [7, 7], "测试5失败：\(r5)")
print("测试5通过：[7,7] → \(r5)")

// 测试6：含负数 [-1,0,1] → [1,0,-1]
let r6 = toArray(solution.reverseList(buildList([-1, 0, 1])))
assert(r6 == [1, 0, -1], "测试6失败：\(r6)")
print("测试6通过：[-1,0,1] → \(r6)")

print("\n所有测试通过 ✓")

//: [Next](@next)
