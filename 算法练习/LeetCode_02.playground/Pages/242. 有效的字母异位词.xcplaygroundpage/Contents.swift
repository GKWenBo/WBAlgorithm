//: [Previous](@previous)

import Foundation

/*
 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的 字母异位词。

  

 示例 1:

 输入: s = "anagram", t = "nagaram"
 输出: true
 示例 2:

 输入: s = "rat", t = "car"
 输出: false
  

 提示:

 1 <= s.length, t.length <= 5 * 104
 s 和 t 仅包含小写字母
  

 进阶: 如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
 
 LeetCode: https://leetcode.cn/problems/valid-anagram/description/
 */

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }

        // 用长度 26 的计数数组，避免哈希开销，O(n) 时间，O(1) 空间
        var counts = [Int](repeating: 0, count: 26)
        let aScalar = Int(Character("a").asciiValue!)

        for c in s {
            counts[Int(c.asciiValue!) - aScalar] += 1
        }
        for c in t {
            counts[Int(c.asciiValue!) - aScalar] -= 1
        }

        return counts.allSatisfy { $0 == 0 }
    }
}

// 进阶：输入含 Unicode 字符时，改用 Dictionary 统计频次，O(n) 时间，O(k) 空间（k 为不同字符数）
class SolutionUnicode {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        var counts: [Character: Int] = [:]
        for c in s { counts[c, default: 0] += 1 }
        for c in t { counts[c, default: 0] -= 1 }

        return counts.values.allSatisfy { $0 == 0 }
    }
}

//: [Next](@next)
