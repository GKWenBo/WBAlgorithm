//: [Previous](@previous)

import Foundation

/*
 给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。

 k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。

 你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。

  

 示例 1：


 输入：head = [1,2,3,4,5], k = 2
 输出：[2,1,4,3,5]
 示例 2：



 输入：head = [1,2,3,4,5], k = 3
 输出：[3,2,1,4,5]
  

 提示：
 链表中的节点数目为 n
 1 <= k <= n <= 5000
 0 <= Node.val <= 1000
  

 进阶：你可以设计一个只用 O(1) 额外内存空间的算法解决此问题吗？
 
 LeetCode: https://leetcode.cn/problems/reverse-nodes-in-k-group/description/
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
    // 思路：递归处理，每次只翻转前 k 个节点，剩余部分递归解决
    // 时间复杂度 O(n)，空间复杂度 O(n/k)（递归栈深度）
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        if head == nil {
            return nil
        }

        // a 指向当前组的头，b 向前走 k 步定位当前组的尾后一个节点
        let a = head
        var b = head

        for _ in 0..<k {
            // 剩余节点不足 k 个，保持原顺序直接返回
            if b == nil {
                return head
            }
            b = b?.next
        }

        // 翻转 [a, b) 区间内的 k 个节点，返回新的头节点
        let newHead = reverseN(a, k)

        // 翻转后 a 变为当前组的尾节点，将其 next 接上后续递归结果
        a?.next = reverseKGroup(b, k)

        return newHead
    }

    // 迭代翻转链表的前 k 个节点
    // 翻转完成后，原 head 变为尾节点，其 next 指向第 k+1 个节点（即未翻转部分的起点）
    func reverseN(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        var k = k
        var pre: ListNode? = nil
        var cur = head
        var next = head?.next
        // 经典三指针迭代翻转：依次将 cur.next 指向 pre
        while k > 0 {
            cur?.next = pre
            pre = cur
            cur = next
            if next != nil {
                next = next?.next
            }
            k -= 1
        }

        // 循环结束时 cur 指向第 k+1 个节点，作为尾节点的 next 保留给调用方连接
        head?.next = cur

        return pre
    }
}

// MARK: - 测试辅助

func makeList(_ vals: [Int]) -> ListNode? {
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
    var cur = head
    while let node = cur {
        result.append(node.val)
        cur = node.next
    }
    return result
}

// MARK: - 测试用例

let solution = Solution()
var passed = 0
var failed = 0

@MainActor func check(_ desc: String, _ got: [Int], _ expected: [Int]) {
    if got == expected {
        print("✅ \(desc): \(got)")
        passed += 1
    } else {
        print("❌ \(desc): 期望 \(expected)，实际 \(got)")
        failed += 1
    }
}

// 示例1: k=2, [1,2,3,4,5] -> [2,1,4,3,5]
check("k=2, 5个节点",
      toArray(solution.reverseKGroup(makeList([1,2,3,4,5]), 2)),
      [2,1,4,3,5])

// 示例2: k=3, [1,2,3,4,5] -> [3,2,1,4,5]
check("k=3, 5个节点",
      toArray(solution.reverseKGroup(makeList([1,2,3,4,5]), 3)),
      [3,2,1,4,5])

// k=1，顺序不变
check("k=1, 顺序不变",
      toArray(solution.reverseKGroup(makeList([1,2,3]), 1)),
      [1,2,3])

// k等于链表长度，全部翻转
check("k=length, 全部翻转",
      toArray(solution.reverseKGroup(makeList([1,2,3]), 3)),
      [3,2,1])

// 偶数个节点，k=2，全部整除
check("k=2, 4个节点（整除）",
      toArray(solution.reverseKGroup(makeList([1,2,3,4]), 2)),
      [2,1,4,3])

// 单节点
check("单节点",
      toArray(solution.reverseKGroup(makeList([1]), 1)),
      [1])

// 空链表
check("空链表",
      toArray(solution.reverseKGroup(nil, 2)),
      [])

// k > 剩余节点数，末尾不翻转
check("k=4, 5个节点",
      toArray(solution.reverseKGroup(makeList([1,2,3,4,5]), 4)),
      [4,3,2,1,5])

print("\n共 \(passed + failed) 个测试，✅ \(passed) 通过，❌ \(failed) 失败")

//: [Next](@next)
