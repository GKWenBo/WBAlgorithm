import Playgrounds

#Playground {
    /*
     
     给你链表的头结点 head ，请将其按 升序 排列并返回 排序后的链表 。
     
     示例 1：
     
     
     输入：head = [4,2,1,3]
     输出：[1,2,3,4]
     示例 2：
     
     
     输入：head = [-1,5,3,4,0]
     输出：[-1,0,3,4,5]
     示例 3：
     
     输入：head = []
     输出：[]
     
     
     提示：
     
     链表中节点的数目在范围 [0, 5 * 104] 内
     -105 <= Node.val <= 105
     
     
     进阶：你可以在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序吗？
     
     LeetCode: https://leetcode.cn/problems/sort-list/description/
     
     */
    class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }
    
    // MARK: - 正确实现（自顶向下归并排序）
    // 时间复杂度 O(n log n)，递归栈 O(log n)
    class Solution {
        func sortList(_ head: ListNode?) -> ListNode? {
            guard let head, head.next != nil else { return head }
            
            var fast = head.next
            var slow: ListNode? = head
            
            // 快慢指针找中点：循环结束时 slow 停在「左半段的最后一个节点」
            while fast != nil && fast?.next != nil {
                slow = slow?.next
                fast = fast?.next?.next   // ① 快指针必须一次走 2 步
            }
            
            let mid = slow?.next
            slow?.next = nil              // 断链，切成两条独立链表
            
            let left = sortList(head)     // ② 左半段要从 head 开始！传 slow 会丢掉 slow 之前的所有节点
            let right = sortList(mid)
            return mergeTwoList(left, right)
        }
        
        func mergeTwoList(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            let dummy: ListNode? = ListNode(-1)
            var cur = dummy
            
            var p1 = l1
            var p2 = l2
            while p1 != nil && p2 != nil {
                if p1!.val < p2!.val {
                    cur?.next = p1
                    p1 = p1?.next
                } else {
                    cur?.next = p2
                    p2 = p2?.next
                }
                cur = cur?.next
            }
            
            cur?.next = p1 ?? p2
            
            return dummy?.next
        }
    }
    
    // MARK: - 测试工具
    
    /// 数组 -> 链表
    func buildList(_ arr: [Int]) -> ListNode? {
        guard let first = arr.first else { return nil }
        let head = ListNode(first)
        var cur = head
        for v in arr.dropFirst() {
            cur.next = ListNode(v)
            cur = cur.next!
        }
        return head
    }
    
    /// 链表 -> 数组（带上限保护，防止结果成环时死循环）
    func toArray(_ head: ListNode?, limit: Int = 2_000_000) -> [Int] {
        var out: [Int] = []
        var cur = head
        while let node = cur {
            out.append(node.val)
            cur = node.next
            if out.count > limit { break }
        }
        return out
    }
    
    /// Floyd 判环：确认结果是一条「链」而不是一个「圈」
    func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow === fast { return true }
        }
        return false
    }
    
    var passed = 0
    var failed = 0
    
    /// 单组用例：结果 == 系统 sorted()，且节点数不变、不成环、元素不丢不重
    func check(_ input: [Int],
               _ label: String = "",
               _ sort: (ListNode?) -> ListNode?,
               verbose: Bool = true) {
        let sorted = sort(buildList(input))
        let got = toArray(sorted)
        let expected = input.sorted()
        
        var reasons: [String] = []
        if got != expected          { reasons.append("值序列不匹配") }
        if got.count != input.count { reasons.append("节点数 \(got.count) != \(input.count)") }
        if hasCycle(sorted)         { reasons.append("结果链表成环") }
        if got.sorted() != expected { reasons.append("元素丢失/重复") }
        
        if reasons.isEmpty {
            passed += 1
            if verbose { print("✅ \(label.isEmpty ? "" : label + " ")\(input) -> \(got)") }
        } else {
            failed += 1
            print("❌ \(label)\(input)")
            print("   原因: \(reasons.joined(separator: "、"))")
            print("   got      = \(Array(got.prefix(20)))")
            print("   expected = \(Array(expected.prefix(20)))")
        }
    }
    
    let solution = Solution()
    
    // MARK: - 1. 边界用例
    
    print("=== 1. 边界用例 ===")
    check([],     "空链表",     solution.sortList)
    check([1],    "单节点",     solution.sortList)
    check([2, 1], "两节点逆序", solution.sortList)
    check([1, 2], "两节点已序", solution.sortList)
    check([2, 2], "两节点相等", solution.sortList)
    
    // MARK: - 2. 官方示例 / 典型场景
    
    print("\n=== 2. 官方示例 / 典型场景 ===")
    check([4, 2, 1, 3],                            "示例1",   solution.sortList)
    check([-1, 5, 3, 4, 0],                        "示例2",   solution.sortList)
    check([5, 4, 3, 2, 1],                         "全逆序",  solution.sortList)
    check([1, 2, 3, 4, 5],                         "已排序",  solution.sortList)
    check([3, 3, 3, 3, 3],                         "全相等",  solution.sortList)
    check([2, 2, 1, 1, 3, 3],                      "大量重复", solution.sortList)
    check([-5, 10, -3, 0, 7, -5],                  "含负数",  solution.sortList)
    check([Int.max, Int.min, 0, Int.max, Int.min], "极值",    solution.sortList)
    check([1, 1, 1, 0, 0, -1, -1],                 "三组重复", solution.sortList)
}
