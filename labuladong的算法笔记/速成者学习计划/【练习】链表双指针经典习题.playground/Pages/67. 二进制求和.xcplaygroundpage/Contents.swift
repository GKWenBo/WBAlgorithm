//: [Previous](@previous)

import Foundation

/*
 给你两个二进制字符串 a 和 b ，以二进制字符串的形式返回它们的和。


 示例 1：

 输入:a = "11", b = "1"
 输出："100"
 示例 2：

 输入：a = "1010", b = "1011"
 输出："10101"
  

 提示：

 1 <= a.length, b.length <= 104
 a 和 b 仅由字符 '0' 或 '1' 组成
 字符串如果不是 "0" ，就不含前导零
 
 LeetCode：https://leetcode.cn/problems/add-binary/description/
 */

class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        /// 将数字字符串转成数组，倒序存储，方便后续取值计算
        let arrayA = Array(a.reversed()).map({ "\($0)" })
        let arrayB = Array(b.reversed()).map({ "\($0)" })
        
        /// 数组下标
        var indexA = 0
        var indexB = 0
        
        /// 存储计算结果数组
        var res: [String] = []
        
        var curry = 0
        while indexA < arrayA.count || indexB < arrayB.count || curry > 0 {
            var num = curry
            if indexA < arrayA.count  {
                num += Int(arrayA[indexA]) ?? 0
                indexA += 1
            }
            if indexB < arrayB.count {
                num += Int(arrayB[indexB]) ?? 0
                indexB += 1
            }
            
            /// 处理进位
            curry = num / 2
            num = num % 2
            
            res.insert("\(num)", at: 0)
        }
        return res.joined()
    }
}

let a = "1010"
let b = "1011"

let res = Solution().addBinary(a, b)

let res1 = Solution().addBinary("11", "1")


//: [Next](@next)
