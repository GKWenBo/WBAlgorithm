import Foundation

/*
 实现最大堆数据结构
 */
struct Heap: CustomStringConvertible {
    var description: String {
        return array.description
    }
    
    /// 数组，下标从1开始
    private var array: [Int]
    /// 堆容量
    private let size: Int
    /// 已存储数据
    private var count: Int
    
    init(_ capacity: Int) {
        array = Array(repeating: 0, count: capacity + 1)
        size = capacity
        count = 0
    }
    
    /// 往堆中插入数据
    /// - Parameter data: 要插入的数据
    mutating func insert(_ data: Int) {
        guard count < size else {
            return
        }
        
        count += 1
        array[count] = data
        var i = count
        while i / 2 > 0 && array[i] > array[i / 2] { // 子节点比父节点大，则交换父子节点
            array.swapAt(i, i / 2)
            i /= 2
        }
    }
    
    /// 移除堆顶元素
    mutating func removeMax() {
        guard count != 0 else {
            return
        }
        
        array[1] = array[count]
        // 删除最后一个元素
        array.removeLast()
        count -= 1
        headify(1)
    }
    
    /// 堆化，从上至下
    /// - Parameter index: 开始下标
    mutating func headify(_ index: Int) {
        while true {
            var i = index
            var maxPos = i
            if i * 2 <= count && array[i] < array[i * 2] {
                maxPos = i * 2
            }
            if i * 2 + 1 <= count && array[maxPos] < array[i * 2 + 1] {
                maxPos = i * 2 + 1
            }
            if maxPos == i {
                break
            }
            
            array.swapAt(i, maxPos)
            i = maxPos
        }
    }
    
    /// 建堆，从下往上堆化
    /// - Parameters:
    ///   - array: 数组
    ///   - n: 元素个数
    ///   - i: 下标
    static func buildHeap(array: inout [Int], n: Int) {
        var i = n / 2
        while i >= 1 {
            heapify(array: &array, n: n, i: i)
            i -= 1
        }
    }
    
    static func heapify(array: inout [Int], n: Int, i: Int) {
        var i = i
        while true {
            var maxPos = i
            if i * 2 <= n && array[i] < array[i * 2] {
                maxPos = i * 2
            }
            if i * 2 + 1 <= n && array[maxPos] < array[i * 2 + 1] {
                maxPos = i * 2 + 1
            }
            if maxPos == i {
                break
            }
            
            array.swapAt(i, maxPos)
            i = maxPos
        }
    }
}


// test insert
//var heap = Heap(4)
//heap.insert(1)
//heap.insert(2)
//heap.insert(3)
//heap.insert(10)
//print(heap)
//heap.removeMax()
//print(heap)


// test build heap
var arr = [0, 1, 2, 3]
Heap.buildHeap(array: &arr, n: 3)
print(arr)
