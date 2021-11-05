//: [Previous](@previous)

import Foundation

protocol LRUCache {
    associatedtype Value
    associatedtype Key
    /// 当前缓存个数
    var size: Int { get }
    /// 是否为空
    var isEmpty: Bool { get }
    /// 添加缓存
    mutating func set(newElemet: Value, forKey: Key)
    /// 获取缓存
    mutating func value(forKey: Key) -> Value?
    /// 清空缓存
    mutating func clear()
}

/// 基于数组实现LRU缓存实现
struct ArrayLRUCache<Key: Hashable, Value>: LRUCache, CustomStringConvertible {
    static var defaultCacheSize: Int {
        return 10
    }
    var lruList: [Key]
    var mapCache: [Key: Value]
    
    /// 最多缓存个数
    var cacheSize: Int
    /// 当前缓存个数
    var size: Int {
        return lruList.count
    }
    var isEmpty: Bool {
        return mapCache.isEmpty
    }
    
    init() {
        self.init(cacheSize: Self.defaultCacheSize)
    }
    
    init(cacheSize: Int) {
        self.cacheSize = cacheSize
        lruList = []
        mapCache = [:]
    }
    
    mutating func set(newElemet: Value, forKey: Key) {
        lruList.append(forKey)
        mapCache.updateValue(newElemet, forKey: forKey)
        if lruList.count > cacheSize {
            let removed = lruList.remove(at: 0)
            if removed != forKey {
                mapCache[removed] = nil
            }
        }
    }
    
    mutating func value(forKey: Key) -> Value? {
        guard let value = mapCache[forKey] else { return nil }
        if let index = lruList.firstIndex(of: forKey) {
            lruList.remove(at: index)
            lruList.append(forKey)
        }
        return value
    }
    
    mutating func clear() {
        lruList.removeAll()
        mapCache.removeAll()
    }
    
    var description: String {
        var str = ""
        for key in lruList {
            if str == "" {
                str += "\(String(describing: mapCache[key]))"
            } else {
                str += " " + "\(String(describing: mapCache[key]))"
            }
        }
        return str
    }
}

var lru = ArrayLRUCache<Int, Int>.init(cacheSize: 3)
lru.set(newElemet: 1, forKey: 1)
print(lru)
print(lru.size)
lru.set(newElemet: 2, forKey: 2)
print(lru)
print(lru.size)
lru.set(newElemet: 3, forKey: 3)
print(lru)
print(lru.size)
lru.set(newElemet: 4, forKey: 4)
print(lru)
print(lru.size)
lru.value(forKey: 2)
print(lru)
print(lru.size)

lru.value(forKey: 3)
print(lru)
print(lru.size)

//: [Next](@next)
