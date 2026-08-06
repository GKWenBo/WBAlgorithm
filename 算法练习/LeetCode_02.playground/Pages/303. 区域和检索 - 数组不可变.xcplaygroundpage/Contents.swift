//: [Previous](@previous)

import Foundation

/*
 给定一个整数数组  nums，处理以下类型的多个查询:

 计算索引 left 和 right （包含 left 和 right）之间的 nums 元素的 和 ，其中 left <= right
 实现 NumArray 类：

 NumArray(int[] nums) 使用数组 nums 初始化对象
 int sumRange(int left, int right) 返回数组 nums 中索引 left 和 right 之间的元素的 总和 ，包含 left 和 right 两点（也就是 nums[left] + nums[left + 1] + ... + nums[right] )
  

 示例 1：

 输入：
 ["NumArray", "sumRange", "sumRange", "sumRange"]
 [[[-2, 0, 3, -5, 2, -1]], [0, 2], [2, 5], [0, 5]]
 输出：
 [null, 1, -1, -3]

 解释：
 NumArray numArray = new NumArray([-2, 0, 3, -5, 2, -1]);
 numArray.sumRange(0, 2); // return 1 ((-2) + 0 + 3)
 numArray.sumRange(2, 5); // return -1 (3 + (-5) + 2 + (-1))
 numArray.sumRange(0, 5); // return -3 ((-2) + 0 + 3 + (-5) + 2 + (-1))
  

 提示：

 1 <= nums.length <= 104
 -105 <= nums[i] <= 105
 0 <= left <= right < nums.length
 最多调用 104 次 sumRange 方法
 
 LeetCode: https://leetcode.cn/problems/range-sum-query-immutable/description/
 */


// 前缀和方案：preSum[i] 表示 nums[0..<i] 的总和
// sumRange(left, right) = preSum[right+1] - preSum[left]
// 时间复杂度：初始化 O(n)，查询 O(1)；空间复杂度 O(n)
class NumArray {

    // preSum 长度为 nums.count + 1，preSum[0] = 0 作哨兵
    var preSum: [Int]

    init(_ nums: [Int]) {
        preSum = [Int](repeating: 0, count: nums.count + 1)
        // 注意上界须用 nums.count（闭区间），否则最后一个元素不会被计入
        for i in 1...nums.count {
            preSum[i] = preSum[i - 1] + nums[i - 1]
        }
    }

    func sumRange(_ left: Int, _ right: Int) -> Int {
        return preSum[right + 1] - preSum[left]
    }
}

// MARK: - 测试

// 辅助断言：失败时打印期望值与实际值
func assertEqual(_ actual: Int, _ expected: Int, _ label: String) {
    if actual == expected {
        print("✅ \(label): \(actual)")
    } else {
        print("❌ \(label): 期望 \(expected)，实际 \(actual)")
    }
}

// 示例 1：题目给出的基础用例
let numArray = NumArray([-2, 0, 3, -5, 2, -1])
assertEqual(numArray.sumRange(0, 2), 1,  "sumRange(0,2)")   // -2+0+3 = 1
assertEqual(numArray.sumRange(2, 5), -1, "sumRange(2,5)")   // 3+(-5)+2+(-1) = -1
assertEqual(numArray.sumRange(0, 5), -3, "sumRange(0,5)")   // 全部之和 = -3

// 边界：单元素数组
let single = NumArray([7])
assertEqual(single.sumRange(0, 0), 7, "单元素 sumRange(0,0)")

// 边界：left == right（查询单个元素）
let arr = NumArray([1, 2, 3, 4, 5])
assertEqual(arr.sumRange(2, 2), 3,  "left==right sumRange(2,2)")

// 边界：覆盖整个数组
assertEqual(arr.sumRange(0, 4), 15, "全数组 sumRange(0,4)")

// 含负数
let neg = NumArray([-5, -3, -1, -4])
assertEqual(neg.sumRange(1, 3), -8, "全负数 sumRange(1,3)") // -3+(-1)+(-4) = -8

// 多次查询同一对象
assertEqual(arr.sumRange(0, 1), 3,  "多次查询 sumRange(0,1)")
assertEqual(arr.sumRange(3, 4), 9,  "多次查询 sumRange(3,4)")

//: [Next](@next)
