//: [Previous](@previous)

import Foundation

class Node<T: Equatable> {
    var value: T?
    var next: Node?
    
    init() {}
    
    init(value: T) {
        self.value = value
    }
}

protocol Stack {
    /// 持有的数据类型
    associatedtype Element
    /// 是否为空
    var isEmpty: Bool { get }
    /// 队列大小
    var size: Int { get }
    /// 返回队列头部元素
    var peek: Element? { get }
    /// 入栈
    mutating func push(newElement: Element) -> Bool
    /// 出栈
    mutating func pop() -> Element?
}

struct LinkedStack<Element: Equatable>: Stack {
    /// 哨兵节点
    var head = Node<Element>()
    
    var isEmpty: Bool {
        return size == 0
    }
    
    var size: Int {
        var num = 0;
        var cur = head.next
        while cur != nil {
            num += 1
            cur = cur?.next
        }
        return num
    }
    
    var peek: Element? {
        return head.next?.value
    }
    
    func push(newElement: Element) -> Bool {
        let newNode = Node(value: newElement)
        newNode.next = head.next
        head.next = newNode
        return true
    }
    
    func pop() -> Element? {
        let node = head.next
        head.next = node?.next
        return node?.value
    }
}

//: [Next](@next)
