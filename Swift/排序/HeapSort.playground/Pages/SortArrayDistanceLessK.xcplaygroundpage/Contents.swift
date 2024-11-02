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

func sortedArrayDistanceLessK(_ array: inout [Int], k: Int) {
    var heap = MinHeap<Int>()
    let length = min(k, array.count)
    var index = 0
    while index < length {
        heap.insert(array[index])
        index += 1
    }
    
    var i = 0
    while index < array.count {
        heap.insert(array[index])
        array[i] = heap.removeMin()!
        index += 1
        i += 1
    }
    
    while !heap.isEmpty {
        if let value = heap.removeMin() {
            array[i] = value
            i += 1
        }
    }
}


/// test
var array = [0, 3, 5, 1, 6, 2, 10]
sortedArrayDistanceLessK(&array, k: 10)
print(array)

//: [Next](@next)
