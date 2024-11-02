//: [Previous](@previous)

import Foundation

struct MinHeap<T: Comparable> {
    private var elements: [T] = []
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    mutating func insert(_ value: T) {
        elements.append(value)
        shiftUp(from: count - 1)
    }
    
    
    mutating func removeMin() -> T? {
        guard !isEmpty else {
            return nil
        }
        guard count > 1 else {
            return elements.removeLast()
        }
        
        elements.swapAt(0, count - 1)
        let value = elements.removeLast()
        shiftDown(from: 0)
        return value
    }
    
    private mutating func shiftUp(from index: Int) {
        var index = index
        while index > 0, let parent = parent(index: index), elements[index] < elements[parent] {
            elements.swapAt(index, parent)
            index = parent
        }
    }
    
    private mutating func shiftDown(from index: Int) {
        var index = index
        let value = elements[index]
        while let child = smallestChild(index: index), value > elements[child] {
            elements.swapAt(index, child)
            index = child
        }
    }
    
    private func parent(index: Int) -> Int? {
        return index > 0 ? (index - 1) / 2 : nil
    }
    
    private func smallestChild(index: Int) -> Int? {
        let leftChildIndex = index * 2 + 1
        let rightChildIndex = index * 2 + 2
          
        guard leftChildIndex < count else {
            // 如果没有左子节点，则没有子节点可以比较
            return nil
        }
          
        var smallerChildIndex = leftChildIndex
          
        if rightChildIndex < count && elements[rightChildIndex] < elements[leftChildIndex] {
            smallerChildIndex = rightChildIndex
        }
          
        return smallerChildIndex
    }
}

// Test
// 使用示例
var minHeap = MinHeap<Int>()
minHeap.insert(10)
minHeap.insert(15)
minHeap.insert(3)
minHeap.insert(7)
minHeap.insert(2)
minHeap.insert(1)
minHeap.insert(5)
minHeap.insert(8)

while !minHeap.isEmpty {
    print(minHeap.removeMin() ?? "Empty")
}

//: [Next](@next)
