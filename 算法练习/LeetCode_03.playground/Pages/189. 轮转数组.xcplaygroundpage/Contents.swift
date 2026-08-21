//: [Previous](@previous)

import Foundation

/*
 给定一个整数数组 nums，将数组中的元素向右轮转 k 个位置，其中 k 是非负数。



 示例 1:

 输入: nums = [1,2,3,4,5,6,7], k = 3
 输出: [5,6,7,1,2,3,4]
 解释:
 向右轮转 1 步: [7,1,2,3,4,5,6]
 向右轮转 2 步: [6,7,1,2,3,4,5]
 向右轮转 3 步: [5,6,7,1,2,3,4]
 示例 2:

 输入：nums = [-1,-100,3,99], k = 2
 输出：[3,99,-1,-100]
 解释:
 向右轮转 1 步: [99,-1,-100,3]
 向右轮转 2 步: [3,99,-1,-100]


 提示：

 1 <= nums.length <= 105
 -231 <= nums[i] <= 231 - 1
 0 <= k <= 105


 进阶：

 尽可能想出更多的解决方案，至少有 三种 不同的方法可以解决这个问题。
 你可以使用空间复杂度为 O(1) 的 原地 算法解决这个问题吗？

 LeetCode: https://leetcode.cn/problems/rotate-array/
 */

// MARK: - 方法一：三次翻转（原地，推荐）
/*
 核心思路：向右轮转 k 位等价于将数组分成两段后交换位置。
 以 [1,2,3,4,5,6,7], k=3 为例：
   1. 翻转整体：[7,6,5,4,3,2,1]
   2. 翻转前 k 项：[5,6,7,4,3,2,1]
   3. 翻转后 n-k 项：[5,6,7,1,2,3,4] ✓

 时间复杂度：O(n)，每个元素最多被翻转 2 次
 空间复杂度：O(1)，原地操作，只用常数额外空间
 */
class Solution {
    func rotate(_ nums: inout [Int], _ k: Int) {
        let n = nums.count
        // 对 n 取模，处理 k >= n 及 k = 0 的情况
        let k = k % n
        guard k > 0 else { return }

        reverse(&nums, 0, n - 1)   // 步骤 1：翻转整体
        reverse(&nums, 0, k - 1)   // 步骤 2：翻转前 k 项
        reverse(&nums, k, n - 1)   // 步骤 3：翻转后 n-k 项
    }

    // 原地翻转 arr[left...right]
    private func reverse(_ arr: inout [Int], _ left: Int, _ right: Int) {
        var left = left
        var right = right
        while left < right {
            arr.swapAt(left, right)
            left += 1
            right -= 1
        }
    }
}

// MARK: - 方法二：使用额外数组（直观易懂）
/*
 核心思路：新建数组，将原数组第 i 个元素放到新数组第 (i+k)%n 处。

 时间复杂度：O(n)
 空间复杂度：O(n)，需要额外数组
 */
class Solution2 {
    func rotate(_ nums: inout [Int], _ k: Int) {
        let n = nums.count
        let k = k % n
        guard k > 0 else { return }

        var result = [Int](repeating: 0, count: n)
        for i in 0 ..< n {
            result[(i + k) % n] = nums[i]
        }
        nums = result
    }
}

// MARK: - 方法三：环状替换（原地）
/*
 核心思路：从索引 0 出发，每次将当前元素放到它轮转后的目标位置，
 被替换的元素继续往下替换，直到回到起点。
 若 n 与 k 不互质，需要从多个起点出发，起点数等于 gcd(n, k)。

 时间复杂度：O(n)，每个元素恰好被移动一次
 空间复杂度：O(1)
 */
class Solution3 {
    func rotate(_ nums: inout [Int], _ k: Int) {
        let n = nums.count
        let k = k % n
        guard k > 0 else { return }

        var count = 0   // 已完成移动的元素数
        var start = 0   // 当前环的起点
        while count < n {
            var current = start
            var prev = nums[start]
            repeat {
                let next = (current + k) % n
                let temp = nums[next]
                nums[next] = prev
                prev = temp
                current = next
                count += 1
            } while current != start
            start += 1
        }
    }
}

// MARK: - 测试

func testRotate() {
    // 辅助：统一用方法一测试
    func rotate(_ nums: [Int], _ k: Int) -> [Int] {
        var arr = nums
        Solution().rotate(&arr, k)
        return arr
    }

    // 基础示例
    assert(rotate([1,2,3,4,5,6,7], 3) == [5,6,7,1,2,3,4], "示例1失败")
    assert(rotate([-1,-100,3,99], 2)  == [3,99,-1,-100],   "示例2失败")

    // k = 0：不旋转
    assert(rotate([1,2,3], 0) == [1,2,3], "k=0 失败")

    // k = n：等价于不旋转
    assert(rotate([1,2,3], 3) == [1,2,3], "k=n 失败")

    // k > n：取模后仍正确
    assert(rotate([1,2,3], 4) == [3,1,2], "k>n 失败")

    // 单元素数组
    assert(rotate([42], 5) == [42], "单元素失败")

    // 两元素数组
    assert(rotate([1,2], 1) == [2,1], "双元素 k=1 失败")
    assert(rotate([1,2], 2) == [1,2], "双元素 k=2 失败")

    // 全相同元素
    assert(rotate([7,7,7,7], 2) == [7,7,7,7], "全相同元素失败")

    // 负数
    assert(rotate([-1,-2,-3,-4], 1) == [-4,-1,-2,-3], "负数失败")

    print("所有测试通过 ✓")
}

// 对三种方法分别验证
func testAllSolutions() {
    let cases: [([Int], Int, [Int])] = [
        ([1,2,3,4,5,6,7], 3, [5,6,7,1,2,3,4]),
        ([-1,-100,3,99],  2, [3,99,-1,-100]),
        ([1,2,3],         0, [1,2,3]),
        ([1,2,3],         3, [1,2,3]),
        ([1,2,3],         4, [3,1,2]),
        ([42],            5, [42]),
    ]

    for (input, k, expected) in cases {
        var a1 = input; Solution().rotate(&a1, k)
        var a2 = input; Solution2().rotate(&a2, k)
        var a3 = input; Solution3().rotate(&a3, k)
        assert(a1 == expected, "方法一: \(input) k=\(k) 失败")
        assert(a2 == expected, "方法二: \(input) k=\(k) 失败")
        assert(a3 == expected, "方法三: \(input) k=\(k) 失败")
    }
    print("三种方法全部测试通过 ✓")
}

testRotate()
testAllSolutions()

//: [Next](@next)
