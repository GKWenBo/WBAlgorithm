//: [Previous](@previous)

import Foundation

/// 双指针求所有两数之和等于 target 的数对，返回去重后的结果。
/// 时间复杂度 O(n log n)（排序主导），空间复杂度 O(n)。
func twoSum(_ nums: [Int], _ target: Int) -> [[Int]] {
    return twoSum(nums, 0, target)
}

func twoSum(_ nums: [Int], _ start: Int, _ target: Int) -> [[Int]] {
    // 先排序，使双指针的单调性成立
    let nums = nums.sorted()
    var low = start
    var high = nums.count - 1

    var res: [[Int]] = []
    while low < high {
        let numLeft = nums[low]
        let numRight = nums[high]
        let sum = numLeft + numRight
        if sum < target {
            // 和偏小，左指针右移；跳过相同值避免重复记录
            while low < high && nums[low] == numLeft { low += 1 }
        } else if sum > target {
            // 和偏大，右指针左移；同理跳过相同值
            while low < high && nums[high] == numRight { high -= 1 }
        } else {
            // 找到一对，记录后两侧同时跳过重复值
            res.append([numLeft, numRight])
            while low < high && nums[low] == numLeft { low += 1 }
            while low < high && nums[high] == numRight { high -= 1 }
        }
    }
    return res
}

// MARK: - Tests

struct TestCase {
    let nums: [Int]
    let target: Int
    let expected: [[Int]]
    let description: String
}

func runTests() {
    let cases: [TestCase] = [
        TestCase(
            nums: [1, 2, 3, 4],
            target: 5,
            expected: [[1, 4], [2, 3]],
            description: "基本情况：多对结果"
        ),
        TestCase(
            nums: [1, 2, 3],
            target: 10,
            expected: [],
            description: "无满足条件的数对"
        ),
        TestCase(
            nums: [1, 1, 2, 3, 4, 4],
            target: 5,
            expected: [[1, 4], [2, 3]],
            description: "含重复元素，自动去重"
        ),
        TestCase(
            nums: [2, 2, 2],
            target: 4,
            expected: [[2, 2]],
            description: "全相同元素"
        ),
        TestCase(
            nums: [-3, -1, 0, 1, 3, 5],
            target: 0,
            expected: [[-3, 3], [-1, 1]],
            description: "含负数"
        ),
        TestCase(
            nums: [1, 2],
            target: 3,
            expected: [[1, 2]],
            description: "只有两个元素"
        ),
        TestCase(
            nums: [],
            target: 0,
            expected: [],
            description: "空数组"
        ),
        TestCase(
            nums: [1, 3, 5, 7],
            target: 6,
            expected: [[1, 5]],
            description: "只有一对结果"
        ),
        TestCase(
            nums: [4, 1, 3, 2],
            target: 5,
            expected: [[1, 4], [2, 3]],
            description: "乱序输入，验证排序逻辑"
        ),
    ]

    var passCount = 0
    for tc in cases {
        let result = twoSum(tc.nums, tc.target)
        let pass = result == tc.expected
        let mark = pass ? "✅" : "❌"
        print("\(mark) \(tc.description)")
        if !pass {
            print("   期望: \(tc.expected)")
            print("   实际: \(result)")
        }
        if pass { passCount += 1 }
    }
    print("\n共 \(cases.count) 个测试，通过 \(passCount) 个，失败 \(cases.count - passCount) 个")
}

runTests()

//: [Next](@next)
