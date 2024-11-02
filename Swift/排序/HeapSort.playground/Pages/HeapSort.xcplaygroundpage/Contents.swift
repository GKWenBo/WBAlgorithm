import Foundation

func heapSort(_ array: inout [Int]) {
    guard array.count > 1 else {
        return
    }
    
//    for i in 0..<array.count { // O(N)
//        heapInsert(&array, index: i) // O(logN)
//    }
    
    var i = array.count - 1
    while i >= 0 {
        heapify(&array, index: i, heapSize: array.count)
        i -= 1
    }
    
    var heapSize = array.count;
    heapSize -= 1
    array.swapAt(heapSize, 0)
    while heapSize > 0 { // O(N)
        heapify(&array, index: 0, heapSize: heapSize) // O(logN)
        heapSize -= 1
        array.swapAt(heapSize, 0)
    }
}

/// 大根堆插入一个元素，保持大根堆特性
/// - Parameters:
///   - array: 堆
///   - index: 插入位置
func heapInsert(_ array: inout [Int], index: Int) {
    var index = index
    while array[index] > array[(index - 1) / 2] {
        array.swapAt(index, (index - 1) / 2)
        index = (index - 1) / 2
    }
}

/// 堆化
/// - Parameters:
///   - array: 堆
///   - index: 某个位置是否能向下移动
///   - heapSize: 堆大小
func heapify(_ array: inout [Int], index: Int, heapSize: Int) {
    var index = index
    var left = index * 2 + 1
    while left < heapSize {
        /// 两个孩子中，谁的值大，把下标给largest
        var largest = (left + 1) < heapSize && array[left + 1] > array[left] ? left + 1 : left
        /// 父和较大的孩子之间，谁的值大，把下标给largest
        largest = array[largest] > array[index] ? largest : index;
        
        /// 当前节点就是最大节点
        if largest == index {
            break
        }
        
        /// 父和最大孩子交换
        array.swapAt(index, largest)
        /// 将要向下移动的下标赋值
        index = largest
        left = 2 * index + 1
    }
}


// Test
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
func test() {
    let count = 100
    let maxValue = 100
    
    var success = true
    for _ in 0..<10 {
        var arr1 = generateRandomArray(count: count, maxValue: maxValue)
        var arr2 = Array(arr1)
        
        heapSort(&arr1)
        arr2.sort()
        if arr1 != arr2 {
            print("堆排序算法测试不通过")
            success = false
            break
        }
    }
    if success {
        print("堆排序算法测试通过")
    }
}


measureExecutionTime {
    test()
}
