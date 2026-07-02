//: [Previous](@previous)

import Foundation

/*
 给你一个字符串 s，找到 s 中最长的 回文 子串。



 示例 1：

 输入：s = "babad"
 输出："bab"
 解释："aba" 同样是符合题意的答案。
 示例 2：

 输入：s = "cbbd"
 输出："bb"


 提示：

 1 <= s.length <= 1000
 s 仅由数字和英文字母组成

 LeetCode：https://leetcode.cn/problems/longest-palindromic-substring/description/
 */

// MARK: - 解法：中心扩展法

class Solution {
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else {
            return s
        }

        var res = ""
        let sArray = Array(s)
        for i in 0..<sArray.count {
            let res1 = palindrome(sArray, i, i)       // 奇数长度：以 i 为中心
            let res2 = palindrome(sArray, i, i + 1)   // 偶数长度：以 i,i+1 为中心

            res = res.count > res1.count ? res : res1
            res = res.count > res2.count ? res : res2
        }
        return res
    }

    // Bug fix: 原来 l > 0 应改为 l >= 0，否则以 index 0 为左边界的回文无法正确扩展
    func palindrome(_ sArray: [Character], _ l: Int, _ r: Int) -> String {
        var l = l
        var r = r
        while l >= 0 && r < sArray.count && sArray[l] == sArray[r] {
            l -= 1
            r += 1
        }
        // 循环结束后，回文区间为 [l+1, r-1]
        let startIndex = l + 1
        let endIndex = r - 1
        // 偶数情况无匹配时 startIndex > endIndex，返回空串
        guard startIndex <= endIndex else {
            return ""
        }
        return String(sArray[startIndex...endIndex])
    }
}

// MARK: - 测试

var passed = 0
var failed = 0

/// expected 为允许的合法答案集合（部分题目有多个正确答案）
@MainActor func verify(_ description: String, _ actual: String, _ expected: [String]) {
    if expected.contains(actual) {
        passed += 1
        print("✓ PASS  \(description)")
    } else {
        failed += 1
        print("✗ FAIL  \(description)")
        print("        期望: \(expected)，实际: \"\(actual)\"")
    }
}

let sol = Solution()

// ── LeetCode 示例 ──────────────────────────────────────────────
verify("示例1: \"babad\"",          sol.longestPalindrome("babad"),          ["bab", "aba"])
verify("示例2: \"cbbd\"",           sol.longestPalindrome("cbbd"),           ["bb"])

// ── 边界：单字符 / 两字符 ──────────────────────────────────────
verify("单字符: \"a\"",             sol.longestPalindrome("a"),              ["a"])
verify("两相同字符: \"bb\"",        sol.longestPalindrome("bb"),             ["bb"])
verify("两不同字符: \"ac\"",        sol.longestPalindrome("ac"),             ["a", "c"])

// ── 整串是回文 ─────────────────────────────────────────────────
verify("奇数整串回文: \"racecar\"", sol.longestPalindrome("racecar"),        ["racecar"])
verify("奇数整串回文: \"abcba\"",   sol.longestPalindrome("abcba"),          ["abcba"])
verify("偶数整串回文: \"abba\"",    sol.longestPalindrome("abba"),           ["abba"])

// ── 回文在首 / 尾 ──────────────────────────────────────────────
verify("回文在开头: \"aabcd\"",     sol.longestPalindrome("aabcd"),          ["aa"])
verify("回文在末尾: \"dcbaa\"",     sol.longestPalindrome("dcbaa"),          ["aa"])

// ── 全相同字符 ─────────────────────────────────────────────────
verify("全相同: \"aaaa\"",          sol.longestPalindrome("aaaa"),           ["aaaa"])

// ── 回文在中间 ─────────────────────────────────────────────────
verify("回文在中间: \"xabcbay\"",   sol.longestPalindrome("xabcbay"),        ["abcba"])
verify("偶数回文在中间: \"xabbay\"",sol.longestPalindrome("xabbay"),         ["abba"])

// ── 较长字符串 ─────────────────────────────────────────────────
verify("较长: \"abcbad\"",          sol.longestPalindrome("abcbad"),         ["abcba"])
verify("较长: \"bananas\"",         sol.longestPalindrome("bananas"),        ["anana"])

// ── 全字符不同 ─────────────────────────────────────────────────
verify("全不同: \"abcde\"",         sol.longestPalindrome("abcde"),          ["a", "b", "c", "d", "e"])

print("\n共 \(passed + failed) 个测试，通过 \(passed) 个，失败 \(failed) 个")

//: [Next](@next)
