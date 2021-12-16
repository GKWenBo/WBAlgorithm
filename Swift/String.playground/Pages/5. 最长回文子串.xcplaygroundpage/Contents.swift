//: [Previous](@previous)

/*
 给你一个字符串 s，找到 s 中最长的回文子串。

 示例 1：
 输入：s = "babad"
 输出："bab"
 解释："aba" 同样是符合题意的答案。
 
 示例 2：
 输入：s = "cbbd"
 输出："bb"
 
 示例 3：
 输入：s = "a"
 输出："a"
 示例 4：

 输入：s = "ac"
 输出："a"

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-palindromic-substring
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else {
            return s
        }
        
        let sChars = Array(s)
        var maxLen = 0, start = 0
        
        for i in 0..<sChars.count {
            searchPalindrome(sChars, i, i, &start, &maxLen)
            searchPalindrome(sChars, i, i + 1, &start, &maxLen)
        }
        return String(sChars[start..<start + maxLen])
    }
    
    private func searchPalindrome(_ chars: [Character], _ l: Int, _ r: Int, _ start: inout Int, _ maxLen: inout Int) {
        var l = l, r = r
        
        while l >= 0 && r < chars.count && chars[l] == chars[r] {
            l -= 1
            r += 1
        }
        
        if maxLen < r - l - 1 {
            start = l + 1
            maxLen = r - l - 1
        }
    }
}


// test
let s = Solution()
s.longestPalindrome("babad")

//: [Next](@next)
