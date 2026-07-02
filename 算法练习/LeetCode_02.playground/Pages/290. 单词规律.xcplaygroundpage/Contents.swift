//: [Previous](@previous)

import Foundation

/*
 给定一种规律 pattern 和一个字符串 s ，判断 s 是否遵循相同的规律。

 这里的 遵循 指完全匹配，例如， pattern 里的每个字母和字符串 s 中的每个非空单词之间存在着双向连接的对应规律。具体来说：

 pattern 中的每个字母都 恰好 映射到 s 中的一个唯一单词。
 s 中的每个唯一单词都 恰好 映射到 pattern 中的一个字母。
 没有两个字母映射到同一个单词，也没有两个单词映射到同一个字母。
  

 示例1:

 输入: pattern = "abba", s = "dog cat cat dog"
 输出: true
 示例 2:

 输入:pattern = "abba", s = "dog cat cat fish"
 输出: false
 示例 3:

 输入: pattern = "aaaa", s = "dog cat cat dog"
 输出: false
  

 提示:

 1 <= pattern.length <= 300
 pattern 只包含小写英文字母
 1 <= s.length <= 3000
 s 只包含小写英文字母和 ' '
 s 不包含 任何前导或尾随对空格

 
 LeetCode: https://leetcode.cn/problems/word-pattern/description/
 */

class Solution {
    /// 判断字符串 s 是否遵循 pattern 规律
    /// 思路：双向哈希表，维护字母→单词、单词→字母两个映射，确保双射关系
    /// 时间复杂度：O(n)，n 为 pattern 长度；空间复杂度：O(n)
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        let chars = Array(pattern)
        let words = s.split(separator: " ")

        // 长度不等时直接排除
        guard chars.count == words.count else { return false }

        var charToWord: [Character: Substring] = [:]
        var wordToChar: [Substring: Character] = [:]

        for (word, char) in zip(words, chars) {
            // 字母已映射到不同单词 → 不匹配
            if let mapped = charToWord[char], mapped != word { return false }
            // 单词已映射到不同字母 → 不匹配
            if let mapped = wordToChar[word], mapped != char { return false }
            charToWord[char] = word
            wordToChar[word] = char
        }
        return true
    }
}

// MARK: - 测试

let solution = Solution()

// 示例 1：abba / "dog cat cat dog" → true
assert(solution.wordPattern("abba", "dog cat cat dog") == true, "测试1失败")

// 示例 2：abba / "dog cat cat fish" → false（b 映射了两个不同单词）
assert(solution.wordPattern("abba", "dog cat cat fish") == false, "测试2失败")

// 示例 3：aaaa / "dog cat cat dog" → false（a 需全映射同一单词）
assert(solution.wordPattern("aaaa", "dog cat cat dog") == false, "测试3失败")

// 长度不等 → false
assert(solution.wordPattern("aaa", "dog cat") == false, "测试4失败")

// 单字母单单词 → true
assert(solution.wordPattern("a", "dog") == true, "测试5失败")

// 两个字母映射同一单词（违反双射）→ false
assert(solution.wordPattern("ab", "dog dog") == false, "测试6失败")

// 完整双射匹配 → true
assert(solution.wordPattern("abcd", "dog cat bird fish") == true, "测试7失败")

print("所有测试通过 ✓")

//: [Next](@next)
