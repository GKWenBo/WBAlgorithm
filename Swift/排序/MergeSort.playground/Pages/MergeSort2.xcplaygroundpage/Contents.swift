import Foundation

/*
 > - 不断地将当前序列平均分割成2个子序列
 >
 >   知道不能再分割（序列中只剩1个元素）
 >
 > - 不断地将2个子序列合并成一个有序序列
 >
 >   知道最终只剩下1个有序序列
 
 最好、最坏、平均复杂度：O(nlogn)
 空间复杂度：O(n)
 */

// 归并排序算法
func mergeSort(array: inout Array<Int>) {
    guard array.count > 1 else { return }
    mergeSortInternally(array: &array, p: 0, r: array.count - 1)
}

/// 递归调用函数
func mergeSortInternally(array: inout Array<Int>, p: Int, r: Int) {
    /// 递归终止条件
    guard p < r else { return }
    
    /// 取p到r之间的中间位置q,防止（p+r）的和超过int类型最大值
    let q = p + (r - p) / 2
    
    /// 分治递归
    mergeSortInternally(array: &array, p: p, r: q)
    mergeSortInternally(array: &array, p: q + 1, r: r)
    
    /// 将A[p...q]和A[q+1...r]合并为A[p...r]
    merge(array: &array, p: p, q: q, r: r)
}

func merge(array: inout Array<Int>, p: Int, q: Int, r: Int) {
    /// 初始化变量i, j, k
    var i = p
    var j = q + 1
    var k = 0
    var tempArray = [Int](repeating: 0, count: r - p + 1)
    while i <= q && j <= r {
        if array[i] < array[j] {
            tempArray[k] = array[i]
            i += 1
        } else {
            tempArray[k] = array[j]
            j += 1
        }
        k += 1
    }
    
    /// 判断哪个子数组中有剩余的数据
    var start = i;
    var end = q;
    if j <= r {
        start = j
        end = r
    }
    
    /// 将剩余的数据拷贝到临时数组tmp
    while start <= end {
        tempArray[k] = array[start]
        start += 1
        k += 1
    }
    
    /// 将tmp中的数组拷贝回a[p...r]
    for i in 0...(r - p) {
        array[p + i] = tempArray[i]
    }
}

/// test
var array = [2, 3, 5, 1, 6, 0]
mergeSort(array: &array)
print(array)
