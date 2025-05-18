import Foundation

protocol Map {
    associatedtype Key: Hashable
    associatedtype Value
    
    func get(_ key: Key) -> Value?
    func put(_ key: Key, _ value: Value)
    func remove(_ key: Key)
    func containsKey(_ key: Key) -> Bool
    func keys() -> [Key]
    func size() -> Int
}

/*
 用双向链表加强哈希表
 */
class MyLinkedHashMap<Key: Hashable, Value>: Map {
    
    private class ListNode {
        var key: Key?
        var value: Value?
        
        weak var pre: ListNode?
        var next: ListNode?
        
        init(key: Key? = nil, value: Value? = nil) {
            self.key = key
            self.value = value
        }
    }
    
    private let head: ListNode
    private let tail: ListNode
    
    private var map: [Key: ListNode]
    
    init() {
        head = ListNode()
        tail = ListNode()
        head.next = tail
        tail.pre = head
        map = [:]
    }
    
    /// 根据key获取Value
    /// - Parameter key: 键
    /// - Returns: Value
    func get(_ key: Key) -> Value? {
        return map[key]?.value
    }
    
    func put(_ key: Key, _ value: Value) {
        if let node = map[key] { /// 已存在直接更新Value
            node.value = value
        } else { /// 添加新的节点
            let node = ListNode(key: key, value: value)
            addLastNode(node)
            map[key] = node
        }
    }
    
    func remove(_ key: Key) {
        guard let node = map[key] else { return }
        removeNode(node)
        map.removeValue(forKey: key)
    }
    
    func containsKey(_ key: Key) -> Bool {
        return map[key] != nil
    }
    
    func keys() -> [Key] {
        var keys = [Key]()
        var current = head.next
        while current !== tail, let node = current {
            if let key = node.key {
                keys.append(key)
            }
            current = current?.next
        }
        return keys
    }
    
    func size() -> Int {
        return map.count
    }
    
    
    // MARK: - private
    private func addLastNode(_ node: ListNode) {
        let temp = tail.pre
        
        node.pre = temp
        node.next = tail
        
        temp?.next = node
        tail.pre = node
    }
    
    private func removeNode(_ node: ListNode) {
        let pre = node.pre
        let next = node.next
        
        pre?.next = next
        next?.pre = pre
        
        node.pre = nil
        node.next = nil
    }
}

// 单元测试示例
func testMyLinkedHashMap() {
    let map = MyLinkedHashMap<String, Int>()
    map.put("a", 1)
    map.put("b", 2)
    map.put("c", 3)
    map.put("d", 4)
    map.put("e", 5)
    
    assert(map.keys() == ["a", "b", "c", "d", "e"], "Insertion order test failed")
    
    map.remove("c")
    assert(map.keys() == ["a", "b", "d", "e"], "Removal test failed")
    
    assert(map.get("b") == 2, "Value retrieval test failed")
    
    map.put("b", 20)
    assert(map.get("b") == 20, "Update test failed")
    
    assert(map.containsKey("d") == true, "Contains key test failed")
    
    map.remove("a")
    assert(map.keys() == ["b", "d", "e"], "Head removal test failed")
    
    map.remove("e")
    assert(map.keys() == ["b", "d"], "Tail removal test failed")
    
    assert(map.size() == 2, "Size test failed")
}

testMyLinkedHashMap()
print("All tests passed")
