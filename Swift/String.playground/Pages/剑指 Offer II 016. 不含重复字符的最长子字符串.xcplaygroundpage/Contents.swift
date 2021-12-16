//: [Previous](@previous)

/*
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长连续子字符串 的长度。

 示例 1:
 输入: s = "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子字符串是 "abc"，所以其长度为 3。
 
 示例 2:
 输入: s = "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子字符串是 "b"，所以其长度为 1。
 
 示例 3:
 输入: s = "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
 
 示例 4:
 输入: s = ""
 输出: 0

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/wtcaE1
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxLen = 0, startIdx = 0, charToPos = [Character: Int]()
        let sChars = Array(s)
        
        for (i, char) in sChars.enumerated() {
            if let pos = charToPos[char] {
                startIdx = max(startIdx, pos)
            }
            
            // update to next valid position
            charToPos[char] = i + 1
            maxLen = max(maxLen, i - startIdx + 1)
        }
        
        return maxLen
    }
}

// test
let s = Solution()
s.lengthOfLongestSubstring("pwwkew")

//: [Next](@next)
