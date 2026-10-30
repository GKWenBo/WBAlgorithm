//: [Previous](@previous)

import Foundation

/*
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

 有效字符串需满足：

 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。
 每个右括号都有一个对应的相同类型的左括号。
 
 LeetCode: https://leetcode.cn/problems/valid-parentheses/description/
 */

// 思路：栈
//
// 括号匹配具有"后进先出"的特性：最近出现的左括号必须最先被闭合。
//   1. 遇到左括号：入栈。
//   2. 遇到右括号：栈顶必须是与之匹配的左括号，否则无效；匹配则弹出栈顶。
//      （若此时栈为空，说明右括号没有对应的左括号，同样无效）
//   3. 遍历结束后栈必须为空，否则存在未闭合的左括号。
//
// 时间复杂度 O(n)，空间复杂度 O(n)
class Solution {
    // 左括号 → 对应的右括号
    private let map: [Character: Character] = ["(": ")", "{": "}", "[": "]"]

    func isValid(_ s: String) -> Bool {
        // 奇数长度一定无法两两配对，提前剪枝
        if s.count % 2 != 0 { return false }

        var stack: [Character] = []
        for c in s {
            if map.keys.contains(c) {
                stack.append(c)
            } else {
                // 栈为空（多余的右括号）或栈顶不匹配，均无效
                guard let last = stack.popLast(), map[last] == c else {
                    return false
                }
            }
        }
        return stack.isEmpty
    }
}

// MARK: - 测试

let solution = Solution()

// 示例 1：简单配对
assert(solution.isValid("()"), "示例1失败")

// 示例 2：多种括号依次配对
assert(solution.isValid("()[]{}"), "示例2失败")

// 示例 3：类型不匹配
assert(!solution.isValid("(]"), "示例3失败")

// 示例 4：嵌套合法
assert(solution.isValid("([])"), "示例4失败")

// 示例 5：顺序错误（交叉闭合）
assert(!solution.isValid("([)]"), "示例5失败")

// 空字符串视为有效
assert(solution.isValid(""), "空字符串失败")

// 只有一个右括号：栈为空时遇到右括号
assert(!solution.isValid(")"), "单个右括号失败")

// 只有一个左括号：遍历结束栈非空
assert(!solution.isValid("("), "单个左括号失败")

// 右括号在前：栈为空时遇到右括号
assert(!solution.isValid(")("), "右括号在前失败")

// 多余的右括号（长度为偶数，仍需靠栈判空发现）
assert(!solution.isValid("())("), "多余右括号失败")

// 多余的左括号
assert(!solution.isValid("(("), "多余左括号失败")

// 深层嵌套
assert(solution.isValid("{[(())]}"), "深层嵌套失败")

// 嵌套 + 并列混合
assert(solution.isValid("{[]}()[{}]"), "混合结构失败")

// 前半合法、后半有多余右括号
assert(!solution.isValid("()]"), "尾部多余右括号失败")

print("所有测试通过 ✓")

//: [Next](@next)
