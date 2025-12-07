//: [Previous](@previous)

import Foundation
/*
 给你一个字符串 s 和一个整数 k 。你可以选择字符串中的任一字符，并将其更改为任何其他大写英文字符。该操作最多可执行 k 次。

 在执行上述操作后，返回 包含相同字母的最长子字符串的长度。

  

 示例 1：

 输入：s = "ABAB", k = 2
 输出：4
 解释：用两个'A'替换为两个'B',反之亦然。
 示例 2：

 输入：s = "AABABBA", k = 1
 输出：4
 解释：
 将中间的一个'A'替换为'B',字符串变为 "AABBBBA"。
 子串 "BBBB" 有最长重复字母, 答案为 4。
 可能存在其他的方法来得到同样的结果。
  

 提示：

 1 <= s.length <= 105
 s 仅由大写英文字母组成
 0 <= k <= s.length
 
 LeetCode：https://leetcode.cn/problems/longest-repeating-character-replacement/description/
 */

class Solution {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        /// 统计窗口中每个字符的出现次数
        var windowCharacterCount = Array(repeating: 0, count: 26)
        let baseCharacter = Character("A").asciiValue!
        /// 记录窗口中字符的最多重复次数
        var windowMaxCount = 0
        var left = 0
        var right = 0
        /// 将字符串转换为字符数组，便于索引访问
        var sArray = Array(s)
        /// 记录结果长度
        var res = 0
        while right < sArray.count {
            /// 扩大窗口
            let rightIndex = Int(sArray[right].asciiValue! - baseCharacter)
            windowCharacterCount[rightIndex] += 1
            windowMaxCount = max(windowMaxCount, windowCharacterCount[rightIndex])
            right += 1
            
            /// 当需要替换的字符数量超过 k 时，缩小窗口
            while right - left - windowMaxCount > k {
                let leftIndex = Int(sArray[left].asciiValue! - baseCharacter)
                windowCharacterCount[leftIndex] -= 1
                left += 1
            }
            
            /// 更新连续最长字符串长度
            res = max(res, right - left)
        }
        return res
    }
}

print(Solution().characterReplacement("ABAB", 2))
print(Solution().characterReplacement("AABABBA", 1))

//: [Next](@next)
