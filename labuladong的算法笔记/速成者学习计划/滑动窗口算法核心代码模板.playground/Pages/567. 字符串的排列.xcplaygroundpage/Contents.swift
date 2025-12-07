//: [Previous](@previous)

import Foundation
/*
 给你两个字符串 s1 和 s2 ，写一个函数来判断 s2 是否包含 s1 的 排列。如果是，返回 true ；否则，返回 false 。
 
 换句话说，s1 的排列之一是 s2 的 子串 。
 
 
 
 示例 1：
 
 输入：s1 = "ab" s2 = "eidbaooo"
 输出：true
 解释：s2 包含 s1 的排列之一 ("ba").
 示例 2：
 
 输入：s1= "ab" s2 = "eidboaoo"
 输出：false
 
 
 提示：
 
 1 <= s1.length, s2.length <= 104
 s1 和 s2 仅包含小写字母
 
 LeetCode：https://leetcode.cn/problems/permutation-in-string/
 */

class Solution {
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        var need: [Character: Int] = [:]
        var window: [Character: Int] = [:]
        for c in s1 {
            need[c] = need[c, default: 0] + 1
        }
        
        var sArray = Array(s2)
        var left = 0
        var right = 0
        var valid = 0
        while right < sArray.count {
            let c = sArray[right]
            right += 1
            
            /// 进行窗口内数据的一系列更新
            if need[c] != nil {
                window[c] = window[c, default: 0] + 1
                if window[c] == need[c] {
                    valid += 1
                }
            }
            
            /// 判断左侧窗口是否要收缩
            while right - left >= s1.count {
                /// 在这里判断是否找到了合法的子串
                if valid == need.count {
                    return true
                }
                
                let d = sArray[left]
                left += 1
                
                /// 进行窗口内数据的一系列更新
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
        return false
    }
}

let s1 = "ab"
let s2 = "eidbaooo"
print(Solution().checkInclusion(s1, s2))

let s11 = "ab"
let s22 = "eidboaoo"
print(Solution().checkInclusion(s11, s22))
//: [Next](@next)
