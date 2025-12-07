import Foundation

/*
 给定两个字符串 s 和 t，长度分别是 m 和 n，返回 s 中的 最短窗口 子串，使得该子串包含 t 中的每一个字符（包括重复字符）。如果没有这样的子串，返回空字符串 ""。

 测试用例保证答案唯一。

  

 示例 1：

 输入：s = "ADOBECODEBANC", t = "ABC"
 输出："BANC"
 解释：最小覆盖子串 "BANC" 包含来自字符串 t 的 'A'、'B' 和 'C'。
 示例 2：

 输入：s = "a", t = "a"
 输出："a"
 解释：整个字符串 s 是最小覆盖子串。
 示例 3:

 输入: s = "a", t = "aa"
 输出: ""
 解释: t 中两个字符 'a' 均应包含在 s 的子串中，
 因此没有符合条件的子字符串，返回空字符串。


 提示：

 m == s.length
 n == t.length
 1 <= m, n <= 105
 s 和 t 由英文字母组成
  

 进阶：你能设计一个在 O(m + n) 时间内解决此问题的算法吗？
 
 LeetCode：https://leetcode.cn/problems/minimum-window-substring/description/
 */

class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        guard !s.isEmpty, !t.isEmpty else { return "" }
        
        var need: [Character: Int] = [:]
        var window: [Character: Int] = [:]
        for c in t {
            need[c] = need[c, default: 0] + 1
        }
        
        var sArray = Array(s)
        
        var left = 0
        var right = 0
        var valid = 0
        // 记录最小覆盖子串的起始索引及长度
        var start = 0
        var len = Int.max
        while right < sArray.count {
            /// c 是将移入窗口的字符
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
            while valid == need.count {
                /// 在这里更新最小覆盖子串
                if right - left < len {
                    start = left
                    len = right - left
                }
                
                /// d 是将移出窗口的字符
                let d = sArray[left]
                /// 缩小窗口
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
        /// 返回最小覆盖子串
        return len == Int.max ? "" : String(sArray[start..<(start + len)])
    }
}

let s = "ADOBECODEBANC"
let t = "ABC"

print(Solution().minWindow(s, t))
