//: [Previous](@previous)

import Foundation

/*
 快速排序算法的本质

 > **逐渐将每一个元素都转换成轴点元素**

 > - 从数列中挑出一个元素，称为 “基准”（pivot）;
 > - 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分区退出之后，该基准就处于数列的中间位置。这个称为分区（partition）操作；
 > - 递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序；
 
 ### 复杂度分析
 最好、平均时间复杂度：O(nlogn)
 最坏时间复杂度（轴点元素极度不均匀）：O(n²)
 空间复杂度：O(logn)

 #### 稳定性
 不稳定性排序
 
 */

func quickSort(array: inout Array<Int>) {
    quickSourtInternally(array: &array, left: 0, right: array.count - 1)
}

func quickSourtInternally(array: inout Array<Int>, left: Int, right: Int) {
    /// 递归终止条件
    guard left < right else { return }
    
    /// 获取分区点
    let partitionIndex = partition(array: &array, left: left, right: right)
    quickSourtInternally(array: &array, left: left, right: partitionIndex - 1)
    quickSourtInternally(array: &array, left: partitionIndex + 1, right: right)
}

func partition(array: inout Array<Int>, left: Int, right: Int) -> Int {
    /// 设定基准值（pivot）
    let pivot = left
    var index = pivot + 1

    for i in index...right {
        if array[i] < array[pivot] {
            array.swapAt(i, index)
            index += 1
        }
    }
    array.swapAt(pivot, index - 1)
    return index - 1
}

/// test
var array = [2, 3, 5, 1, 6, 0, -1]
quickSort(array: &array)
print(array)

//: [Next](@next)
