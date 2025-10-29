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

class Solution {
    func longestPalindrome(_ s: String) -> String {
        // 如果字符串长度小于2，直接返回
        guard s.count > 1 else { return s }
        
        // 将字符串转换为字符数组以便索引访问
        let array = Array(s)
        var res = ""
        for i in 0..<array.count {
            // 以 chars[i] 为中心的最长回文子串（奇数长度）
            let res1 = palindrome(array, l: i, r: i)
            // 以 chars[i] 和 chars[i+1] 为中心的最长回文子串（偶数长度）
            let res2 = palindrome(array, l: i, r: i + 1)
            res = res.count > res1.count ? res : res1
            res = res.count > res2.count ? res : res2
        }
        return res
    }
    
    // 辅助函数：从中心向两边扩展寻找回文串
    func palindrome(_ s: [Character], l: Int, r: Int) -> String {
        var l = l
        var r = r
        // 防止索引越界，并向两边扩展
        while l >= 0 && r < s.count && s[l] == s[r] {
            l -= 1
            r += 1
        }
        // 此时 [left+1, right-1] 就是最长回文串
        // 提取回文子串
        let startIndex = l + 1
        let endIndex = r - 1
        
        // 如果开始索引大于结束索引，返回空字符串
        guard startIndex <= endIndex else {
            return ""
        }
        // 从字符数组构建子字符串
        return String(s[startIndex...endIndex])
    }
    
}

let res = Solution().longestPalindrome("babad")

//: [Next](@next)
