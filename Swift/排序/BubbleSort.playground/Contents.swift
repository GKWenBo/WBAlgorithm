import Foundation

/*
 冒泡排序（稳定排序）
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

func bubbleSort(_ array: inout [Int]) {
    guard array.count > 1 else {
        return
    }
    
    var i = array.count - 1
    while i > 0 {
        for j in 0..<i {
            if array[j] > array[j + 1] {
                swap(array: &array, i: j, j: j + 1)
            }
        }
        i -= 1
    }
}

func swap(array: inout [Int], i: Int, j: Int) {
    let temp = array[i]
    array[i] = array[j]
    array[j] = temp
}

/// 交换数组i，j位置元素 note：要交换的位置内存地址不能相同
/// - Parameters:
///   - array: 数组
///   - i: 元素下标
///   - j: 元素下标
func swap2(array: inout [Int], i: Int, j: Int) {
    array[i] = array[i] ^ array[j]
    array[j] = array[i] ^ array[j]
    array[i] = array[i] ^ array[j]
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

// Test
func test() {
    let count = 100
    let maxValue = 100
    
    var success = true
    for _ in 0..<10 {
        var arr1 = generateRandomArray(count: count, maxValue: maxValue)
        var arr2 = Array(arr1)
        
        bubbleSort(&arr1)
        arr2.sort()
        if arr1 != arr2 {
            print("冒泡排序算法测试不通过")
            success = false
            break
        }
    }
    if success {
        print("冒泡排序测试通过")
    }
}

measureExecutionTime {
    test()
}

