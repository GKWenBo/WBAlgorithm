//: [Previous](@previous)

import Foundation

/*
 给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。



 示例 1：


 输入：head = [1,2,3,4]
 输出：[2,1,4,3]
 示例 2：

 输入：head = []
 输出：[]
 示例 3：

 输入：head = [1]
 输出：[1]


 提示：

 链表中节点的数目在范围 [0, 100] 内
 0 <= Node.val <= 100

 LeetCode: https://leetcode.cn/problems/swap-nodes-in-pairs/description/
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
    /// 递归地两两交换节点：将当前组（2个节点）反转后，尾节点接上下一组的递归结果
    func swapPairs(_ head: ListNode?) -> ListNode? {
        guard head != nil else { return head }

        let a = head   // a 将成为反转后当前组的尾节点（原头节点）
        var b = head

        // 找到下一组的起始节点；若不足 2 个节点则直接返回
        for _ in 0..<2 {
            if b == nil {
                return head
            }
            b = b?.next
        }

        let newHead = reverseN(head, 2)   // 反转当前组的 2 个节点
        a?.next = swapPairs(b)            // 原头节点成为尾，接上后续递归结果
        return newHead
    }

    /// 反转链表前 n 个节点，并将第 n 个节点的 next 指向第 n+1 个节点（保留后续链表）
    func reverseN(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }

        var n = n
        var cur = head
        var pre: ListNode? = nil
        var next = head?.next
        while n > 0 {
            cur?.next = pre
            pre = cur
            cur = next

            if next != nil {
                next = next?.next
            }

            n -= 1
        }

        // head 此时是反转段的尾节点，将其 next 指向反转段之后的第一个节点
        head?.next = cur
        return pre
    }
}

// MARK: - Test Helpers

func makeList(_ vals: [Int]) -> ListNode? {
    let dummy = ListNode(0)
    var cur: ListNode? = dummy
    for val in vals {
        cur?.next = ListNode(val)
        cur = cur?.next
    }
    return dummy.next
}

func toArray(_ head: ListNode?) -> [Int] {
    var result: [Int] = []
    var cur = head
    while let node = cur {
        result.append(node.val)
        cur = node.next
    }
    return result
}

// MARK: - Tests

let solution = Solution()
var passCount = 0
var failCount = 0

@MainActor func check(_ input: [Int], _ expected: [Int], _ desc: String) {
    let result = toArray(solution.swapPairs(makeList(input)))
    if result == expected {
        passCount += 1
        print("✅ PASS  \(desc)")
    } else {
        failCount += 1
        print("❌ FAIL  \(desc)")
        print("        输入:    \(input)")
        print("        期望:    \(expected)")
        print("        实际:    \(result)")
    }
}

check([1, 2, 3, 4],    [2, 1, 4, 3],    "偶数长度 [1,2,3,4]")
check([],              [],               "空链表 []")
check([1],             [1],              "单节点 [1]")
check([1, 2],          [2, 1],           "两节点 [1,2]")
check([1, 2, 3],       [2, 1, 3],        "奇数长度 [1,2,3]")
check([1, 2, 3, 4, 5], [2, 1, 4, 3, 5], "五节点 [1,2,3,4,5]")
check([0, 0, 0],       [0, 0, 0],        "全零 [0,0,0]")
check([100, 99],       [99, 100],        "最大值 [100,99]")

print("\n\(passCount) passed, \(failCount) failed")

//: [Next](@next)
