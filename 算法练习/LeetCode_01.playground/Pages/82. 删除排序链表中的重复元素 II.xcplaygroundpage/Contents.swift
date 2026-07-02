//: [Previous](@previous)

import Foundation

/*
 82. 删除排序链表中的重复元素 II
 已解答
 中等
 相关标签
 premium lock icon
 相关企业
 给定一个已排序的链表的头 head ， 删除原始链表中所有重复数字的节点，只留下不同的数字 。返回 已排序的链表 。



 示例 1：


 输入：head = [1,2,3,3,4,4,5]
 输出：[1,2,5]
 示例 2：


 输入：head = [1,1,1,2,3]
 输出：[2,3]


 提示：

 链表中节点数目在范围 [0, 300] 内
 -100 <= Node.val <= 100
 题目数据保证链表已经按升序 排列
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
    /// 删除排序链表中所有出现重复值的节点，只保留唯一出现的节点
    ///
    /// 思路：双链表分流
    /// - 维护两条链：dupList（存放出现过重复的节点）和 uniqList（存放唯一节点）
    /// - 判断当前节点是否属于重复组的依据：
    ///   1. 与下一节点值相同（重复组的第一个）
    ///   2. 与 dupList 尾节点值相同（重复组的后续节点，因链表有序，重复值连续出现）
    /// - 最终返回 uniqList
    ///
    /// 时间复杂度：O(n)，空间复杂度：O(1)
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        // 哑节点，值 101 超出题目范围 [-100, 100]，避免与实际节点值冲突
        var dummyDup: ListNode? = ListNode(101)   // 重复节点链的哑头
        var dummyUniq: ListNode? = ListNode(101)  // 唯一节点链的哑头
        var pDup = dummyDup    // 重复链的尾指针
        var pUniq = dummyUniq  // 唯一链的尾指针
        var p = head

        while p != nil {
            // 条件1：p 与下一节点相同，说明 p 是重复组的起始节点
            // 条件2：p 的值与 dupList 尾节点相同，说明 p 是同一重复组的后续节点
            if (p?.next != nil && p?.val == p?.next?.val) || p?.val == pDup?.val {
                pDup?.next = p
                pDup = pDup?.next
            } else {
                pUniq?.next = p
                pUniq = pUniq?.next
            }

            p = p?.next
            // 断开当前尾节点的 next，防止结果链表中混入多余节点
            pDup?.next = nil
            pUniq?.next = nil
        }

        return dummyUniq?.next
    }
}

// MARK: - 测试辅助

/// 将数组转换为链表
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

/// 将链表转换为数组（便于断言比较）
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

// 测试1：基本示例 —— 两段重复值
let r1 = toArray(solution.deleteDuplicates(makeList([1, 2, 3, 3, 4, 4, 5])))
assert(r1 == [1, 2, 5], "测试1失败：\(r1)")
print("测试1通过：\(r1)")

// 测试2：头部全部重复
let r2 = toArray(solution.deleteDuplicates(makeList([1, 1, 1, 2, 3])))
assert(r2 == [2, 3], "测试2失败：\(r2)")
print("测试2通过：\(r2)")

// 测试3：空链表
let r3 = toArray(solution.deleteDuplicates(nil))
assert(r3 == [], "测试3失败：\(r3)")
print("测试3通过：空链表 → \(r3)")

// 测试4：单节点，无重复
let r4 = toArray(solution.deleteDuplicates(makeList([1])))
assert(r4 == [1], "测试4失败：\(r4)")
print("测试4通过：\(r4)")

// 测试5：全部节点值相同，结果为空
let r5 = toArray(solution.deleteDuplicates(makeList([2, 2, 2])))
assert(r5 == [], "测试5失败：\(r5)")
print("测试5通过：全重复 → \(r5)")

// 测试6：无任何重复，原链表不变
let r6 = toArray(solution.deleteDuplicates(makeList([1, 2, 3])))
assert(r6 == [1, 2, 3], "测试6失败：\(r6)")
print("测试6通过：\(r6)")

// 测试7：包含负数，重复出现在末尾
let r7 = toArray(solution.deleteDuplicates(makeList([-3, -1, -1, 0, 2])))
assert(r7 == [-3, 0, 2], "测试7失败：\(r7)")
print("测试7通过：\(r7)")

// 测试8：两节点相同
let r8 = toArray(solution.deleteDuplicates(makeList([1, 1])))
assert(r8 == [], "测试8失败：\(r8)")
print("测试8通过：\(r8)")

print("\n所有测试通过 ✓")

//: [Next](@next)
