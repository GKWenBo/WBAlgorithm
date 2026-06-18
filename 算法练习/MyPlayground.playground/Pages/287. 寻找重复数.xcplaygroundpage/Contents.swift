//: [Previous](@previous)

import Foundation

/*
 给定一个包含 n + 1 个整数的数组 nums ，其数字都在 [1, n] 范围内（包括 1 和 n），可知至少存在一个重复的整数。

 假设 nums 只有 一个重复的整数 ，返回 这个重复的数 。

 你设计的解决方案必须 不修改 数组 nums 且只用常量级 O(1) 的额外空间。

 示例 1：

 输入：nums = [1,3,4,2,2]
 输出：2
 示例 2：

 输入：nums = [3,1,3,4,2]
 输出：3
 示例 3 :

 输入：nums = [3,3,3,3,3]
 输出：3
 提示：

 1 <= n <= 105
 nums.length == n + 1
 1 <= nums[i] <= n
 nums 中 只有一个整数 出现 两次或多次 ，其余整数均只出现 一次
 进阶：

 如何证明 nums 中至少存在一个重复的数字?
 你可以设计一个线性级时间复杂度 O(n) 的解决方案吗？
 */

/*
 解题思路：Floyd 判圈算法（龟兔赛跑）

 核心思想：将数组视为隐式链表，下标 i 指向 nums[i]。
 由于存在重复数字，必然出现两个下标指向同一位置，即形成环。
 重复数字就是环的入口节点。

 例：nums = [1,3,4,2,2]
   下标:  0→1, 1→3, 2→4, 3→2, 4→2
   链表:  0 → 1 → 3 → 2 → 4 → 2（2和4构成环，入口为2）

 第一阶段：快慢指针找相遇点
   fast 每次走两步（nums[nums[fast]]），slow 每次走一步（nums[slow]）
   相遇时，fast 比 slow 多走了整数倍的环长

 第二阶段：找环入口（即重复数字）
   将 slow 重置到起点 0，fast 留在相遇点
   两指针各走一步，再次相遇点即为环入口

 时间复杂度：O(n)
 空间复杂度：O(1)
 */

class Solution {
    func findDuplicate(_ nums: [Int]) -> Int {
        var fast = 0
        var slow = 0

        // 第一阶段：快慢指针，找到环内相遇点
        while true {
            fast = nums[nums[fast]]  // fast 走两步
            slow = nums[slow]        // slow 走一步
            if fast == slow {
                break
            }
        }

        // 第二阶段：slow 回到起点，两指针同速前进，相遇即为环入口（重复数字）
        slow = 0
        while slow != fast {
            slow = nums[slow]
            fast = nums[fast]
        }
        return slow
    }
}

// MARK: - 测试

let solution = Solution()

/// 验证结果并打印测试信息
func assertEqual(_ result: Int, expected: Int, testCase: String) {
    if result == expected {
        print("✅ \(testCase) => \(result)")
    } else {
        print("❌ \(testCase) => 期望 \(expected)，实际 \(result)")
    }
}

// 基础用例
assertEqual(solution.findDuplicate([1, 3, 4, 2, 2]), expected: 2, testCase: "[1,3,4,2,2]")
assertEqual(solution.findDuplicate([3, 1, 3, 4, 2]), expected: 3, testCase: "[3,1,3,4,2]")

// 重复数字出现多次
assertEqual(solution.findDuplicate([3, 3, 3, 3, 3]), expected: 3, testCase: "[3,3,3,3,3]")

// 最小规模：n=1，数组长度为2
assertEqual(solution.findDuplicate([1, 1]), expected: 1, testCase: "[1,1]")

// 重复数字在首位
assertEqual(solution.findDuplicate([2, 2, 1]), expected: 2, testCase: "[2,2,1]")

// 重复数字为最大值 n
assertEqual(solution.findDuplicate([1, 2, 3, 4, 4]), expected: 4, testCase: "[1,2,3,4,4]")

// 较大规模
assertEqual(solution.findDuplicate([1, 2, 3, 4, 5, 6, 7, 8, 9, 5]), expected: 5, testCase: "[1,2,3,4,5,6,7,8,9,5]")

//: [Next](@next)
