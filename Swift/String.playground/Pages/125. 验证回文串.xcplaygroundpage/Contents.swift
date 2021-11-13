//: [Previous](@previous)

/*
 给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
 说明：本题中，我们将空字符串定义为有效的回文串。

 示例 1:
 输入: "A man, a plan, a canal: Panama"
 输出: true
 解释："amanaplanacanalpanama" 是回文串
 
 示例 2:
 输入: "race a car"
 输出: false
 解释："raceacar" 不是回文串

 提示：
 1 <= s.length <= 2 * 105
 字符串 s 由 ASCII 字符组成

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/valid-palindrome
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let characters: [Character] = Array.init(s.lowercased())
        var left = 0
        var right = characters.count - 1
        while left < right {
            guard characters[left].isNumber || characters[left].isLetter else {
                left += 1
                continue
            }
            guard characters[right].isNumber || characters[right].isLetter else {
                right -= 1
                continue
            }
            guard characters[left] == characters[right] else {
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }
}

// test
let s = Solution()
let string = "A man, a plan, a canal: Panama"
s.isPalindrome(string) //

//: [Next](@next)
