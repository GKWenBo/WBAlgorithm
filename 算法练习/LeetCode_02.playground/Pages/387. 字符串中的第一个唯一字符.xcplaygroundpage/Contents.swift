//: [Previous](@previous)

import Foundation
/*
 给定一个字符串 s ，找到 它的第一个不重复的字符，并返回它的索引 。如果不存在，则返回 -1 。

  

 示例 1：

 输入: s = "leetcode"
 输出: 0
 示例 2:

 输入: s = "loveleetcode"
 输出: 2
 示例 3:

 输入: s = "aabb"
 输出: -1
  

 提示:

 1 <= s.length <= 105
 s 只包含小写字母
 
 LeetCode：https://leetcode.cn/problems/first-unique-character-in-a-string/description/
 */

class Solution {
    /// 时间复杂度 O(n)，空间复杂度 O(1)（字母表大小固定为 26）
    func firstUniqChar(_ s: String) -> Int {
        let aValue = Character("a").asciiValue!
        // 以字母偏移量为 key，统计每个字符出现次数
        var map: [UInt8: Int] = [:]
        for c in s {
            map[c.asciiValue! - aValue, default: 0] += 1
        }
        // 按原始顺序遍历，找第一个计数为 1 的字符
        for (index, c) in s.enumerated() {
            let key = c.asciiValue! - aValue
            if map[key] == 1 {
                return index
            }
        }
        return -1
    }
}

// MARK: - 测试

/// 单个测试用例
struct TestCase {
    let input: String
    let expected: Int
    let description: String
}

/// 运行所有测试用例，打印结果并返回是否全部通过
@discardableResult
func runTests(_ cases: [TestCase]) -> Bool {
    let sol = Solution()
    var allPassed = true

    for tc in cases {
        let result = sol.firstUniqChar(tc.input)
        let passed = result == tc.expected
        if !passed { allPassed = false }
        print("\(passed ? "✅" : "❌") [\(tc.description)] input: \"\(tc.input)\" → result: \(result), expected: \(tc.expected)")
    }

    print(allPassed ? "\n所有测试用例通过 🎉" : "\n存在失败用例 ❗️")
    return allPassed
}

let testCases: [TestCase] = [
    // 题目示例
    TestCase(input: "leetcode",     expected: 0,  description: "示例1 - 首字符唯一"),
    TestCase(input: "loveleetcode", expected: 2,  description: "示例2 - 唯一字符在中间"),
    TestCase(input: "aabb",         expected: -1, description: "示例3 - 无唯一字符"),

    // 边界情况
    TestCase(input: "z",            expected: 0,  description: "单字符"),
    TestCase(input: "aabbcc",       expected: -1, description: "全部重复"),
    TestCase(input: "abcd",         expected: 0,  description: "全部唯一，取第一个"),
    TestCase(input: "aabbc",        expected: 4,  description: "唯一字符在末尾"),
    TestCase(input: "abacabad",     expected: 3,  description: "唯一字符在中间偏后"),
]

runTests(testCases)

//: [Next](@next)
