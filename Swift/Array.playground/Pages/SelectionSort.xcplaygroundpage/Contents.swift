//: [Previous](@previous)

import Foundation

/*
 > - 首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置
 > - 再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。
 > - 重复第二步，直到所有元素均排序完毕。
 
 ### 复杂度分析

 - 交换次数要远远少于冒泡排序，平均性能优于冒泡排序
 - 最好、最坏、平均时间复杂度：O(n²)，空间复杂度O(1)
 - 属于不稳定排序
 */
func selectionSort(array: inout Array<Int>) {
    guard array.count > 1 else { return }
    /// 总共要经过N-1轮比较
    for i in 0..<array.count {
        var min = i
        
        /// 每轮需要比较的次数N-i
        var j = i + 1
        while j < array.count {
            if array[j] < array[min] {
                min = j
            }
            j += 1
        }
        
        /// 将找到的最小值和i位置所在的值进行交换
        if min != i {
            array.swapAt(i, min)
        }
    }
}

/// test
var array = [2, 3, 5, 1, 6, 0]
selectionSort(array: &array)
print(array)

//: [Next](@next)
