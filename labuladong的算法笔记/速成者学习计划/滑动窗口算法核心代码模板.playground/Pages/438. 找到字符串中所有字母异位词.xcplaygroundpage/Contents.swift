//: [Previous](@previous)

import Foundation
/*
 给定两个字符串 s 和 p，找到 s 中所有 p 的 异位词 的子串，返回这些子串的起始索引。不考虑答案输出的顺序。

  

 示例 1:

 输入: s = "cbaebabacd", p = "abc"
 输出: [0,6]
 解释:
 起始索引等于 0 的子串是 "cba", 它是 "abc" 的异位词。
 起始索引等于 6 的子串是 "bac", 它是 "abc" 的异位词。
  示例 2:

 输入: s = "abab", p = "ab"
 输出: [0,1,2]
 解释:
 起始索引等于 0 的子串是 "ab", 它是 "ab" 的异位词。
 起始索引等于 1 的子串是 "ba", 它是 "ab" 的异位词。
 起始索引等于 2 的子串是 "ab", 它是 "ab" 的异位词。
  

 提示:

 1 <= s.length, p.length <= 3 * 104
 s 和 p 仅包含小写字母
 
 LeetCode：https://leetcode.cn/problems/find-all-anagrams-in-a-string/description/
 */

class Solution {
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        var need: [Character: Int] = [:]
        var window: [Character: Int] = [:]
        p.forEach { c in
            need[c] = need[c, default: 0] + 1
        }
        
        var sArray = Array(s)
        var left = 0
        var right = 0
        /// 记录结果
        var resArray: [Int] = []
        var valid = 0
        while right < sArray.count {
            let c = sArray[right]
            right += 1
            
            if need[c] != nil {
                window[c] = window[c, default: 0] + 1
                
                if need[c] == window[c] {
                    valid += 1
                }
            }
            
            while right - left >= p.count {
                if valid == need.count {
                    resArray.append(left)
                }
                
                let d = sArray[left]
                left += 1
                if need[d] != nil {
                    if window[d] == need[d] {
                        valid -= 1
                    }
                    
                    if let value = window[d] {
                        window[d] = value - 1
                    }
                }
            }
        }
        return resArray
    }
}

let s = "cbaebabacd"
let p = "abc"
let s1 = "abab"
let s2 = "ab"


print(Solution().findAnagrams(s, p))
print(Solution().findAnagrams(s1, s2))

//: [Next](@next)
