//: [Previous](@previous)

import Foundation

class Node<T> {
    var value: T?
    var next: Node?
    
    init() {}
    
    init(value: T) {
        self.value = value
    }
}

class SinglyLinkedList<Element: Equatable> {
    
    /// 哨兵节点
    private var dummy = Node<Element>()
    
    var size: Int {
        var num = 0
        var current = dummy.next
        while current != nil {
            num += 1
            current = current?.next
        }
        return num
    }
    
    var isEmpty: Bool {
        return size == 0
    }
    
    func node(with value: Element) -> Node<Element>? {
        var current = dummy.next;
        while current != nil {
            if current!.value == value {
                return current
            }
            current = current?.next
        }
        return nil
    }
    
    func node(at index: Int) -> Node<Element>? {
        var pos = 0
        var current = dummy.next
        while current != nil && pos != index {
            pos += 1
            current = current?.next
        }
        return current
    }
    
    func insertToHead(value: Element) {
        let node = Node(value: value)
        insertToHead(node: node)
    }
    
    func insertToHead(node: Node<Element>) {
        node.next = dummy.next
        dummy.next = node
    }
    
    func insert(after node: Node<Element>, newValue: Element) {
        let newNode = Node(value: newValue)
        insert(after: node, newNode: newNode)
        
    }
    
    func insert(after node: Node<Element>, newNode: Node<Element>) {
        newNode.next = node.next
        node.next = newNode
    }
    
    func insert(before node: Node<Element>, newValue: Element) {
        let newNode = Node(value: newValue)
        insert(before: node, newNode: newNode)
    }
    
    func insert(before node: Node<Element>, newNode: Node<Element>) {
        var lastNode = dummy
        var tempNode = dummy.next
        while tempNode != nil {
            if tempNode === node {
                newNode.next = tempNode
                lastNode.next = newNode
                break
            }
            lastNode = tempNode!
            tempNode = tempNode?.next
        }
    }
    
    /// 删除节点
    /// - Parameter node: 要删除的节点
    func delete(node: Node<Element>) {
        var lastNode = dummy
        var tempNode = dummy.next
        while tempNode != nil {
            if tempNode === node {
                lastNode.next = tempNode?.next
                break
            }
            lastNode = tempNode!
            tempNode = tempNode?.next
        }
    }
    
    /// 删除首个符合value的节点
    /// - Parameter value: 节点值
    func delete(value: Element) {
        var lastNode = dummy
        var tempNode = dummy.next
        while tempNode != nil {
            if tempNode?.value == value {
                lastNode.next = tempNode?.next
                break
            }
            lastNode = tempNode!
            tempNode = tempNode?.next
        }
    }
}

//: [Next](@next)
