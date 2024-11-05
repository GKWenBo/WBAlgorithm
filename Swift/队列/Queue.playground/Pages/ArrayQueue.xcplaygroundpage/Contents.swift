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
    /// 清空
    mutating func clear()
}

/// 用数组实现的队列
struct ArrayQueue<Element>: Queue {
    private var items: [Element]
    private var capacity = 0
    
    private var head = 0
    private var tail = 0
    
    init(defaultElement: Element, capacity: Int) {
        self.capacity = capacity
        self.items = [Element](repeating: defaultElement, count: capacity)
    }
    
    var isEmpty: Bool {
        return head == tail
    }
    
    var size: Int {
        return tail - head
    }
    
    var peek: Element? {
        return isEmpty ? nil : items[head]
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        if tail == capacity {
            /// 整个队列已满
            if head == 0 {
                return false
            }
            
            for i in head..<tail {
                items[i - head] = items[i]
            }
            
            tail -= head
            head = 0
        }
        
        items[tail] = newElement
        tail += 1
        return true
    }
    
    mutating func dequeue() -> Element? {
        if isEmpty {
            return nil
        }
        
        let element = items[head]
        head += 1
        return element
    }
    
    mutating func clear() {
        items.removeAll()
        head = 0
        tail = 0
    }
}

/// 使用2个数组实现无界队列，用到 Swift 中 Array 较多的方法
struct ArrayQueue1<Element>: Queue {
    var inArray: [Element] = []
    var outArray: [Element] = []
    
    var isEmpty: Bool {
        return inArray.isEmpty && outArray.isEmpty
    }
    
    var size: Int {
        return inArray.count + outArray.count
    }
    
    /// 当 outArray 为空时，返回 inArray 首个元素，否则返回 outArray 末尾元素
    var peek: Element? {
        return outArray.isEmpty ? inArray.first : outArray.last
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        inArray.append(newElement)
        return true
    }
    
    mutating func dequeue() -> Element? {
        if outArray.isEmpty {
            outArray = inArray.reversed()
            inArray.removeAll()
        }
        return outArray.popLast()
    }
    
    mutating func clear() {
        inArray.removeAll()
        outArray.removeAll()
    }
}

//: [Next](@next)
