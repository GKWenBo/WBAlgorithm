//: [Previous](@previous)

import Foundation
/*
 编写一个函数来查找字符串数组中的最长公共前缀。

 如果不存在公共前缀，返回空字符串 ""。

  

 示例 1：

 输入：strs = ["flower","flow","flight"]
 输出："fl"
 示例 2：

 输入：strs = ["dog","racecar","car"]
 输出：""
 解释：输入不存在公共前缀。
  

 提示：

 1 <= strs.length <= 200
 0 <= strs[i].length <= 200
 strs[i] 如果非空，则仅由小写英文字母组成
 
 LeetCode：https://leetcode.cn/problems/longest-common-prefix/description/
 */

class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        let rowCount = strs.count
        /// 以第一行的列数为基准
        let columnCount = strs[0].count
        for column in 0..<columnCount {
            for row in 1..<rowCount {
                let thisStr = strs[row]
                let preStr = strs[row - 1]
                // 判断每个字符串的 col 索引是否都相同
                if thisStr.count <= column || preStr.count <= column || thisStr[thisStr.index(thisStr.startIndex, offsetBy: column)] != preStr[preStr.index(preStr.startIndex, offsetBy: column)] {
                    // 发现不匹配的字符，只有 strs[row][0..col-1] 是公共前缀
                    return String(strs[row].prefix(column))
                }
            }
        }
        return strs[0]
    }
}

let strs = ["flower","flow","flight"]
print(Solution().longestCommonPrefix(strs))

//: [Next](@next)
