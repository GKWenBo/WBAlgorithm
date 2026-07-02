//: [Previous](@previous)

import Foundation

/*
 LeetCode：https://leetcode.cn/problems/linked-list-cycle-ii/description/
 
 给定一个链表的头节点  head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。

 如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。如果 pos 是 -1，则在该链表中没有环。注意：pos 不作为参数进行传递，仅仅是为了标识链表的实际情况。

 不允许修改 链表。

 示例 1：


 输入：head = [3,2,0,-4], pos = 1
 输出：返回索引为 1 的链表节点
 解释：链表中有一个环，其尾部连接到第二个节点。
 示例 2：



 输入：head = [1,2], pos = 0
 输出：返回索引为 0 的链表节点
 解释：链表中有一个环，其尾部连接到第一个节点。
 示例 3：


 输入：head = [1], pos = -1
 输出：返回 null
 解释：链表中没有环。

 提示：

 链表中节点的数目范围在范围 [0, 104] 内
 -105 <= Node.val <= 105
 pos 的值为 -1 或者链表中的一个有效索引
  
 进阶：你是否可以使用 O(1) 空间解决此题？
 
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
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            
            if slow === fast {
                break
            }
        }
        
        if fast == nil || fast?.next == nil {
            return nil
        }
        
        slow = head
        while slow !== fast {
            slow = slow?.next
            fast = fast?.next
        }
        return slow
    }
}

// MARK: - Test Helpers

/// 构建带环链表，pos 为尾节点连接的索引（-1 表示无环）
func buildLinkedList(_ vals: [Int], pos: Int) -> ListNode? {
    guard !vals.isEmpty else { return nil }
    let nodes = vals.map { ListNode($0) }
    for i in 0..<nodes.count - 1 {
        nodes[i].next = nodes[i + 1]
    }
    if pos >= 0 && pos < nodes.count {
        nodes[nodes.count - 1].next = nodes[pos]
    }
    return nodes[0]
}

// MARK: - Tests

let solution = Solution()

// 测试1：head = [3,2,0,-4], pos = 1 → 入环节点 val = 2
let head1 = buildLinkedList([3, 2, 0, -4], pos: 1)
let result1 = solution.detectCycle(head1)
assert(result1?.val == 2, "测试1失败：期望 val=2，实际 \(String(describing: result1?.val))")
print("测试1通过：入环节点 val = \(result1!.val)")

// 测试2：head = [1,2], pos = 0 → 入环节点 val = 1
let head2 = buildLinkedList([1, 2], pos: 0)
let result2 = solution.detectCycle(head2)
assert(result2?.val == 1, "测试2失败：期望 val=1，实际 \(String(describing: result2?.val))")
print("测试2通过：入环节点 val = \(result2!.val)")

// 测试3：head = [1], pos = -1 → 无环，返回 nil
let head3 = buildLinkedList([1], pos: -1)
let result3 = solution.detectCycle(head3)
assert(result3 == nil, "测试3失败：期望 nil，实际 \(String(describing: result3?.val))")
print("测试3通过：无环，返回 nil")

// 测试4：空链表 → 返回 nil
let result4 = solution.detectCycle(nil)
assert(result4 == nil, "测试4失败：期望 nil")
print("测试4通过：空链表，返回 nil")

// 测试5：单节点自环，pos = 0 → 入环节点 val = 1
let head5 = buildLinkedList([1], pos: 0)
let result5 = solution.detectCycle(head5)
assert(result5?.val == 1, "测试5失败：期望 val=1，实际 \(String(describing: result5?.val))")
print("测试5通过：单节点自环，入环节点 val = \(result5!.val)")

// 测试6：较长链表，head = [1,2,3,4,5,6], pos = 2 → 入环节点 val = 3
let head6 = buildLinkedList([1, 2, 3, 4, 5, 6], pos: 2)
let result6 = solution.detectCycle(head6)
assert(result6?.val == 3, "测试6失败：期望 val=3，实际 \(String(describing: result6?.val))")
print("测试6通过：入环节点 val = \(result6!.val)")

// 测试7：多节点无环 → 返回 nil
let head7 = buildLinkedList([1, 2, 3, 4, 5], pos: -1)
let result7 = solution.detectCycle(head7)
assert(result7 == nil, "测试7失败：期望 nil")
print("测试7通过：多节点无环，返回 nil")

print("\n所有测试通过 ✓")

//: [Next](@next)
