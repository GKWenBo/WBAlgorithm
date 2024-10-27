//: [Previous](@previous)

import Foundation

/// 求数组小和，在一个数组中，每一个数左边比当前数小的数累加起来，叫做这个数组的小和
/// eg：
func smallSum(_ arr: inout [Int]) -> Int {
    guard arr.count > 1 else {
        return 0
    }
    return process(&arr, L: 0, R: arr.count - 1)
}

func process(_ arr: inout [Int], L: Int, R: Int) -> Int {
    guard L != R else {
        return 0
    }
    let mid = L + (R - L) >> 1
    return process(&arr, L: L, R: mid) + process(&arr, L: mid + 1, R: R) + merge(&arr, L: L, M: mid, R: R)
}

func merge(_ arr: inout [Int], L: Int, M: Int, R: Int) -> Int {
    var res = 0
    var tempArr = [Int](repeating: 0, count: R - L + 1)
    var p1 = L
    var p2 = M + 1
    /// 拷贝数组下标
    var i = 0
    while p1 <= M && p2 <= R {
        if arr[p1] <= arr[p2] {
            /// 右组大于左组当前元素个数
            res += (R - p2 + 1) * arr[p1]
            tempArr[i] = arr[p1]
            p1 += 1
        } else {
            tempArr[i] = arr[p2]
            p2 += 1
        }
        i += 1
    }
    
    while p1 <= M {
        tempArr[i] = arr[p1]
        p1 += 1
        i += 1
    }
    
    while p2 <= R {
        tempArr[i] = arr[p2]
        p2 += 1
        i += 1
    }
    
    for i in 0..<tempArr.count {
        arr[i + L] = tempArr[i]
    }
    return res
}

// Test
var arr = [1, 3, 2, 5, 6]
let res = smallSum(&arr)

//: [Next](@next)
