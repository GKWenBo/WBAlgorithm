import UIKit

/*
 LeetCode：http://leetcode.cn/problems/remove-nth-node-from-end-of-list/description/
 
 给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。

 示例 1：


 输入：head = [1,2,3,4,5], n = 2
 输出：[1,2,3,5]
 示例 2：

 输入：head = [1], n = 1
 输出：[]
 示例 3：

 输入：head = [1,2], n = 1
 输出：[1]
  

 提示：

 链表中结点的数目为 sz
 1 <= sz <= 30
 0 <= Node.val <= 100
 1 <= n <= sz
  

 进阶：你能尝试使用一趟扫描实现吗？
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
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard head != nil else {
            return head
        }

        var dummy = ListNode(-1)
        dummy.next = head

        /// 找到倒数n + 1个节点，从 dummy 出发才能覆盖删除头节点的情况
        var deletePreNode = trainingPlan(dummy, n + 1)
        deletePreNode?.next = deletePreNode?.next?.next
        return dummy.next
    }

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

// MARK: - 测试辅助

/// 数组 → 链表
func makeList(_ vals: [Int]) -> ListNode? {
    let dummy = ListNode(-1)
    var cur: ListNode? = dummy
    for v in vals {
        let node = ListNode(v)
        cur?.next = node
        cur = node
    }
    return dummy.next
}

/// 链表 → 数组
func toArray(_ head: ListNode?) -> [Int] {
    var result: [Int] = []
    var cur = head
    while let node = cur {
        result.append(node.val)
        cur = node.next
    }
    return result
}

/// 简单断言，失败时打印具体信息
func assertEqual(_ actual: [Int], _ expected: [Int], _ caseName: String) {
    if actual == expected {
        print("✅ \(caseName) 通过 → \(actual)")
    } else {
        print("❌ \(caseName) 失败 → 期望 \(expected)，实际 \(actual)")
    }
}

// MARK: - 测试用例

let sol = Solution()

// 示例 1：[1,2,3,4,5] 删除倒数第 2 个 → [1,2,3,5]
assertEqual(
    toArray(sol.removeNthFromEnd(makeList([1,2,3,4,5]), 2)),
    [1,2,3,5],
    "示例1 普通删除中间节点"
)

// 示例 2：[1] 删除倒数第 1 个 → []
assertEqual(
    toArray(sol.removeNthFromEnd(makeList([1]), 1)),
    [],
    "示例2 单节点删除后为空"
)

// 示例 3：[1,2] 删除倒数第 1 个 → [1]
assertEqual(
    toArray(sol.removeNthFromEnd(makeList([1,2]), 1)),
    [1],
    "示例3 删除尾节点"
)

// 删除头节点：[1,2,3] 删除倒数第 3 个 → [2,3]
assertEqual(
    toArray(sol.removeNthFromEnd(makeList([1,2,3]), 3)),
    [2,3],
    "删除头节点"
)

// 删除尾节点：[1,2,3,4,5] 删除倒数第 1 个 → [1,2,3,4]
assertEqual(
    toArray(sol.removeNthFromEnd(makeList([1,2,3,4,5]), 1)),
    [1,2,3,4],
    "删除尾节点（5元素）"
)

// 删除头节点：[1,2,3,4,5] 删除倒数第 5 个 → [2,3,4,5]
assertEqual(
    toArray(sol.removeNthFromEnd(makeList([1,2,3,4,5]), 5)),
    [2,3,4,5],
    "删除头节点（5元素）"
)

// 两节点删除第一个：[1,2] 删除倒数第 2 个 → [2]
assertEqual(
    toArray(sol.removeNthFromEnd(makeList([1,2]), 2)),
    [2],
    "两节点删除头节点"
)
