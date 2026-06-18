//: [Previous](@previous)

import Foundation

/*
 给你一个单链表的头节点 head ，请你判断该链表是否为回文链表。如果是，返回 true ；否则，返回 false 。



 示例 1：


 输入：head = [1,2,2,1]
 输出：true
 示例 2：


 输入：head = [1,2]
 输出：false


 提示：

 链表中节点数目在范围[1, 105] 内
 0 <= Node.val <= 9


 进阶：你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？

 LeetCode：https://leetcode.cn/problems/palindrome-linked-list/description/

 解题思路（O(n) 时间，O(1) 空间）：
 1. 快慢指针找中点：fast 每次走 2 步，slow 每次走 1 步，
    fast 到达末尾时 slow 恰好在链表中点。
 2. 奇数长度处理：循环结束后 fast != nil，说明链表长度为奇数，
    需跳过中间节点（slow 再前进一步），避免将中间节点纳入比较。
 3. 反转后半段：将 slow 之后的链表原地反转。
 4. 双指针对比：left 从头部出发，right 从反转后的后半段出发，
    逐一比较，若有不同则不是回文链表。
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
    func isPalindrome(_ head: ListNode?) -> Bool {
        var fast = head
        var slow = head

        // 快慢指针找中点：fast 走完时 slow 在链表中间
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }

        // fast != nil 说明链表长度为奇数，slow 跳过中间节点
        if fast != nil {
            slow = slow?.next
        }

        // 反转后半段，与前半段逐节点对比
        var left = head
        var right = reverse(slow)
        while right != nil {
            if left?.val != right?.val {
                return false
            }
            left = left?.next
            right = right?.next
        }
        return true
    }

    /// 原地反转链表，返回新头节点
    func reverse(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }

        var pre: ListNode? = nil
        var cur = head
        var next = head?.next
        while cur != nil {
            cur?.next = pre
            pre = cur
            cur = next
            if next != nil {
                next = next?.next
            }
        }
        return pre
    }
}

// MARK: - 测试辅助

/// 将数组转换为链表，方便构造测试用例
func makeList(_ vals: [Int]) -> ListNode? {
    guard !vals.isEmpty else { return nil }
    let dummy = ListNode(0)
    var cur: ListNode? = dummy
    for v in vals {
        cur?.next = ListNode(v)
        cur = cur?.next
    }
    return dummy.next
}

// MARK: - 测试用例

let solution = Solution()

// 偶数长度回文：[1,2,2,1] → true
assert(solution.isPalindrome(makeList([1, 2, 2, 1])) == true,  "[1,2,2,1] 应为回文")

// 非回文：[1,2] → false
assert(solution.isPalindrome(makeList([1, 2])) == false, "[1,2] 不是回文")

// 奇数长度回文：[1,2,1] → true
assert(solution.isPalindrome(makeList([1, 2, 1])) == true,  "[1,2,1] 应为回文")

// 奇数长度回文：[1,2,3,2,1] → true
assert(solution.isPalindrome(makeList([1, 2, 3, 2, 1])) == true,  "[1,2,3,2,1] 应为回文")

// 奇数长度非回文：[1,2,3] → false
assert(solution.isPalindrome(makeList([1, 2, 3])) == false, "[1,2,3] 不是回文")

// 单节点：[1] → true（单个节点天然是回文）
assert(solution.isPalindrome(makeList([1])) == true,  "[1] 应为回文")

// 两个相同节点：[3,3] → true
assert(solution.isPalindrome(makeList([3, 3])) == true,  "[3,3] 应为回文")

// 全部相同：[9,9,9,9] → true
assert(solution.isPalindrome(makeList([9, 9, 9, 9])) == true,  "[9,9,9,9] 应为回文")

// 首尾不同：[1,0,0,2] → false
assert(solution.isPalindrome(makeList([1, 0, 0, 2])) == false, "[1,0,0,2] 不是回文")

print("All tests passed ✓")

//: [Next](@next)
