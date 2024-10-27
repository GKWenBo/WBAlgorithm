//: [Previous](@previous)

/*
 https://leetcode.cn/problems/shu-zu-zhong-de-ni-xu-dui-lcof/description/
 */

import Foundation
/// 在股票交易中，如果前一天的股价高于后一天的股价，则可以认为存在一个「交易逆序对」。请设计一个程序，输入一段时间内的股票交易记录 record，返回其中存在的「交易逆序对」总数。
class Solution {
    func reversePairs(_ record: [Int]) -> Int {
        guard record.count > 1 else {
            return 0
        }
        var arr = record
        return mergeSort(arr: &arr, l: 0, r: arr.count - 1)
    }

    func mergeSort(arr: inout [Int], l: Int, r: Int) -> Int {
        guard l != r else {
            return 0
        }
        let mid = l + (r - l) >> 1
        return mergeSort(arr: &arr, l: l, r: mid) + mergeSort(arr: &arr, l: mid + 1, r: r) + merge(arr: &arr, l: l, m: mid, r: r)
    }

    func merge(arr: inout [Int], l: Int, m: Int, r: Int) -> Int {
        var count = 0
        var tempArr = [Int](repeating: 0, count: r - l + 1)
        var p1 = l
        var p2 = m + 1
        /// 拷贝数组下标
        var i = 0
        while p1 <= m && p2 <= r {
            if arr[p1] <= arr[p2] {
                tempArr[i] = arr[p1]
                p1 += 1
            } else {
                /// 右组大于左组当前元素个数
                count += (m - p1 + 1)
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
            arr[i + l] = tempArr[i]
        }
        return count
    }
}


// Test
var record = [9, 7, 5, 4, 6]
Solution().reversePairs(record)

var record1 = [1,3,2,3,1]
Solution().reversePairs(record1)

//: [Next](@next)
