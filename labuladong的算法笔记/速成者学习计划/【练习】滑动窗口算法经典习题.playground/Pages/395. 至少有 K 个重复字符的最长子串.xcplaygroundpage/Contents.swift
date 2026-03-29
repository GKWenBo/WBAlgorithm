//: [Previous](@previous)

import Foundation

/*
 给你一个字符串 s 和一个整数 k ，请你找出 s 中的最长子串， 要求该子串中的每一字符出现次数都不少于 k 。返回这一子串的长度。

 如果不存在这样的子字符串，则返回 0。

  

 示例 1：

 输入：s = "aaabb", k = 3
 输出：3
 解释：最长子串为 "aaa" ，其中 'a' 重复了 3 次。
 示例 2：

 输入：s = "ababbc", k = 2
 输出：5
 解释：最长子串为 "ababb" ，其中 'a' 重复了 2 次， 'b' 重复了 3 次。
  

 提示：

 1 <= s.length <= 104
 s 仅由小写英文字母组成
 1 <= k <= 105
 
 
 LeetCode：https://leetcode.cn/problems/longest-substring-with-at-least-k-repeating-characters/description/
 */

class Solution {
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        var res = 0
        for i in 1...26 {
            /// 限制窗口中只能有 i 种不同字符
            res = max(res, longestSubstring(s, k, i))
        }
        return res
    }
    
    /// 寻找 s 中含有 count 种字符，且每种字符出现次数都大于 k 的子串
    func longestSubstring(_ s: String, _ k: Int, _ count: Int) -> Int {
        var sArray = Array(s)
        var left = 0
        var right = 0
        /// 记录窗口中有几种字符的出现次数达标（大于等于 k）
        var windowValidCount = 0
        /// 记录窗口中存在几种不同的字符（字符种类）
        var windowUniqueCount = 0
        /// 题目说 s 中只有小写字母，所以用大小 26 的数组记录窗口中字符出现的次数
        var windowCount: [Int] = Array(repeating: 0, count: 26)
        /// 记录答案
        var res = 0
        let characterA = Character("a")
        while right < sArray.count {
            /// 移入字符，扩大窗口
            let c = sArray[right]
            let index = Int(c.asciiValue! - characterA.asciiValue!)
            
            if windowCount[index] == 0 { /// 窗口中新增了一种字符
                windowUniqueCount += 1
            }
            
            windowCount[index] += 1
            
            if windowCount[index] == k { /// 窗口中新增了一种达标的字符
                windowValidCount += 1
            }
            
            right += 1
            
            /// 当窗口中字符种类大于 count 时，缩小窗口
            while windowUniqueCount > count {
                /// 移出字符，缩小窗口
                let d = sArray[left]
                let index = Int(d.asciiValue! - characterA.asciiValue!)
                if windowCount[index] == k {
                    /// 窗口中减少了一种达标的字符
                    windowValidCount -= 1
                }
                
                windowCount[index] -= 1
                
                if windowCount[index] == 0 {
                    /// 窗口中减少了一种字符
                    windowUniqueCount -= 1
                }
                
                left += 1
            }
            
            /// 当窗口中字符种类为 count 且每个字符出现次数都满足 k 时，更新答案
            if windowValidCount == count {
                res = max(res, right - left)
            }
        }
        return res
    }
}

print("395. 至少有 K 个重复字符的最长子串")
print(Solution().longestSubstring("aaabb", 3))
print(Solution().longestSubstring("ababbc", 2))

//: [Next](@next)
