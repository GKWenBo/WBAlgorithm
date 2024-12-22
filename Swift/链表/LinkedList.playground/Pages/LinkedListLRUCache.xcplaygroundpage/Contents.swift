//: [Previous](@previous)

import Foundation

protocol LRUCache {
    associatedtype Element
    mutating func add(value: Element)
    var size: Int { get }
}

class Node<T> {
    var value: T?
    var next: Node?
    
    init() {}
    
    init(value: T) {
        self.value = value
    }
}

/// 基于单链表实现LRU缓存
struct LinkedListLRUCache<Element: Equatable>: LRUCache, CustomStringConvertible {
    var size: Int = 0
    var head: Node<Element>?
    var cacheSize: Int
    
    init(cacheSize: Int) {
        self.cacheSize = cacheSize
        self.head = Node()
    }
    
    /// 添加元素
    mutating func add(value: Element) {
        let preNode = findPreNode(value: value)
        
        if preNode != nil {
            deleteElemOptim(preNode: preNode!)
            intsertElemAtBegin(value: value)
        } else {
            if size >= cacheSize {
                deleteElemAtEnd()
            }
            intsertElemAtBegin(value: value)
        }
    }
    
    
    /// 删除preNode结点下一个元素
    /// - Parameter preNode: preNode description
    mutating private func deleteElemOptim(preNode: Node<Element>) {
        var temp = preNode.next
        preNode.next = temp?.next
        temp = nil
        size -= 1
    }
    
    /// 链表头部插入节点
    /// - Parameter value: 要插入的元素
    mutating private func intsertElemAtBegin(value: Element) {
        let node = Node(value: value)
        node.next = head?.next
        head?.next = node
        size += 1
    }
    
    /// 获取查找到元素的前一个结点
    private func findPreNode(value: Element) -> Node<Element>? {
        var node = head
        while node?.next != nil {
            if value == node?.next?.value {
                return node
            }
            node = node?.next
        }
        return nil
    }
    
    /// 删除尾结点
    mutating func deleteElemAtEnd() {
        var ptr = head
        
        guard ptr?.next != nil else {
            return
        }
        
        while ptr?.next?.next != nil {
            ptr = ptr?.next
        }
        
        ptr?.next = nil
        size -= 1
    }
    
    var description: String {
        var str = ""
        var node = head?.next;
        while (node != nil) {
            str += "\(String(describing: node?.value))" + ","
            node = node?.next
        }
        return str
    }
}

var lru = LinkedListLRUCache<Int>(cacheSize: 3)
lru.add(value: 1)
lru.add(value: 2)
lru.add(value: 3)
lru.add(value: 5)
print(lru)
lru.add(value: 2)
print(lru)

//: [Next](@next)
