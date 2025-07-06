//: [Previous](@previous)

import Foundation

/// 单链表节点
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

/// 基于堆的优先级队列实现
struct PriorityQueue<T: Comparable> {
    private var heap: [T]
    private let comparator: (T, T) -> Bool
    
    /// 创建最小堆（默认）或最大堆
    /// - Parameters:
    ///   - ascending: true = 最小堆（默认），false = 最大堆
    ///   - startingValues: 初始值数组
    init(ascending: Bool = true, startingValues: [T] = []) {
        self.comparator = ascending ? { $0 < $1 } : { $0 > $1 }
        self.heap = startingValues
        buildHeap()
    }
    
    var isEmpty: Bool { heap.isEmpty }
    var count: Int { heap.count }
    
    /// 堆化现有元素
    private mutating func buildHeap() {
        for i in stride(from: (heap.count / 2) - 1, through: 0, by: -1) {
            heapifyDown(from: i)
        }
    }
    
    /// 插入元素
    mutating func push(_ element: T) {
        heap.append(element)
        heapifyUp(from: heap.count - 1)
    }
    
    /// 取出优先级最高元素
    mutating func pop() -> T? {
        guard !heap.isEmpty else { return nil }
        heap.swapAt(0, heap.count - 1)
        let element = heap.removeLast()
        if !heap.isEmpty { heapifyDown(from: 0) }
        return element
    }
    
    /// 上浮操作
    private mutating func heapifyUp(from index: Int) {
        var child = index
        var parent = parentIndex(of: child)
        
        while child > 0 && comparator(heap[child], heap[parent]) {
            heap.swapAt(child, parent)
            child = parent
            parent = parentIndex(of: child)
        }
    }
    
    /// 下沉操作
    private mutating func heapifyDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(of: parent)
            let right = rightChildIndex(of: parent)
            var candidate = parent
            
            if left < heap.count && comparator(heap[left], heap[candidate]) {
                candidate = left
            }
            if right < heap.count && comparator(heap[right], heap[candidate]) {
                candidate = right
            }
            if candidate == parent { return }
            
            heap.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    // 索引计算辅助方法
    private func parentIndex(of index: Int) -> Int { (index - 1) / 2 }
    private func leftChildIndex(of index: Int) -> Int { 2 * index + 1 }
    private func rightChildIndex(of index: Int) -> Int { 2 * index + 2 }
}

extension ListNode: Comparable {
    public static func < (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val < rhs.val
    }
    
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val
    }
}

/*
 使用优先级队列方式
 */
class Solution {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        /// 处理边界情况
        guard !lists.isEmpty else { return nil }
        /// 创建虚拟头结点
        var dumpy = ListNode(-1)
        var current: ListNode? = dumpy
        
        /// 初始化最小堆优先级队列
        var pq = PriorityQueue<ListNode>(ascending: true)
        /// 将所有链表头节点入堆
        for head in lists {
            if let head {
                pq.push(head)
            }
        }
        
        /// 不断取出最小节点并处理
        while !pq.isEmpty {
            let node = pq.pop()
            current?.next = node
            current = current?.next
            
            if let nextNode = node?.next {
                pq.push(nextNode)
            }
        }
        
        return dumpy.next
    }
}

// 创建测试链表
let list1 = ListNode(1, ListNode(4, ListNode(5)))
let list2 = ListNode(1, ListNode(3, ListNode(4)))
let list3 = ListNode(2, ListNode(6))

// 合并操作
let solution = Solution()
var merged = solution.mergeKLists([list1, list2, list3])

// 打印结果：1→1→2→3→4→4→5→6
while let node = merged {
    print(node.val, terminator: "→")
    merged = node.next
}

//: [Next](@next)
