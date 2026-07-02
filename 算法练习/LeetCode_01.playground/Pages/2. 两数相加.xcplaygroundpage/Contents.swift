//: [Previous](@previous)

import Foundation

/*
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。

 请你将两个数相加，并以相同形式返回一个表示和的链表。

 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

  

 示例 1：


 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.
 示例 2：

 输入：l1 = [0], l2 = [0]
 输出：[0]
 示例 3：

 输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 输出：[8,9,9,9,0,0,0,1]
  

 提示：

 每个链表中的节点数在范围 [1, 100] 内
 0 <= Node.val <= 9
 题目数据保证列表表示的数字不含前导零
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
    /// 模拟竖式加法，逐位相加并处理进位
    /// 时间复杂度：O(max(m, n))，m/n 分别是两个链表的长度
    /// 空间复杂度：O(max(m, n))，结果链表最多比较长的链表多一个节点（最终进位）
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var p1 = l1
        var p2 = l2
        // 哨兵节点，简化头节点的处理逻辑
        var dummy: ListNode? = ListNode(-1)
        var p = dummy
        var carry = 0  // 进位值，只能为 0 或 1
        // 任一链表未遍历完，或仍有进位时继续循环
        while p1 != nil || p2 != nil || carry > 0 {
            var value = carry
            if p1 != nil {
                value += p1!.val
                p1 = p1?.next
            }
            if p2 != nil {
                value += p2!.val
                p2 = p2?.next
            }
            // 取十位作为进位，个位作为当前节点值
            carry = value / 10
            value = value % 10
            let node = ListNode(value)
            p?.next = node
            p = p?.next
        }
        return dummy?.next
    }
}

// MARK: - 测试辅助方法

/// 将数组转换为链表（逆序存储，数组第 0 位对应链表头）
func makeList(_ arr: [Int]) -> ListNode? {
    guard !arr.isEmpty else { return nil }
    let dummy = ListNode(-1)
    var cur: ListNode? = dummy
    for val in arr {
        cur?.next = ListNode(val)
        cur = cur?.next
    }
    return dummy.next
}

/// 将链表转换为数组，便于断言比较
func toArray(_ head: ListNode?) -> [Int] {
    var result: [Int] = []
    var cur = head
    while let node = cur {
        result.append(node.val)
        cur = node.next
    }
    return result
}

// MARK: - 测试用例

let solution = Solution()

// 示例 1：342 + 465 = 807，链表逆序存储
let r1 = toArray(solution.addTwoNumbers(makeList([2, 4, 3]), makeList([5, 6, 4])))
assert(r1 == [7, 0, 8], "示例1失败：\(r1)")
print("示例1通过：\(r1)")  // [7, 0, 8]

// 示例 2：0 + 0 = 0
let r2 = toArray(solution.addTwoNumbers(makeList([0]), makeList([0])))
assert(r2 == [0], "示例2失败：\(r2)")
print("示例2通过：\(r2)")  // [0]

// 示例 3：9999999 + 9999 = 10009998，结果最高位产生进位
let r3 = toArray(solution.addTwoNumbers(makeList([9,9,9,9,9,9,9]), makeList([9,9,9,9])))
assert(r3 == [8,9,9,9,0,0,0,1], "示例3失败：\(r3)")
print("示例3通过：\(r3)")  // [8, 9, 9, 9, 0, 0, 0, 1]

// 边界：两数长度不同，较短的耗尽后仍需处理进位
let r4 = toArray(solution.addTwoNumbers(makeList([1]), makeList([9, 9])))
assert(r4 == [0, 0, 1], "长度不同测试失败：\(r4)")  // 1 + 99 = 100
print("长度不同测试通过：\(r4)")  // [0, 0, 1]

// 边界：单节点且产生进位
let r5 = toArray(solution.addTwoNumbers(makeList([5]), makeList([5])))
assert(r5 == [0, 1], "进位测试失败：\(r5)")  // 5 + 5 = 10
print("进位测试通过：\(r5)")  // [0, 1]

print("所有测试通过 ✓")

//: [Next](@next)
