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

/*
 单链表的插入、删除、查找操作，链表存储的值是泛型
 */
class SinglyLinkedList<Element: Equatable> {
    /// 哨兵节点，不存储数据
    private var dummy = Node<Element>()
    
    /// 链表长度
    var size: Int {
        var num = 0
        var current = dummy.next
        while current != nil {
            num += 1
            current = current?.next
        }
        return num
    }
    
    /// 链表是否为空
    var isEmpty: Bool {
        return size == 0
    }
    
    /// 根据value获取链表对应节点
    /// - Parameter value: value description
    /// - Returns: 查找到的链表节点
    func node(with value: Element) -> Node<Element>? {
        var current = dummy.next;
        while current != nil && current?.value != value {
            current = current?.next
        }
        return current
    }
    
    /// 根据下标查找节点
    /// - Parameter index: 下标
    /// - Returns: 查找到的节点
    func node(at index: Int) -> Node<Element>? {
        var pos = 0
        var current = dummy.next
        while current != nil && pos != index {
            pos += 1
            current = current?.next
        }
        return current
    }
    
    /// 插入一个新的头结点
    /// - Parameter value: 插入的值
    func insertToHead(value: Element) {
        let node = Node(value: value)
        insertToHead(node: node)
    }
    
    /// 插入一个新的头结点
    func insertToHead(node: Node<Element>) {
        node.next = dummy.next
        dummy.next = node
    }
    
    /// 在某个节点后插入一个值
    func insert(after node: Node<Element>, newValue: Element) {
        let newNode = Node(value: newValue)
        insert(after: node, newNode: newNode)
        
    }
    
    /// 在某个节点后插入一个值
    func insert(after node: Node<Element>, newNode: Node<Element>) {
        newNode.next = node.next
        node.next = newNode
    }
    
    
    /// 在某个节点前插入一个节点
    func insert(before node: Node<Element>, newValue: Element) {
        let newNode = Node(value: newValue)
        insert(before: node, newNode: newNode)
    }
    
    /// 在某个节点前插入一个节点
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
    
    /// 链表尾部插入
    /// - Parameter newValue: 插入的值
    func insertTail(with newValue: Element) {
        let newNode = Node(value: newValue)
        /// 空链表，插入新节点作为头节点
        if dummy.next == nil {
            dummy.next = newNode
        } else {
            var temp = dummy.next
            while temp?.next != nil {
                temp = temp?.next
            }
            newNode.next = temp?.next
            temp?.next = newNode
        }
    }
    
    /// 删除节点
    /// - Parameter node: 要删除的节点
    func delete(node: Node<Element>) {
        guard dummy.next != nil else {
            return
        }
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
        guard dummy.next != nil else {
            return
        }
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
