//: [Previous](@previous)

import Foundation

public class Node<T> {
    public var val: T
    public var next: Node?
    public init(_ val: T) {
        self.val = val
        self.next = nil
    }
}

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

/// 基于链表实现的队列
struct LinkedListQueue<Element>: Queue {
    var head: Node<Element>?
    var tail: Node<Element>?
    
    var isEmpty: Bool {
        return size == 0
    }
    
    var size: Int {
        var num = 0
        var cur = head
        while cur != nil {
            num += 1
            cur = cur?.next
        }
        return num
    }
    
    var peek: Element? {
        return head?.val
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        if isEmpty {
            let node = Node(newElement)
            head = node
            tail = node
        } else {
            tail?.next = Node(newElement)
            tail = tail?.next
        }
        return true
    }
    
    mutating func dequeue() -> Element? {
        let node = head
        head = head?.next
        return node?.val
    }
}

var queue: LinkedListQueue<Int> = LinkedListQueue()
queue.enqueue(newElement: 1)
print(queue.size)
print(queue.peek)
queue.dequeue()
print(queue.size)

//: [Next](@next)
