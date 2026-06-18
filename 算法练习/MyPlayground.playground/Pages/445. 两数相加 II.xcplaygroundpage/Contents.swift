//: [Previous](@previous)

import Foundation

/*
 给你两个 非空 链表来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储一位数字。将这两数相加会返回一个新的链表。

 你可以假设除了数字 0 之外，这两个数字都不会以零开头。

 示例1：
 输入：l1 = [7,2,4,3], l2 = [5,6,4]
 输出：[7,8,0,7]

 示例2：
 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[8,0,7]

 示例3：
 输入：l1 = [0], l2 = [0]
 输出：[0]

 提示：
 链表的长度范围为 [1, 100]
 0 <= node.val <= 9
 输入数据保证链表代表的数字无前导 0

 进阶：如果输入链表不能翻转该如何解决？

 思路：用栈模拟从低位到高位的加法（无需翻转链表）
 1. 将两个链表的值分别压入两个栈 → 栈顶即最低位
 2. 同步弹栈相加，处理进位
 3. 每次用"头插法"将新节点插到虚拟头节点之后，使结果保持高位在前
 时间复杂度：O(m + n)，空间复杂度：O(m + n)
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 虚拟头节点，结果链表通过头插法挂在其后
        var dummy: ListNode? = ListNode(-1)
        var stack1: [Int] = []
        var stack2: [Int] = []
        var carry = 0

        // 将 l1 各位压栈，遍历结束后栈顶为最低位
        var p1 = l1
        while let val = p1?.val {
            stack1.append(val)
            p1 = p1?.next
        }

        // 将 l2 各位压栈，遍历结束后栈顶为最低位
        var p2 = l2
        while let val = p2?.val {
            stack2.append(val)
            p2 = p2?.next
        }

        // 从最低位开始相加，直到两栈均空且无进位
        while !stack1.isEmpty || !stack2.isEmpty || carry > 0 {
            var value = carry
            if let last = stack1.popLast() {
                value += last
            }
            if let last = stack2.popLast() {
                value += last
            }

            carry = value / 10
            value = value % 10

            // 头插法：每个新节点插到 dummy 之后
            // 先处理低位、后处理高位，头插后高位自然排在链表前端
            let node = ListNode(value)
            node.next = dummy?.next
            dummy?.next = node
        }

        return dummy?.next
    }
}

// MARK: - 测试辅助

/// 将数组转换为链表（高位在前）
func makeList(_ values: [Int]) -> ListNode? {
    let dummy = ListNode(-1)
    var cur: ListNode? = dummy
    for v in values {
        let node = ListNode(v)
        cur?.next = node
        cur = node
    }
    return dummy.next
}

/// 将链表展开为数组，方便比较
func toArray(_ head: ListNode?) -> [Int] {
    var result: [Int] = []
    var cur = head
    while let node = cur {
        result.append(node.val)
        cur = node.next
    }
    return result
}

/// 断言：结果正确打印 ✅，否则打印 ❌
func check(_ actual: [Int], _ expected: [Int], _ name: String) {
    if actual == expected {
        print("✅ \(name)：\(actual)")
    } else {
        print("❌ \(name)：期望 \(expected)，实际 \(actual)")
    }
}

// MARK: - 测试用例

let sol = Solution()

// 题目示例：长度不等，有进位
check(toArray(sol.addTwoNumbers(makeList([7,2,4,3]), makeList([5,6,4]))),
      [7,8,0,7], "示例1 [7,2,4,3]+[5,6,4]")

// 题目示例：等长
check(toArray(sol.addTwoNumbers(makeList([2,4,3]), makeList([5,6,4]))),
      [8,0,7], "示例2 [2,4,3]+[5,6,4]")

// 题目示例：全零
check(toArray(sol.addTwoNumbers(makeList([0]), makeList([0]))),
      [0], "示例3 [0]+[0]")

// 进位传播至最高位，结果位数增加
check(toArray(sol.addTwoNumbers(makeList([9,9,9]), makeList([1]))),
      [1,0,0,0], "进位传播 [9,9,9]+[1]")

// 短链表在左
check(toArray(sol.addTwoNumbers(makeList([1]), makeList([9,9,9]))),
      [1,0,0,0], "短+长 [1]+[9,9,9]")

// 单节点无进位
check(toArray(sol.addTwoNumbers(makeList([3]), makeList([4]))),
      [7], "单节点无进位 [3]+[4]")

// 单节点产生进位
check(toArray(sol.addTwoNumbers(makeList([5]), makeList([5]))),
      [1,0], "单节点有进位 [5]+[5]")

// 全部是 9，测试连续进位
check(toArray(sol.addTwoNumbers(makeList([9,9]), makeList([9,9]))),
      [1,9,8], "全9 [9,9]+[9,9]")

//: [Next](@next)
