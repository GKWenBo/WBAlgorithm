//: [Previous](@previous)

import Foundation

protocol Queue {
    associatedtype Element
    /// 是否为空
    var isEmpty: Bool { get }
    /// 队列大小
    var size: Int { get }
    /// 返回队列头部元素
    var peek: Element? { get }
    /// 入队
    /// - Returns: 是否入队成功
    mutating func enqueue(newElement: Element) -> Bool
    /// 出队
    /// - Returns: 出队元素
    mutating func dequeue() -> Element?
}

struct CircularQueue<Element>: Queue {
    var item = [Element]()
    var head = 0
    var tail = 0
    var capacity = 0
    
    init(defaultElement: Element, capacity: Int) {
        self.capacity = capacity
        item = [Element](repeating: defaultElement, count: capacity)
    }
    
    var isEmpty: Bool {
        return head == tail
    }
    
    var size: Int {
        if head <= tail {
            return tail - head
        }
        return (tail + 1) + (capacity - head)
    }
    
    var peek: Element? {
        return isEmpty ? nil : item[head]
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        if (tail + 1) % capacity == head {
            return false
        }
        item[tail] = newElement
        tail = (tail + 1) % capacity
        return true
    }
    
    mutating func dequeue() -> Element? {
        if isEmpty {
            return nil
        }
        let item = item[head]
        head = (head + 1) % capacity
        return item
    }
}

//: [Next](@next)
