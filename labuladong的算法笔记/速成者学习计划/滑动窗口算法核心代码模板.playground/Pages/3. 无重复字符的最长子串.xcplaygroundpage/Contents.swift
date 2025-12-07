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
 
 LeetCode：https://leetcode.cn/problems/longest-substring-without-repeating-characters/description/
 */

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var window: [Character: Int] = [:]
        /// 记录结果
        var res = 0
        var left = 0
        var right = 0
        
        var sArray = Array(s)
        while right < sArray.count {
            let c = sArray[right]
            right += 1
            
            window[c] = window[c, default: 0] + 1
            
            while let value = window[c], value > 1 {
                let d = sArray[left]
                left += 1
                
                if let value = window[d] {
                    window[d] = value - 1
                }
            }
            /// 更新答案
            res = max(res, right - left)
        }
        return res
    }
}

let s = "abcabcbb"
print(Solution().lengthOfLongestSubstring(s))

//: [Next](@next)
