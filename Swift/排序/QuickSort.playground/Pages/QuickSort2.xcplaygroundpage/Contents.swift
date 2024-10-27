import Foundation

func quickSort(array: inout [Int]) {
    guard array.count > 1 else {
        return
    }
    return quickSort(array: &array, left: 0, right: array.count - 1)
}

/// arr[L..R]排好序
func quickSort(array: inout [Int], left: Int, right: Int) {
    guard left < right else {
        return
    }
    /// 随机选择一个基点值放在数组末尾
    array.swapAt(left + Int(arc4random_uniform(UInt32(right - left + 1))), right)
    
    let partition = partition(array: &array, left: left, right: right)
    /// 排序左侧分区
    quickSort(array: &array, left: left, right: partition[0] - 1)
    /// 排序右侧分区
    quickSort(array: &array, left: partition[1] + 1, right: right)
}

func partition(array: inout [Int], left: Int, right: Int) -> [Int] {
    var i = left
    /// >区 右边界下标
    var less = i - 1
    /// >区 左边界下标
    var greater = right
    while i < greater {
        /// 当前值小于划分值
        if array[i] < array[right] {
            less += 1
            array.swapAt(less, i)
            i += 1
        } else if array[i] > array[right] { /// 当前数大于区分值
            greater -= 1
            array.swapAt(i, greater)
        } else {
            i += 1
        }
    }
    array.swapAt(greater, right)
    return [less + 1, greater]
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
        print("QuickSort2快排测试通过")
    }
}


measureExecutionTime {
    test()
}
