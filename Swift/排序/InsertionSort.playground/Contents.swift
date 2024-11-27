import Foundation

/*
 插入排序 时间复杂度：O(N²) - 稳定排序
 > - 将第一待排序序列第一个元素看做一个有序序列，把第二个元素到最后一个元素当成是未排序序列。
 > - 从头到尾依次扫描未排序序列，将扫描到的每个元素插入有序序列的适当位置。（如果待插入的元素与有序序列中的某个元素相等，则将待插入元素插入到相等元素的后面。）
 */
func insertionSort(array: inout Array<Int>) {
    guard array.count > 1 else { return }
    for i in 0..<array.count {
        let value = array[i]
        var j = i - 1
        while j >= 0 {
            if array[j] > value {
                array.swapAt(j, j + 1)
            } else {
                break
            }
            j -= 1
        }
        array[j + 1] = value
    }
}

func insertionSort1(array: inout Array<Int>) {
    guard array.count > 1 else { return }
    // 0 ~ 0 有序的
    // 0 ~ i 想有序
    for i in 1..<array.count {
        var j = i - 1
        while j >= 0 && array[j] > array[j + 1] {
            array.swapAt(j, j + 1)
            j -= 1
        }
    }
}

/// test insertionSort
var array = [2, 3, 5, 1]
insertionSort(array: &array)
print(array)

// Test insertionSort1
var array1 = [2, 3, 5, 1, -2]
insertionSort1(array: &array1)
print(array1)
