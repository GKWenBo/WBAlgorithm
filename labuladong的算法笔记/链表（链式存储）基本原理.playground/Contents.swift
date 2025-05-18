import Foundation

// 定义单链表节点
class ListNode {
    var val: Int
    var next: ListNode?
    
    init(val: Int, next: ListNode?) {
        self.val = val
        self.next = next
    }
}


/// 创建链表
/// - Parameter arr: 链表数据
/// - Returns: 创建的链表
func createListNode(_ arr: [Int]) -> ListNode? {
    guard arr.count > 0 else { return nil }
    let head = ListNode(val: arr[0], next: nil)
    var current = head
    for i in 1..<arr.count {
        let node = ListNode(val: arr[i], next: nil)
        current.next = node
        current = node
    }
    return head
}

// MARK: - 双向链表
class DoubleListNode {
    var val: Int
    var next: DoubleListNode?
    var prev: DoubleListNode?
    
    init(val: Int, next: DoubleListNode?, prev: DoubleListNode?) {
        self.val = val
        self.next = next
        self.prev = prev
    }
}

// 创建双向链表
func createDoubleListNode(_ arr: [Int]) -> DoubleListNode? {
    guard arr.count > 0 else { return nil }
    let head = DoubleListNode(val: arr[0], next: nil, prev: nil)
    var current = head
    for i in 1..<arr.count {
        let node = DoubleListNode(val: arr[i], next: nil, prev: nil)
        current.next = node
        node.prev = current
        current = node
    }
    return head
}

func printDoubleListNode(_ head: DoubleListNode?) {
    var current = head
    var tail: DoubleListNode? = nil
    while current != nil {
        tail = current
        print(current!.val)
        current = current?.next
    }
    
    while tail != nil {
        print(tail!.val)
        tail = tail?.prev
    }
}

printDoubleListNode(createDoubleListNode([1, 2, 3, 4, 5]))
