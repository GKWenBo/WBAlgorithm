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
  

 注意：本题与主站 125 题相同： https://leetcode-cn.com/problems/valid-palindrome/
 LeetCode：https://leetcode.cn/problems/XltzEq/description/
 */

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let str = s.filter { $0.isLetter || $0.isNumber }.map { $0.lowercased() }
        var left = 0
        var right = str.count - 1
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

let s = "A man, a plan, a canal: Panama"
print(Solution().isPalindrome(s))

//: [Next](@next)
