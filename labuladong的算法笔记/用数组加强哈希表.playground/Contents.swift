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
    /// 随机访问哈希表某一个key
    /// - Returns: 随机访问的key
    func randomKey() -> Key?
}

/*
 使用数组加强哈希表
 */
class MyArrayHashMap<Key: Hashable, Value>: Map {
    class Node {
        var key: Key
        var value: Value
        
        init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }
    }
    
    private var map: [Key: Int] = [:]
    private var array: [Node] = []
    
    func get(_ key: Key) -> Value? {
        guard let index = map[key], index < array.count else { return nil }
        return array[index].value
    }
    
    func put(_ key: Key, _ value: Value) {
        if let index = map[key] {
            array[index].value = value
            return
        }
        
        let node = Node(key: key, value: value)
        array.append(node)
        map[key] = array.count - 1
    }
    
    func remove(_ key: Key) {
        guard let index = map[key], !array.isEmpty else { return }
        if index != array.count - 1 {
            let lastNode = array.last!
            /// 用最后一个元素替换被删除元素
            array[index] = lastNode
            /// 更新最后一个元素的索引
            map[lastNode.key] = index
        }
        
        array.removeLast()
        map.removeValue(forKey: key)
    }
    
    func containsKey(_ key: Key) -> Bool {
        return map[key] != nil
    }
    
    func keys() -> [Key] {
        return array.map { $0.key }
    }
    
    func size() -> Int {
        return map.count
    }
    
    func randomKey() -> Key? {
        guard !array.isEmpty else { return nil }
        let randomIndex = Int.random(in: 0..<array.count)
        return array[randomIndex].key
    }
    
}


// 测试代码
let map = MyArrayHashMap<Int, Int>()
map.put(1, 1)
map.put(2, 2)
map.put(3, 3)
map.put(4, 4)
map.put(5, 5)

print(map.get(1)!) // 1
print(map.randomKey())

map.remove(4)
print(map.keys()) // 应不包含 4

// 测试删除最后一个元素
map.put(6, 6)
map.remove(6)
print(map.containsKey(6)) // 应输出 false

// 测试删除后添加新元素
map.remove(1)
map.put(10, 10)
print(map.get(10)) // 应输出 10
