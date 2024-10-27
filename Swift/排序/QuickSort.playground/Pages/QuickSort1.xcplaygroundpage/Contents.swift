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
func quickSort(array: inout [Int]) {
    guard array.count > 1 else { /// 边界判断
        return
    }
    quickSortInternally(array: &array, left: 0, right: array.count - 1)
}

func quickSortInternally(array: inout [Int], left: Int, right: Int) {
    guard left < right else { /// 递归终止条件
        return
    }
    /// 划分基点位置
    let partitionIndex = partition(array: &array, left: left, right: right)
    /// 排序左分区
    quickSortInternally(array: &array, left: left, right: partitionIndex - 1)
    /// 排序右分区
    quickSortInternally(array: &array, left: partitionIndex + 1, right: right)
}

func partition(array: inout [Int], left: Int, right: Int) -> Int {
    /// 设定基准值
    let pivot = left
    var index = pivot + 1
    for i in index...right {
        if array[i] < array[pivot] {
            array.swapAt(i, index)
            index += 1
        }
    }
    /// 交换基准值到中间位置，此时，左侧小于基准值，右侧大于基准值
    array.swapAt(index - 1, pivot)
    return index - 1
}

/// 测量闭包执行时间的函数
/// - Parameter action: 需要测量执行时间的闭包
/// - Returns: 闭包执行所花费的时间，单位为秒
func measureExecutionTime(action: () -> Void) {
    let startTime = Date() // 获取开始时间
    action() // 执行闭包
    let endTime = Date() // 获取结束时间
    let timeInterval = endTime.timeIntervalSince(startTime) // 计算时间差
    print("方法执行耗时：\(timeInterval)")
}

/// 随机生生成数组
/// - Parameters:
///   - count: 数组长度
///   - maxValue: 数组元素最大值
/// - Returns: 随机数组
func generateRandomArray(count: Int, maxValue: Int) -> [Int] {
    var randomArray = [Int]()
    for _ in 0..<count {
        let randomValue = Int(arc4random_uniform(UInt32(maxValue) + 1))
        randomArray.append(randomValue)
    }
    return randomArray
}

// Test
// Test
func test() {
    let count = 1000
    let maxValue = 100
    
    var success = true
    for _ in 0..<10 {
        var arr1 = generateRandomArray(count: count, maxValue: maxValue)
        var arr2 = Array(arr1)
        
        quickSort(array: &arr1)
        arr2.sort()
        if arr1 != arr2 {
            print("快排算法测试不通过")
            success = false
            break
        }
    }
    if success {
        print("QuickSort1快排测试通过")
    }
}


measureExecutionTime {
    test()
}



//: [Next](@next)
