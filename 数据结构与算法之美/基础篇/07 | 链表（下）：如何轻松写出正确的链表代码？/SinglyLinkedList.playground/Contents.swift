import UIKit

class Node<T>: CustomStringConvertible {
    var value: T?
    var next: Node?
    
    init() {
    }
    
    init(value: T) {
        self.value = value
    }
    
    var description: String {
        return "\(String(describing: value))"
    }
}

class LinkList<Element: Equatable>: CustomStringConvertible {
    private var dummy = Node<Element>()
    
    /// size
    var size: Int {
        var num = 0
        var tempNode = dummy.next
        while tempNode != nil {
            num += 1
            tempNode = tempNode?.next
        }
        return num
    }
    
    /// isEmpty
    var isEmpty: Bool {
        return size == 0
    }
    
    /// find node with value
    func node(with value: Element) -> Node<Element>? {
        var node = dummy.next
        while node != nil {
            if node?.value == value {
                return node
            }
            node = node?.next
        }
        return nil
    }
    
    /// 约定：链表的 index 从 1 开始
    func node(at index: Int) -> Node<Element>? {
        var num = 1
        var node = dummy.next
        while node != nil {
            if num == index {
                return node
            }
            
            node = node?.next
            num += 1
        }
        return nil
    }
    
    func insertToHead(value: Element) {
        let node = Node(value: value)
        insertToHead(node: node)
    }
    
    /// insertToHead
    func insertToHead(node: Node<Element>) {
        node.next = dummy.next
        dummy.next = node
    }
    
    /// insert newValue
    func insert(after node: Node<Element>, newValue: Element) {
        let newNode = Node(value: newValue)
        insert(after: node, newNode: newNode)
    }
    
    // insert newNode
    func insert(after node: Node<Element>, newNode: Node<Element>) {
        newNode.next = node.next
        node.next = newNode
    }
    
    func insert(before node: Node<Element>, newValue: Element){
        let newNode = Node(value: newValue)
        insert(before: node, newNode: newNode)
    }
    
    func insert(before node: Node<Element>, newNode: Node<Element>){
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
    
    /// delete node
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
    
    /// delete value
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
    
    var description: String {
        var desc = ""
        var tempNode = dummy.next
    
        desc += "\(String(describing: tempNode?.value))"
        
        while tempNode != nil {
            tempNode = tempNode?.next
            desc += "->" + "\(String(describing: tempNode?.value))"
        }
        
        return "count: \(size) \(desc)"
    }
}


var linkList = LinkList<String>()
let node1 = Node<String>()
node1.value = "1"
linkList.insertToHead(node: node1)

linkList.insert(after: node1, newValue: "2")
print(linkList)

linkList.delete(value: "2")
print(linkList)
