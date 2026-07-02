//: [Previous](@previous)

import Foundation

/*
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长 子串 的长度。

  

 示例 1:

 输入: s = "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。注意 "bca" 和 "cab" 也是正确答案。
 示例 2:

 输入: s = "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 示例 3:

 输入: s = "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
  

 提示：

 0 <= s.length <= 5 * 104
 s 由英文字母、数字、符号和空格组成
 
 LeetCode: https://leetcode.cn/problems/longest-substring-without-repeating-characters/description/
 */

/// 滑动窗口法：维护一个不含重复字符的窗口 [windowStart, index]
/// 时间复杂度 O(n)，空间复杂度 O(min(m, n))，m 为字符集大小
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // 记录每个字符最近一次出现的下标
        var lastIndexOf: [Character: Int] = [:]
        let sArray = Array(s)
        // 窗口左边界
        var windowStart = 0

        var longest = 0
        for (index, c) in sArray.enumerated() {
            // 若字符在当前窗口内已出现，将左边界移到重复字符的下一位
            if let seenIndex = lastIndexOf[c], seenIndex >= windowStart {
                windowStart = seenIndex + 1
            }
            lastIndexOf[c] = index
            // 当前窗口长度 = index - windowStart + 1
            longest = max(longest, index - windowStart + 1)
        }
        return longest
    }
}

// MARK: - 测试

let solution = Solution()

// 题目示例
assert(solution.lengthOfLongestSubstring("abcabcbb") == 3, "示例1失败")  // "abc"
assert(solution.lengthOfLongestSubstring("bbbbb") == 1,    "示例2失败")  // "b"
assert(solution.lengthOfLongestSubstring("pwwkew") == 3,   "示例3失败")  // "wke"

// 边界情况
assert(solution.lengthOfLongestSubstring("") == 0,         "空字符串失败")
assert(solution.lengthOfLongestSubstring("a") == 1,        "单字符失败")
assert(solution.lengthOfLongestSubstring("au") == 2,       "两个不重复字符失败")
assert(solution.lengthOfLongestSubstring("aab") == 2,      "头部重复失败")  // "ab"

// 含空格与特殊字符
assert(solution.lengthOfLongestSubstring("a b") == 3,      "含空格失败")   // "a b"
assert(solution.lengthOfLongestSubstring("dvdf") == 3,     "中间重复失败") // "vdf"

// 全不重复
assert(solution.lengthOfLongestSubstring("abcdef") == 6,   "全不重复失败")

print("All tests passed ✓")

//: [Next](@next)
