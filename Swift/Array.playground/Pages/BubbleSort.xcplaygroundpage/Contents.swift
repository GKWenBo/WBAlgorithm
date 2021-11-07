//: [Previous](@previous)

import Foundation

/*
 冒泡排序
 > - 比较相邻的元素。如果第一个比第二个大，就交换他们两个。
 > - 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。这步做完后，最后的元素会是最大的数。
 > - 针对所有的元素重复以上的步骤，除了最后一个。
 > - 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
 */
func bubbleSort(array: inout Array<Int>) {
    guard array.count > 1 else { return }
    
    for i in 0..<array.count {
        var flag = false
        for j in 0..<array.count - i - 1 {
            if array[j] > array[j + 1] {
                array.swapAt(j, j + 1)
                flag = true
            }
        }
        /// 没有交换，提前退出
        if (!flag) { break }
    }
}

/// test
var array = [2, 3, 5, 1]
bubbleSort(array: &array)
print(array)

//: [Next](@next)
