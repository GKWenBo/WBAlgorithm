//: [Previous](@previous)

import Foundation

protocol LRUCache {
    associatedtype Element
    func add(value: Element)
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

struct LinkedListLRUCache<Element>: LRUCache {
    var size: Int = 0
    var head: Node<Element>?
    var cacheSize: Int
    
    init(cacheSize: Int) {
        self.cacheSize = cacheSize
        self.head = Node()
    }
    
    func add(value: Element) {
        
    }
    
    
}

//: [Next](@next)
