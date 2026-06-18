//: [Previous](@previous)

import Foundation

// 思路：分治。每次选一个基准值（pivot），将数组分为"小于 pivot"和"大于等于 pivot"两部分，
// 递归排序两部分。平均时间复杂度 O(n log n)，最坏 O(n²)（已用随机化规避）。

// 入口：对整个数组执行快速排序
func quickSort(_ nums: inout [Int]) {
    quickSort(&nums, low: 0, high: nums.count - 1)
}

// 递归主体：对 nums[low...high] 区间排序
func quickSort(_ nums: inout [Int], low: Int, high: Int) {
    // 区间只剩 0 或 1 个元素时，天然有序，递归终止
    guard low < high else {
        return
    }

    let pivotIndex = partition(&nums, low: low, high: high)

    // pivot 已就位，分别排序左右两段（pivot 本身不参与）
    quickSort(&nums, low: low, high: pivotIndex - 1)
    quickSort(&nums, low: pivotIndex + 1, high: high)
}

// 分区：将 nums[low...high] 以 pivot 为界重新排列，返回 pivot 的最终下标
// 使用随机化选取 pivot，避免有序输入退化为 O(n²)
func partition(_ nums: inout [Int], low: Int, high: Int) -> Int {
    // 随机选取 pivot 并换到末尾，简化后续遍历逻辑
    let randomIndex = Int.random(in: low...high)
    nums.swapAt(randomIndex, high)

    let pivot = nums[high]

    // insertIndex 指向下一个"小于 pivot 区"的插入位置
    var insertIndex = low

    // 遍历 low..<high，将小于 pivot 的元素依次换到左侧
    for current in low..<high where nums[current] < pivot {
        nums.swapAt(current, insertIndex)
        insertIndex += 1
    }

    // 将 pivot 放到最终位置：左边全小于它，右边全大于等于它
    nums.swapAt(insertIndex, high)

    return insertIndex
}

// MARK: - 测试

func assert(_ condition: Bool, _ message: String) {
    if condition {
        print("✅ PASS: \(message)")
    } else {
        print("❌ FAIL: \(message)")
    }
}

// 测试 1：普通乱序数组
do {
    var nums = [3, 6, 8, 10, 1, 2, 1]
    quickSort(&nums)
    assert(nums == [1, 1, 2, 3, 6, 8, 10], "普通乱序数组排序")
}

// 测试 2：已排序数组（升序）
do {
    var nums = [1, 2, 3, 4, 5]
    quickSort(&nums)
    assert(nums == [1, 2, 3, 4, 5], "已升序排列的数组")
}

// 测试 3：逆序数组
do {
    var nums = [5, 4, 3, 2, 1]
    quickSort(&nums)
    assert(nums == [1, 2, 3, 4, 5], "逆序数组排序")
}

// 测试 4：含重复元素
do {
    var nums = [4, 2, 4, 1, 2]
    quickSort(&nums)
    assert(nums == [1, 2, 2, 4, 4], "含重复元素的数组")
}

// 测试 5：所有元素相同
do {
    var nums = [7, 7, 7, 7]
    quickSort(&nums)
    assert(nums == [7, 7, 7, 7], "所有元素相同")
}

// 测试 6：单个元素
do {
    var nums = [42]
    quickSort(&nums)
    assert(nums == [42], "单元素数组")
}

// 测试 7：空数组
do {
    var nums: [Int] = []
    quickSort(&nums)
    assert(nums == [], "空数组")
}

// 测试 8：含负数
do {
    var nums = [0, -3, 5, -1, 2]
    quickSort(&nums)
    assert(nums == [-3, -1, 0, 2, 5], "含负数的数组")
}

//: [Next](@next)
