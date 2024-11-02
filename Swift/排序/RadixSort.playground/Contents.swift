import Foundation

/// 基数排序
/// - Parameter array: 要排序数组
func radixSort(_ array: inout [Int]) {
    guard array.count > 1 else {
        return
    }
    radixSort(&array, left: 0, right: array.count - 1, digit: maxBits(array))
}

/// 获取数组中最大数字有几位数组
/// - Parameter array: 数组
/// - Returns: 最大数字有几位
func maxBits(_ array: [Int]) -> Int {
    var maxValue = Int.min
    for value in array {
        maxValue = max(maxValue, value)
    }
    var res = 0
    while maxValue != 0 {
        res += 1
        maxValue /= 10
    }
    return res
}

/// array[left...right]排序
/// - Parameters:
///   - array: 要排序的数组
///   - left: 排序开始下标
///   - right: 排序结束下标
///   - digit: 最大数字位数
func radixSort(_ array: inout [Int], left: Int, right: Int, digit: Int) {
    let radix = 10
    var i = 0, j = 0
    /// 有多少个数准备多少个辅助空间
    var bucket = [Int](repeating: 0, count: right - left + 1)
    for d in 1...digit { /// 有多少位就进出几次
        /// 10个空间
        /// count[0] 当前位(d位)是0的数字有多少个
        /// count[1] 当前（d位）是（0和1）的数字有多少个
        /// count[2] 当前（d位）是（0、1和2）的数字有多少个
        /// count[3] 当前（d位）是（0~i）的数字有多少个
        var count = [Int](repeating: 0, count: radix)
        
        /// 数字个数计数
        i = left
        while i <= right {
            /// 第d位数字
            j = getDigit(array[i], d)
            count[j] += 1
            i += 1
        }
        
        i = 1
        while i < radix {
            count[i] = count[i] + count[i - 1]
            i += 1
        }
        
        i = right
        while i >= left {
            j = getDigit(array[i], d)
            bucket[count[j] - 1] = array[i]
            count[j] -= 1
            i -= 1
        }
        
        i = left
        j = 0
        while i <= right {
            array[i] = bucket[j]
            i += 1
            j += 1
        }
    }
}

public func getDigit(_ x: Int, _ d: Int) -> Int {
    return ((x / Int(pow(10.0, Double(d - 1)))) % 10)
}


// Test
var array = [3, 61, 1222, 21, 72, 9, 8, 1000]
radixSort(&array)
print(array)
