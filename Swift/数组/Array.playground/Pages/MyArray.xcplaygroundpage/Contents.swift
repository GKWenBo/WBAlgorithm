//: [Previous](@previous)

import Foundation

struct MyArray<Element: Equatable>: CustomStringConvertible {
    private var data: [Element]
    private var size: Int
    private var capacity: Int
    
    init(capacity: Int, defaultElement: Element) {
        data = [Element](repeating: defaultElement, count: capacity)
        self.capacity = capacity
        size = 0
    }
    
    var count: Int {
        return size
    }
    
    var isEmpty: Bool {
        return size == 0
    }
    
    mutating func add(value: Element) -> Bool {
        guard size < capacity else {
            return false
        }
        data[size] = value
        size += 1
        return true
    }
    
    /// 数组中插入元素
    /// - Parameters:
    ///   - value: 要插入的元素
    ///   - index: 插入的下标
    /// - Returns: 成功/失败
    mutating func insert(value: Element , at index: Int) -> Bool {
        // index 必须在 [0, count)
        guard index >= 0, index < size, size < capacity else {
            return false
        }
        
        // count - 1 ~ index
        for i in (index ... size - 1).reversed() {
            data[i + 1] = data[i]
        }
        
        data[index] = value
        size += 1
        return true
    }
    
    /// 根据小标获取元素
    func get(index: Int) -> Element? {
        /// index 必须在 [0, size)
        guard index >= 0 && index < size else {
            return nil
        }
        return data[index]
    }
    
    /// 是否包含某个元素
    func contains(e: Element) -> Bool {
        for i in 0..<size {
            if data[i] == e {
                return true
            }
        }
        return false
    }
    
    mutating func delete(at index: Int) -> Bool {
        guard index >= 0, index < size else {
            return false
        }
        for i in index..<size - 1 {
            data[i] = data[i + 1]
        }
        size -= 1
        return true
    }
    
    func printAll() {
        print(data)
    }
    
    var description: String {
        return data.description
    }
}

//: [Next](@next)

// Test
var array = MyArray<String>(capacity: 2, defaultElement: "")
array.add(value: "1")
array.insert(value: "2", at: 0)

array.printAll()

array.get(index: 0)

array.delete(at: 0)

array.printAll()

