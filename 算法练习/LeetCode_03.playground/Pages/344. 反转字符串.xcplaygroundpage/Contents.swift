//: [Previous](@previous)

import Foundation

/*
 编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。

 不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。

 示例 1：
 输入：s = ["h","e","l","l","o"]
 输出：["o","l","l","e","h"]

 示例 2：
 输入：s = ["H","a","n","n","a","h"]
 输出：["h","a","n","n","a","H"]

 提示：
 1 <= s.length <= 105
 s[i] 都是 ASCII 码表中的可打印字符

 LeetCode: https://leetcode.cn/problems/reverse-string/description/
 */

// MARK: - 解法：双指针原地交换
// 思路：左右指针分别从两端向中间移动，每次交换对应位置字符，直到两指针相遇。
// 时间复杂度：O(n)，n 为字符数组长度，每个字符最多被访问一次
// 空间复杂度：O(1)，原地操作，仅使用两个指针变量

class Solution {
    func reverseString(_ s: inout [Character]) {
        var left = 0
        var right = s.count - 1
        while left < right {
            s.swapAt(left, right)
            left += 1
            right -= 1
        }
    }
}

// MARK: - 测试

let solution = Solution()

@MainActor func check(_ input: [Character], expected: [Character]) {
    var s = input
    solution.reverseString(&s)
    let pass = s == expected
    print(pass ? "✅ PASS" : "❌ FAIL", "| 输入: \(input) | 期望: \(expected) | 实际: \(s)")
}

// 基本用例
check(["h","e","l","l","o"], expected: ["o","l","l","e","h"])
check(["H","a","n","n","a","h"], expected: ["h","a","n","n","a","H"])

// 单个字符（不需要交换）
check(["a"], expected: ["a"])

// 两个字符
check(["a","b"], expected: ["b","a"])

// 偶数长度
check(["1","2","3","4"], expected: ["4","3","2","1"])

// 奇数长度（中间元素不动）
check(["1","2","3","4","5"], expected: ["5","4","3","2","1"])

// 全部相同字符
check(["x","x","x"], expected: ["x","x","x"])

// 包含空格与特殊字符
check(["a"," ","!"], expected: ["!"," ","a"])

//: [Next](@next)
