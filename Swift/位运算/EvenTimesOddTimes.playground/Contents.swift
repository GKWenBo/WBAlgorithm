import Foundation

/// 数组中找出出现奇数次的数字，其它数组出现为偶数次
/// - Parameter arr: 时间复杂度：O(N)
func printOddTimesNum1(_ arr: [Int]) {
    var eor = 0
    for num in arr {
        eor ^= num
    }
    print(eor)
}

/// 找出数组中不相同的两个数，其它数字出现次数都是偶数次 时间复杂度：O(N)
/// - Parameter arr: 数组
func printOddTimesNum2(arr: [Int]) {
    var eor = 0
    for num in arr {
        eor ^= num
    }
    
    // eor = a ^ b
    // eor != 0
    // eor必然有一个位置上是1
    let rightOne = eor & (~eor + 1) // 提取出最右的1
    var onlyOne = 0
    for num in arr {
        if (num & rightOne) == 0 {
            onlyOne ^= num
        }
    }
    
    print(onlyOne, eor ^ onlyOne)
}

// Test1
let arr1 = [66, 3, 3, 4, 4, 5, 5]
printOddTimesNum1(arr1)

// Test2
let arr = [100, 6, 3, 3, 4, 4, 5, 5]
printOddTimesNum2(arr: arr)
