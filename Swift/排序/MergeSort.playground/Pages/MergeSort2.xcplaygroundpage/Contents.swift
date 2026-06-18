import Foundation

/*
 归并排序（Merge Sort）

 核心思路：
 1. 【分】将数组不断二分，直到每个子数组只剩 1 个元素（天然有序）
 2. 【治】将相邻的两个有序子数组合并，最终得到完整的有序数组

 时间复杂度：O(n log n) —— 最好、最坏、平均均如此
 空间复杂度：O(n)         —— 合并时需要辅助数组
 */

// MARK: - 归并排序入口

func mergeSort(_ array: inout [Int]) {
    guard array.count > 1 else { return }
    divideAndSort(&array, left: 0, right: array.count - 1)
}

// MARK: - 分治递归

/// 对 array[left...right] 范围内的元素进行递归排序
func divideAndSort(_ array: inout [Int], left: Int, right: Int) {
    // 递归终止：范围内只剩一个元素时，已天然有序
    guard left < right else { return }

    // 取中点，写成 left + (right - left) / 2 可避免两数相加溢出
    let mid = left + (right - left) / 2

    // 递归排序左半部分 array[left...mid]
    divideAndSort(&array, left: left, right: mid)

    // 递归排序右半部分 array[mid+1...right]
    divideAndSort(&array, left: mid + 1, right: right)

    // 将两个已排序的子数组合并为一个有序数组
    merge(&array, left: left, mid: mid, right: right)
}

// MARK: - 合并两个有序子数组

/// 将已排序的 array[left...mid] 和 array[mid+1...right] 合并成一段有序数组
func merge(_ array: inout [Int], left: Int, mid: Int, right: Int) {
    var result = [Int]()
    result.reserveCapacity(right - left + 1)

    var leftIndex = left        // 左子数组的当前指针
    var rightIndex = mid + 1    // 右子数组的当前指针

    // 双指针：每次取两侧中较小的元素，依次放入 result
    while leftIndex <= mid && rightIndex <= right {
        if array[leftIndex] <= array[rightIndex] {
            result.append(array[leftIndex])
            leftIndex += 1
        } else {
            result.append(array[rightIndex])
            rightIndex += 1
        }
    }

    // 将左侧剩余元素追加（右侧已耗尽，或左侧本身就有剩余）
    while leftIndex <= mid {
        result.append(array[leftIndex])
        leftIndex += 1
    }

    // 将右侧剩余元素追加（左侧已耗尽，或右侧本身就有剩余）
    while rightIndex <= right {
        result.append(array[rightIndex])
        rightIndex += 1
    }

    // 将排好序的 result 写回原数组对应的位置
    for (offset, value) in result.enumerated() {
        array[left + offset] = value
    }
}

// MARK: - 测试

var array = [2, 3, 5, 1, 6, 0]
mergeSort(&array)
print(array) // [0, 1, 2, 3, 5, 6]
