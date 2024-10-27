//: [Previous](@previous)

import Foundation

func mergeSort(_ arr: inout [Int]) {
    guard arr.count > 1 else {
        return
    }
    mergeSortInternal(&arr, l: 0, r: arr.count - 1)
}

func mergeSortInternal(_ arr: inout [Int], l: Int, r: Int) {
    guard l != r else {
        return
    }
    
    let mid = l + (r - l) >> 1
    mergeSortInternal(&arr, l: l, r: mid)
    mergeSortInternal(&arr, l: mid + 1, r: r)
    merge(&arr, l: l, m: mid, r: r)
}

func merge(_ arr: inout [Int], l: Int, m: Int, r: Int) {
    var tempArr = [Int](repeating: 0, count: r - l + 1)
    var p1 = l
    var p2 = m + 1
    var i = 0
    while p1 <= m && p2 <= r {
        if arr[p1] <= arr[p2] {
            tempArr[i] = arr[p1]
            p1 += 1
        } else {
            tempArr[i] = arr[p2]
            p2 += 1
        }
        i += 1
    }
    
    while p1 <= m {
        tempArr[i] = arr[p1]
        p1 += 1
        i += 1
    }
    
    while p2 <= r {
        tempArr[i] = arr[p2]
        p2 += 1
        i += 1
    }
    
    for i in 0..<tempArr.count {
        arr[l + i] = tempArr[i]
    }
}

// Test

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
        
        mergeSort(&arr1)
        arr2.sort()
        if arr1 != arr2 {
            print("归并排序算法测试不通过")
            success = false
            break
        }
    }
    if success {
        print("归并排序测试通过")
    }
}


measureExecutionTime {
    test()
}


//: [Next](@next)
