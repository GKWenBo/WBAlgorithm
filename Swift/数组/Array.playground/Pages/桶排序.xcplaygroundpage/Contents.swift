//: [Previous](@previous)

/*
 桶排序(Bucket sort)是一种基于计数的排序算法（计数排序可参考上节的内容），工作的原理是将数据分到有限数量的桶子里，然后每个桶再分别排序（有可能再使用别的排序算法或是以递回方式继续使用桶排序进行排序）
 
 ### 算法步骤
 设置固定数量的空桶。

 把数据放到对应的桶中。

 对每个不为空的桶中数据进行排序。

 拼接不为空的桶中数据，得到结果。
 */

import Foundation

func bucketSourt(_ nums: [Int], bucketSize: Int) -> [Int] {
    guard nums.count > 1 else {
        return nums
    }
    
    var nums = nums
    
    var minValue = nums[0]
    var maxValue = nums[0]
    for value in nums {
        if value < minValue {
            minValue = value
        } else if maxValue < value {
            maxValue = value
        }
    }
    
    let bucketCount: Int = Int(floorf((Float(maxValue) - Float(minValue)) / Float(bucketSize)) + 1)
    var buckets: [[Int]] = Array.init(repeating: [], count: bucketCount)
    /// 利用映射函数将数据分配到各个桶中
    for i in 0..<nums.count {
        let index = Int(floorf((Float(nums[i]) - Float(minValue)) / Float(bucketSize)))
        buckets[index] = arrAppend(buckets[index], value: nums[i])
    }
    
    var arrIndex = 0;
    for bucket in buckets {
        guard !bucket.isEmpty else {
            continue
        }
        
        // 对每个桶进行排序，这里使用了插入排序
        let sortedBucket = insertionSort(bucket)
        for value in sortedBucket {
            nums[arrIndex] = value
            arrIndex += 1
        }
    }
    return nums
}

func arrAppend(_ nums: [Int], value: Int) -> [Int] {
    var nums = nums
    nums.append(value)
    return nums
}

func insertionSort(_ nums: [Int]) -> [Int] {
    var nums = nums
    for i in 0..<nums.count {
        let value = nums[i]
        var j = i - 1
        while j >= 0 {
            if nums[j] > value {
                nums.swapAt(j, j + 1)
            } else {
                break
            }
            j -= 1
        }
        nums[j + 1] = value
    }
    return nums
}

/// test
var array = [2, 3, 5, 1, 6, 10, 23]
bucketSourt(array, bucketSize: 3)

//: [Next](@next)
