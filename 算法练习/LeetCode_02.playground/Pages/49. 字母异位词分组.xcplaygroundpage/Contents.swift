//: [Previous](@previous)

import Foundation

/*
 给你一个字符串数组，请你将 字母异位词 组合在一起。可以按任意顺序返回结果列表。

  

 示例 1:

 输入: strs = ["eat", "tea", "tan", "ate", "nat", "bat"]

 输出: [["bat"],["nat","tan"],["ate","eat","tea"]]

 解释：

 在 strs 中没有字符串可以通过重新排列来形成 "bat"。
 字符串 "nat" 和 "tan" 是字母异位词，因为它们可以重新排列以形成彼此。
 字符串 "ate" ，"eat" 和 "tea" 是字母异位词，因为它们可以重新排列以形成彼此。
 示例 2:

 输入: strs = [""]

 输出: [[""]]

 示例 3:

 输入: strs = ["a"]

 输出: [["a"]]

  

 提示：

 1 <= strs.length <= 104
 0 <= strs[i].length <= 100
 strs[i] 仅包含小写字母
 
 LeetCode: https://leetcode.cn/problems/group-anagrams/description/
 */

// 思路：用「字符频次编码」作为哈希键，频次相同的字符串必然是字母异位词，
// 将它们归入同一组。时间 O(n·k)，空间 O(n·k)，n 为字符串数量，k 为最大长度。
class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var map: [String: [String]] = [:]
        for str in strs {
            // 以字符频次编码为 key，把同组异位词聚合到同一数组
            let key = encode(str)
            map[key, default: []].append(str)
        }
        return Array(map.values)
    }

    // 将字符串编码为长度 26 的频次数组（字节序列），保证字母异位词产生相同 key
    private func encode(_ str: String) -> String {
        var count = Array(repeating: UInt8(0), count: 26)
        let aValue = Character("a").asciiValue!
        for c in str.utf8 {
            count[Int(c - aValue)] += 1
        }
        return String(decoding: count, as: UTF8.self)
    }
}

// MARK: - 测试

// 因为分组顺序和组内顺序均可任意，需先排序再比较
func normalize(_ groups: [[String]]) -> [[String]] {
    groups.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
}

func assertEqual(_ result: [[String]], _ expected: [[String]], label: String) {
    if normalize(result) == normalize(expected) {
        print("✅ \(label)")
    } else {
        print("❌ \(label)")
        print("   期望: \(normalize(expected))")
        print("   实际: \(normalize(result))")
    }
}

let sol = Solution()

// 示例 1：常规分组
assertEqual(
    sol.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]),
    [["bat"], ["nat", "tan"], ["ate", "eat", "tea"]],
    label: "示例1 - 常规分组"
)

// 示例 2：单个空字符串
assertEqual(
    sol.groupAnagrams([""]),
    [[""]],
    label: "示例2 - 空字符串"
)

// 示例 3：单个字符
assertEqual(
    sol.groupAnagrams(["a"]),
    [["a"]],
    label: "示例3 - 单字符"
)

// 边界：所有字符串互为异位词
assertEqual(
    sol.groupAnagrams(["abc", "bca", "cab"]),
    [["abc", "bca", "cab"]],
    label: "边界 - 全部同组"
)

// 边界：所有字符串均不同，每组只有一个
assertEqual(
    sol.groupAnagrams(["abc", "def", "ghi"]),
    [["abc"], ["def"], ["ghi"]],
    label: "边界 - 无异位词"
)

// 边界：含重复相同字符串
assertEqual(
    sol.groupAnagrams(["a", "a"]),
    [["a", "a"]],
    label: "边界 - 重复字符串"
)

//: [Next](@next)
