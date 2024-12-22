//: [Previous](@previous)

import Foundation

struct ArrayLRUCache<T: Hashable>: CustomStringConvertible {
    private let capacity: Int
    private var list: [T]
    private var holder: [T: Int]
    
    /// 是否已满
    var isFull: Bool {
        return list.count == capacity
    }
    
    /// 是否为空
    var isEmpty: Bool {
        return list.count == 0
    }
    
    /// 初始化
    /// - Parameters:
    ///   - capacity: 容量大小
    init(_ capacity: Int) {
        self.capacity = capacity
        list = []
        holder = [T: Int]()
    }
    
    /// 模拟访问某个值
    mutating func offer(_ object: T?) {
        guard let object else {
            return
        }
        
        let index = holder[object]
        if let index { /// 元素存在，则更新位置到头部
            update(for: index)
        } else {
            if isFull { /// 容器已满
                removeAndCahce(object)
            } else {
                cache(object)
            }
        }
    }
    
    /// 是否包含某个结果
    func isContain(_ object: T) -> Bool {
        return holder.keys.contains(object)
    }
    
    /// 若缓存满的情况，剔出后，再缓存到头部
    /// - Parameter object: object description
    private mutating func removeAndCahce(_ object: T) {
        let lastObject = list.removeLast()
        holder.removeValue(forKey: lastObject)
        list.insert(object, at: 0)
        updateHolder()
    }
    
    /// 数据要缓存到头部，需要先右移
    /// - Parameters:
    ///   - object: 要缓存的数据
    ///   - end: 数组右移边界
    private mutating func cache(_ object: T) {
        list.insert(object, at: 0)
        updateHolder()
    }
    
    /// 缓存中有指定值，则更新位置
    private mutating func update(for index: Int) {
        let object = list[index]
        list.remove(at: index)
        list.insert(object, at: 0)
        updateHolder()
    }
    
    private mutating func updateHolder() {
        /// 维护下标
        list.enumerated().forEach { index, object in
            holder[object] = index
        }
    }
    
    // MARK: - CustomStringConvertible
    var description: String {
        var str = ""
        for item in list {
            str += "\(item)"
            str += " "
        }
        return str
    }
}

// Test
var lru = ArrayLRUCache<Int>(4)
lru.offer(1)
print(lru)
lru.offer(2)
print(lru)
lru.offer(3)
print(lru)
lru.offer(4)
print(lru)
lru.offer(2)
print(lru)
lru.offer(4)
print(lru)
lru.offer(7)
print(lru)
//: [Next](@next)
