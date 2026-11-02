//
//  128. 最长连续序列 (Longest Consecutive Sequence)
//
//  改进点（相对原 Dictionary<Int, Bool> 版本）：
//  1. 用 Set<Int> 代替 [Int: Bool] —— value 恒为 true，只用到 key，Set 语义更准、存储更省。
//  2. 补上 Int 溢出保护：num == Int.min 时 num - 1 会 trap；cur == Int.max 时 cur + 1 会 trap。
//  3. 空输入提前返回；用 max 语义清晰化，避免 Dictionary 取值比较的歧义写法。
//
//  复杂度：时间 O(n)，空间 O(n)
//

class Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
        // 去重 + O(1) 查找；预分配容量避免扩容rehash
        var set = Set<Int>(minimumCapacity: nums.count)
        for num in nums { set.insert(num) }

        guard !set.isEmpty else { return 0 }

        var best = 0

        for num in set {
            // 只从「序列起点」出发：num - 1 存在说明 num 只是序列中的一段
            // （Int.min 时 num - 1 会溢出，需先排除）
            if num != Int.min, set.contains(num - 1) { continue }

            // 向后扩展统计长度；Int.max 无后继，同样需先排除溢出
            var cur = num
            var len = 1
            while cur != Int.max, set.contains(cur + 1) {
                cur += 1
                len += 1
            }

            best = max(best, len)
        }

        return best
    }
}

// MARK: - 验证

func check(_ input: [Int], _ expected: Int) {
    let result = Solution().longestConsecutive(input)
    print("输入: \(input)")
    print("输出: \(result)  期望: \(expected)  \(result == expected ? "✅" : "❌")")
    print("---")
}

check([100, 4, 200, 1, 3, 2], 4)                       // 1,2,3,4
check([0, 3, 7, 2, 5, 8, 4, 6, 0, 1], 9)               // 0~8
check([], 0)                                            // 空数组
check([1], 1)                                           // 单元素
check([1, 1, 1, 1], 1)                                  // 全重复
check([-1, -2, -3, 0, 1], 5)                            // 负数跨越 0
check([Int.min, Int.min + 1, 5], 2)                     // Int.min 边界：不得崩溃
check([Int.max, Int.max - 1, 0], 2)                     // Int.max 边界：不得崩溃
