import Foundation

//let arr = [1, 2, 3, 4, 5]
//var i = 0
//while i < arr.count {
////    print(arr[i])
//    i = (i + 1) % arr.count
//}

// MARK: - 环形数组实现
public class CycleArray<T>: CustomStringConvertible {
    private var arr: [T?]
    
    private var start: Int
    /// 当前尾元素下标
    private var end: Int
    
    /// 当前元素个数
    private var count: Int
    
    private var capacity: Int  // 总容量
    
    public convenience init() {
        self.init(capacity: 1)
    }
    
    public init(capacity: Int) {
        self.capacity = capacity
        self.arr = Array(repeating: nil, count: capacity)
        self.start = 0
        self.end = 0
        self.count = 0
    }
    
    private func resize(newCapacity: Int) {
        var newArr = [T?](repeating: nil, count: newCapacity)
        for i in 0..<count {
            let index = (start + i) % capacity
            newArr[i] = arr[index]
        }
        arr = newArr
        start = 0
        end = count
        capacity = newCapacity
    }
    
    public func addFirst(_ val: T) {
        if isFull { /// 容器已经满了，扩容为原来的2倍
            resize(newCapacity: capacity * 2)
        }
        /// 计算插入头部元素下标
        start = (start - 1 + capacity) % capacity
        arr[start] = val
        count += 1
    }
    
    public func removeFirst() {
        if isEmpty {
            fatalError("Array is empty")
        }
        /// 清空首元素
        arr[start] = nil
        /// 更新首元素下标
        start = (start + 1) % capacity
        count -= 1
        if count > 0 && count == capacity / 4 { /// 缩容
            resize(newCapacity: capacity / 2)
        }
    }
    
    public func addLast(_ val: T) {
        if isFull { /// 容器已经满了，扩容为原来的2倍
            resize(newCapacity: capacity * 2)
        }
        arr[end] = val
        end = (end + 1) % capacity
        count += 1
    }
    
    public func removeLast() {
        if isEmpty {
            fatalError("Array is empty")
        }
        /// 左移要清空的下标
        end = (end - 1 + capacity) % capacity
        arr[end] = nil
        count -= 1
        if count > 0 && count == capacity / 4 {
            resize(newCapacity: capacity / 2)
        }
    }
    
    public func getFirst() -> T {
        if isEmpty {
            fatalError("Array is empty")
        }
        return arr[start]!
    }
    
    public func getLast() -> T {
        if isEmpty {
            fatalError("Array is empty")
        }
        let index = (end - 1 + capacity) % capacity
        return arr[index]!
    }
    
    // 计算属性
    public var isFull: Bool {
        return count == capacity
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var size: Int {
        return count
    }
    
    // 可选：如果需要访问总容量
    public var currentCapacity: Int {
        return capacity
    }
    
    public var description: String {
        return "\(arr)"
    }
}


let circleArray = CycleArray<Int>(capacity: 10)
circleArray.addFirst(1)
circleArray.addLast(2)
circleArray.addLast(5)
print(circleArray)

