//: [Previous](@previous)

import Foundation

/*
 LeetCode: https://leetcode.cn/problems/middle-of-the-linked-list/
 
 给你单链表的头结点 head ，请你找出并返回链表的中间结点。

 如果有两个中间结点，则返回第二个中间结点。
  

 示例 1：


 输入：head = [1,2,3,4,5]
 输出：[3,4,5]
 解释：链表只有一个中间结点，值为 3 。
 示例 2：


 输入：head = [1,2,3,4,5,6]
 输出：[4,5,6]
 解释：该链表有两个中间结点，值分别为 3 和 4 ，返回第二个结点。
  

 提示：

 链表的结点数范围是 [1, 100]
 1 <= Node.val <= 100
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
    
    /// 使用快慢指针
    func middleNode(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
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

func assertEqual(_ got: [Int], _ expected: [Int], _ caseName: String) {
    if got == expected {
        print("✅ \(caseName) passed: \(got)")
    } else {
        print("❌ \(caseName) FAILED: got \(got), expected \(expected)")
    }
}

// 单个节点
let case1 = toArray(solution.middleNode(makeList([1])))
assertEqual(case1, [1], "单节点")

// 奇数长度 [1,2,3,4,5] → 中间为 3
let case2 = toArray(solution.middleNode(makeList([1, 2, 3, 4, 5])))
assertEqual(case2, [3, 4, 5], "奇数长度5")

// 偶数长度 [1,2,3,4,5,6] → 返回第二个中间节点 4
let case3 = toArray(solution.middleNode(makeList([1, 2, 3, 4, 5, 6])))
assertEqual(case3, [4, 5, 6], "偶数长度6")

// 两个节点 [1,2] → 返回第二个节点
let case4 = toArray(solution.middleNode(makeList([1, 2])))
assertEqual(case4, [2], "两个节点")

// 三个节点 [1,2,3] → 中间为 2
let case5 = toArray(solution.middleNode(makeList([1, 2, 3])))
assertEqual(case5, [2, 3], "奇数长度3")

// 四个节点 [1,2,3,4] → 返回第二个中间节点 3
let case6 = toArray(solution.middleNode(makeList([1, 2, 3, 4])))
assertEqual(case6, [3, 4], "偶数长度4")

//: [Next](@next)
