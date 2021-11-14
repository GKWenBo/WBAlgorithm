//: [Previous](@previous)

/*
 计数排序是一种非基于比较的排序算法，其空间复杂度和时间复杂度均为O(n+k)，其中k是整数的范围。基于比较的排序算法时间复杂度最小是O(nlogn)的。该算法于1954年由 Harold H. Seward 提出。

 计数排序的核心在于将输入的数据值转化为键存储在额外开辟的数组空间中。作为一种线性时间复杂度的排序，计数排序要求输入的数据必须是有确定范围的整数。
 
 ### 算法步骤
 花O(n)的时间扫描一下整个序列 A，获取最小值 min 和最大值 max

 开辟一块新的空间创建新的数组 B，长度为 ( max - min + 1)

 数组 B 中 index 的元素记录的值是 A 中某元素出现的次数

 最后输出目标整数序列，具体的逻辑是遍历数组 B，输出相应元素以及对应的个数
 
 
 */

import Foundation

func countingSort(nums: [Int]) -> [Int] {
    guard nums.count > 1 else {
        return nums
    }
    
    var nums = nums
    
    /// 获取最大元素
    let maxValue = getMaxValue(nums)
    let bucketLen = maxValue + 1
    /// 新建数组
    var bucket = [Int](repeating: 0, count: bucketLen)
    for value in nums {
        bucket[value] += 1
    }
    
    var sortedIndex = 0
    for i in 0..<bucketLen {
        while bucket[i] > 0 {
            nums[sortedIndex] = i
            bucket[i] -= 1
            sortedIndex += 1
        }
    }
    return nums
}

func getMaxValue(_ nums: [Int]) -> Int {
    var max = nums.first!
    for value in nums {
        if max < value {
            max = value
        }
    }
    return max
}

// test
var array = [2, 3, 5, 1, 6, 10, 23]
countingSort(nums: array)

//: [Next](@next)
