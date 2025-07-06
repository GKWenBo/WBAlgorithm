//: [Previous](@previous)

import Foundation

/*
 LeetCode: https://leetcode.cn/problems/merge-two-sorted-lists/description/
 将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
 
 示例 1：


 输入：l1 = [1,2,4], l2 = [1,3,4]
 输出：[1,1,2,3,4,4]
 示例 2：

 输入：l1 = [], l2 = []
 输出：[]
 示例 3：

 输入：l1 = [], l2 = [0]
 输出：[0]
  

 提示：

 两个链表的节点数目范围是 [0, 50]
 -100 <= Node.val <= 100
 l1 和 l2 均按 非递减顺序 排列
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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var p1 = list1
        var p2 = list2
        /// 哨兵节点
        var dummy = ListNode(-1)
        var p: ListNode? = dummy
        
        while p1 != nil && p2 != nil {
            /// 比p1和p2两个指针
            /// 将较小的节点连接到p指针
            if p1!.val < p2!.val {
                p?.next = p1
                p1 = p1?.next
            } else {
                p?.next = p2
                p2 = p2?.next
            }
            p = p?.next
        }
        
        p?.next = p1 ?? p2
        
        return dummy.next
    }
}

// 链表构建函数（通过数组创建链表）
func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    let dummy = ListNode(-1)
    var current: ListNode? = dummy
    for val in values {
        current?.next = ListNode(val)
        current = current?.next
    }
    return dummy.next
}

// 链表转数组（用于验证结果）
func listToArray(_ head: ListNode?) -> [Int] {
    var result = [Int]()
    var current = head
    while let node = current {
        result.append(node.val)
        current = node.next
    }
    return result
}

// 测试用例
let solution = Solution()

// ✅ 测试1: 常规合并
let list1 = createList([1, 2, 4])
let list2 = createList([1, 3, 4])
let merged1 = solution.mergeTwoLists(list1, list2)
print("测试1结果:", listToArray(merged1)) // [1, 1, 2, 3, 4, 4]

// ✅ 测试2: 双空链表
let merged2 = solution.mergeTwoLists(nil, nil)
print("测试2结果:", listToArray(merged2)) // []

// ✅ 测试3: 单边空链表
let list3 = createList([0])
let merged3 = solution.mergeTwoLists(nil, list3)
print("测试3结果:", listToArray(merged3)) // [0]

// ✅ 测试4: 剩余值处理
let list4 = createList([5])
let list5 = createList([1, 2, 4])
let merged4 = solution.mergeTwoLists(list4, list5)
print("测试4结果:", listToArray(merged4)) // [1, 2, 4, 5]

//: [Next](@next)
