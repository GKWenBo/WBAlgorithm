//: [Previous](@previous)

import Foundation

/*
 给你一个 n x n 矩阵 matrix ，其中每行和每列元素均按升序排序，找到矩阵中第 k 小的元素。
 请注意，它是 排序后 的第 k 小元素，而不是第 k 个 不同 的元素。

 你必须找到一个内存复杂度优于 O(n2) 的解决方案。

 示例 1：

 输入：matrix = [[1,5,9],[10,11,13],[12,13,15]], k = 8
 输出：13
 解释：矩阵中的元素为 [1,5,9,10,11,12,13,13,15]，第 8 小元素是 13
 示例 2：

 输入：matrix = [[-5]], k = 1
 输出：-5
  

 提示：
 n == matrix.length
 n == matrix[i].length
 1 <= n <= 300
 -109 <= matrix[i][j] <= 109
 题目数据 保证 matrix 中的所有行和列都按 非递减顺序 排列
 1 <= k <= n2
  

 进阶：
 你能否用一个恒定的内存(即 O(1) 内存复杂度)来解决这个问题?
 你能在 O(n) 的时间复杂度下解决这个问题吗?这个方法对于面试来说可能太超前了，但是你会发现阅读这篇文章（ this paper ）很有趣。
 
 LeetCode：https://leetcode.cn/problems/kth-smallest-element-in-a-sorted-matrix/description/
 */

// 首先，我们需要一个简单的优先队列（最小堆）实现。
// 由于 Swift 标准库中没有内置的优先队列，我们创建一个基本的。
// 这里使用数组来存储堆元素，并通过比较闭包来确定优先级。

struct PriorityQueue<Element> {
    private var elements: [Element] = []
    private let priorityFunction: (Element, Element) -> Bool
    
    // 初始化时传入一个比较闭包。对于最小堆，当第一个元素应具有更高优先级（即更小）时返回 true。
    init(priorityFunction: @escaping (Element, Element) -> Bool) {
        self.priorityFunction = priorityFunction
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
    mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        if elements.count == 1 {
            return elements.removeLast()
        } else {
            let value = elements[0]
            elements[0] = elements.removeLast()
            siftDown(from: 0)
            return value
        }
    }
    
    private mutating func siftUp(from index: Int) {
        var childIndex = index
        let child = elements[childIndex]
        var parentIndex = (childIndex - 1) / 2
        
        while childIndex > 0 && priorityFunction(child, elements[parentIndex]) {
            elements[childIndex] = elements[parentIndex]
            childIndex = parentIndex
            parentIndex = (childIndex - 1) / 2
        }
        
        elements[childIndex] = child
    }
    
    private mutating func siftDown(from index: Int) {
        let parentIndex = index
        let leftChildIndex = 2 * parentIndex + 1
        let rightChildIndex = 2 * parentIndex + 2
        
        var first = parentIndex
        if leftChildIndex < elements.count && priorityFunction(elements[leftChildIndex], elements[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < elements.count && priorityFunction(elements[rightChildIndex], elements[first]) {
            first = rightChildIndex
        }
        if first == parentIndex { return }
        
        elements.swapAt(parentIndex, first)
        siftDown(from: first)
    }
}

// 定义一个三元组结构体来存储矩阵元素的值及其坐标 (value, row, col)
// 让该结构体可比较，以便优先队列使用。这里直接为队列提供比较逻辑
class Solution {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count
        // 初始化优先队列，比较闭包定义为：a[0] < b[0]（按元素值升序，最小堆）
        var pq: PriorityQueue<[Int]> = PriorityQueue { a, b in
            return a[0] < b[0]
        }
        
        // 将每一行的第一个元素 [value, row, col] 加入队列
        for i in 0..<n {
            if !matrix[i].isEmpty {  // 确保行不为空
                pq.enqueue([matrix[i][0], i, 0])
            }
        }
        
        var res = -1
        var kRemaining = k
        // 执行 k 次出队操作
        while !pq.isEmpty && kRemaining > 0 {
            guard let cur = pq.dequeue() else { break }
            res = cur[0]
            kRemaining -= 1
            let i = cur[1]
            let j = cur[2]
            // 如果当前元素所在行还有下一个元素，则将其加入队列
            if j + 1 < matrix[i].count {
                pq.enqueue([matrix[i][j + 1], i, j + 1])
            }
        }
        return res
    }
}

//: [Next](@next)
