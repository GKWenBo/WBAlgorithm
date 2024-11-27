//: [Previous](@previous)

import Foundation

struct MyArray {
    
    static let NOTFOUND = -1
    
    public var data: Array<Int>
    private var count: Int
    private var n: Int
    
    init(_ capacity: Int) {
        self.data = Array(repeating: 0, count: capacity)
        self.n = capacity
        self.count = 0
    }
    
    /// 根据下标查找元素
    /// - Parameter index: 下标
    /// - Returns: 找到的元素
    func find(_ index: Int) -> Int {
        guard index > 0 || index < count else {
            return Self.NOTFOUND
        }
        return data[index]
    }
    
    mutating func insert(index: Int, value: Int) -> Bool {
        if count == n {
            print("没有可插入的位置")
            return false
        }
        if index < 0 || index > count {
            print("插入位置不合法")
            return false
        }
        
        var i = count
        while i > index {
            data[i] = data[i - 1]
            i -= 1
        }
        data[index] = value
        count += 1
        return true
    }
    
    /// 根据索引删除数组元素
    /// - Parameter index: 删除元素下标
    /// - Returns: 成功或者失败
    mutating func delete(_ index: Int) -> Bool {
        guard index >= 0 || index < count else {
            return false
        }
        
        for i in (index + 1)..<count {
            data[i - 1] = data[i]
        }
        count -= 1
        return true
    }
    
    func printAll() {
        for value in data {
            print("\(value)" + " ")
        }
    }
}


// Test
var array = MyArray(5)
array.insert(index: 0, value: 3)
array.insert(index: 0, value: 5)
array.insert(index: 1, value: 4)
array.insert(index: 3, value: 9)
array.printAll()
array.delete(1)
print("============")
array.printAll()

//: [Next](@next)
