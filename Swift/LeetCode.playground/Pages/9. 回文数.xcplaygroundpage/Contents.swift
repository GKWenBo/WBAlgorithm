//: [Previous](@previous)

/*
 给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。
 
 回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。例如，121 是回文，而 123 不是。
 
 示例 1：
 输入：x = 121
 输出：true
 
 示例 2：
 输入：x = -121
 输出：false
 解释：从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
 
 示例 3：
 输入：x = 10
 输出：false
 解释：从右向左读, 为 01 。因此它不是一个回文数。
 示例 4：
 
 输入：x = -101
 输出：false
  
 提示：
 -231 <= x <= 231 - 1
 
 进阶：你能不将整数转为字符串来解决这个问题吗？
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/palindrome-number
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        // 特殊情况：
        // 如上所述，当 x < 0 时，x 不是回文数。
        // 同样地，如果数字的最后一位是 0，为了使该数字为回文，
        // 则其第一位数字也应该是 0
        // 只有 0 满足这一属性
        if x < 0 || (x % 10 == 0 && x != 0) {
            return false
        }
        
        var x = x;
        var revertedNumber = 0;
        while revertedNumber < x {
            revertedNumber = revertedNumber * 10 + x % 10
            x /= 10
        }
        // 当数字长度为奇数时，我们可以通过 revertedNumber/10 去除处于中位的数字。
        // 例如，当输入为 12321 时，在 while 循环的末尾我们可以得到 x = 12，revertedNumber = 123，
        // 由于处于中位的数字不影响回文（它总是与自己相等），所以我们可以简单地将其去除。
        return revertedNumber == x || revertedNumber / 10 == x
    }
    
    /// 字符串解法
    func isPalindrome1(_ x: Int) -> Bool {
        guard x >= 0 else {
            return false
        }
        
        var string = String(x)
        while string.count > 1 {
            guard string.removeFirst() == string.removeLast() else {
                return false
            }
        }
        return true
    }
}

// test
let s = Solution()
s.isPalindrome1(1236321)

//: [Next](@next)
