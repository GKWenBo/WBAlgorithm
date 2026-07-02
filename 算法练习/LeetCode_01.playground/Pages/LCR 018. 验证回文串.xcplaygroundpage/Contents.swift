//: [Previous](@previous)

import Foundation

/*
 给定一个字符串 s ，验证 s 是否是 回文串 ，只考虑字母和数字字符，可以忽略字母的大小写。

 本题中，将空字符串定义为有效的 回文串 。



 示例 1：

 输入: s = "A man, a plan, a canal: Panama"
 输出: true
 解释："amanaplanacanalpanama" 是回文串
 示例 2：

 输入: s = "race a car"
 输出: false
 解释："raceacar" 不是回文串


 提示：

 1 <= s.length <= 2 * 105
 字符串 s 由 ASCII 字符组成


 注意：本题与主站 125 题相同： https://leetcode.cn/problems/valid-palindrome/

 LeetCode: https://leetcode.cn/problems/XltzEq/description/

 思路：双指针
 1. 先过滤掉非字母和数字字符，并统一转小写
 2. 用左右双指针向中间收缩，逐一比较字符
 3. 若所有字符都匹配则为回文串，否则返回 false
 时间复杂度：O(n)，空间复杂度：O(n)
 */

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        // 过滤非字母/数字字符，并统一转小写，得到待比较的字符数组
        let str = s.filter { $0.isLetter || $0.isNumber }.map { $0.lowercased() }
        var left = 0
        var right = str.count - 1
        // 双指针从两端向中间逼近
        while left < right {
            if str[left] != str[right] {
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }
}

// MARK: - 测试

/// 简易断言：比较实际结果与期望值，打印测试结果
func assert(_ result: Bool, expected: Bool, testCase: String) {
    if result == expected {
        print("✅ PASS: \(testCase)")
    } else {
        print("❌ FAIL: \(testCase) — 期望 \(expected)，实际 \(result)")
    }
}

let solution = Solution()

// 示例 1：含空格和标点的回文串（忽略大小写）
assert(solution.isPalindrome("A man, a plan, a canal: Panama"), expected: true,
       testCase: #""A man, a plan, a canal: Panama" → true"#)

// 示例 2：过滤后不是回文串
assert(solution.isPalindrome("race a car"), expected: false,
       testCase: #""race a car" → false"#)

// 空字符串：定义为有效回文串
assert(solution.isPalindrome(""), expected: true,
       testCase: #""" (空字符串) → true"#)

// 单字符：必然是回文串
assert(solution.isPalindrome("a"), expected: true,
       testCase: #""a" → true"#)

// 纯数字回文
assert(solution.isPalindrome("12321"), expected: true,
       testCase: #""12321" → true"#)

// 纯数字非回文
assert(solution.isPalindrome("12345"), expected: false,
       testCase: #""12345" → false"#)

// 含数字和字母混合的回文：过滤后 "a1a"
assert(solution.isPalindrome("a,1,A"), expected: true,
       testCase: #""a,1,A" → true"#)

// 全部是特殊字符（过滤后为空，视为回文）
assert(solution.isPalindrome(" ,. "), expected: true,
       testCase: #"" ,. " (全特殊字符) → true"#)

// 大小写不同的回文
assert(solution.isPalindrome("AbBa"), expected: true,
       testCase: #""AbBa" → true"#)

// 奇数长度回文
assert(solution.isPalindrome("racecar"), expected: true,
       testCase: #""racecar" → true"#)

//: [Next](@next)
