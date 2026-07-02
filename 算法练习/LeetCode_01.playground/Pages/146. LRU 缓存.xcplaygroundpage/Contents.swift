//: [Previous](@previous)

import Foundation

/*
 请你设计并实现一个满足  LRU (最近最少使用) 缓存 约束的数据结构。
 实现 LRUCache 类：
 LRUCache(int capacity) 以 正整数 作为容量 capacity 初始化 LRU 缓存
 int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
 void put(int key, int value) 如果关键字 key 已经存在，则变更其数据值 value ；如果不存在，则向缓存中插入该组 key-value 。如果插入操作导致关键字数量超过 capacity ，则应该 逐出 最久未使用的关键字。
 函数 get 和 put 必须以 O(1) 的平均时间复杂度运行。

  

 示例：

 输入
 ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
 输出
 [null, null, null, 1, null, -1, null, -1, 3, 4]

 解释
 LRUCache lRUCache = new LRUCache(2);
 lRUCache.put(1, 1); // 缓存是 {1=1}
 lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
 lRUCache.get(1);    // 返回 1
 lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
 lRUCache.get(2);    // 返回 -1 (未找到)
 lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
 lRUCache.get(1);    // 返回 -1 (未找到)
 lRUCache.get(3);    // 返回 3
 lRUCache.get(4);    // 返回 4
  

 提示：

 1 <= capacity <= 3000
 0 <= key <= 10000
 0 <= value <= 105
 最多调用 2 * 105 次 get 和 put
 
 LeetCode: https://leetcode.cn/problems/lru-cache/description/
 */

// 思路：哈希表 + 双向链表
// - 哈希表：O(1) 定位节点
// - 双向链表：维护访问顺序，head 端为最近使用，tail 端为最久未使用
// - 虚拟头尾哨兵节点，简化边界处理
class LRUCache {

    // 双向链表节点，同时存储 key 以便淘汰时能从哈希表中删除
    private class Node {
        var pre: Node?
        var next: Node?
        var value: Int
        var key: Int

        init(pre: Node? = nil,
             next: Node? = nil,
             value: Int,
             key: Int) {
            self.pre = pre
            self.next = next
            self.value = value
            self.key = key
        }
    }

    // key -> Node 的映射，实现 O(1) 查找
    private var map: [Int: Node] = [:]

    private let capacity: Int

    // 虚拟头节点（最近使用端）
    private var head: Node = Node(value: 0, key: 0)

    // 虚拟尾节点（最久未使用端）
    private var tail: Node = Node(value: 0, key: 0)

    init(_ capacity: Int) {
        self.capacity = capacity
        // 初始化：head <-> tail
        head.next = tail
        tail.pre = head
    }

    func get(_ key: Int) -> Int {
        guard let node = map[key] else {
            return -1
        }
        // 访问后将节点移到链表头部，标记为最近使用
        moveToHead(node)
        return node.value
    }

    func put(_ key: Int, _ value: Int) {
        if let node = map[key] {
            // key 已存在：更新值并移到头部
            node.value = value
            moveToHead(node)
            return
        }

        // key 不存在：新建节点插入头部
        let node = Node(value: value, key: key)
        map[key] = node
        addToHead(node)

        // 超出容量：淘汰链表尾部（最久未使用）的节点
        if map.count > capacity {
            let lr = tail.pre!
            removeNode(lr)
            map[lr.key] = nil
        }
    }

    // 在 head 之后插入节点
    private func addToHead(_ node: Node) {
        node.next = head.next
        head.next?.pre = node
        node.pre = head
        head.next = node
    }

    // 将已有节点移到头部（先摘除，再插入）
    private func moveToHead(_ node: Node) {
        removeNode(node)
        addToHead(node)
    }

    // 从链表中摘除节点（不释放，复用于 moveToHead）
    private func removeNode(_ node: Node) {
        node.pre?.next = node.next
        node.next?.pre = node.pre
    }
}

// MARK: - 测试

// 简单断言工具，输出测试结果
func assert(_ condition: Bool, _ message: String) {
    if condition {
        print("✅ PASS: \(message)")
    } else {
        print("❌ FAIL: \(message)")
    }
}

// 测试 1：LeetCode 官方示例
do {
    let cache = LRUCache(2)
    cache.put(1, 1)
    cache.put(2, 2)
    assert(cache.get(1) == 1, "get(1) 应返回 1")
    cache.put(3, 3)                                  // 淘汰 key=2（最久未使用）
    assert(cache.get(2) == -1, "key=2 已被淘汰，应返回 -1")
    cache.put(4, 4)                                  // 淘汰 key=1（最久未使用）
    assert(cache.get(1) == -1, "key=1 已被淘汰，应返回 -1")
    assert(cache.get(3) == 3, "get(3) 应返回 3")
    assert(cache.get(4) == 4, "get(4) 应返回 4")
}

// 测试 2：get 不存在的 key 返回 -1
do {
    let cache = LRUCache(2)
    assert(cache.get(999) == -1, "空缓存 get 应返回 -1")
}

// 测试 3：put 更新已有 key 的值
do {
    let cache = LRUCache(2)
    cache.put(1, 10)
    cache.put(1, 20)                                 // 更新 key=1 的值
    assert(cache.get(1) == 20, "put 更新后 get(1) 应返回 20")
}

// 测试 4：put 更新已有 key 后，该 key 变为最近使用，不会被淘汰
do {
    let cache = LRUCache(2)
    cache.put(1, 1)
    cache.put(2, 2)
    cache.put(1, 100)                                // 刷新 key=1，使其成为最近使用
    cache.put(3, 3)                                  // 淘汰 key=2（最久未使用）
    assert(cache.get(1) == 100, "key=1 被更新后不应被淘汰，应返回 100")
    assert(cache.get(2) == -1, "key=2 应被淘汰，返回 -1")
    assert(cache.get(3) == 3, "get(3) 应返回 3")
}

// 测试 5：容量为 1 时，每次 put 不同 key 都会淘汰旧 key
do {
    let cache = LRUCache(1)
    cache.put(1, 1)
    assert(cache.get(1) == 1, "get(1) 应返回 1")
    cache.put(2, 2)                                  // 淘汰 key=1
    assert(cache.get(1) == -1, "key=1 已被淘汰，应返回 -1")
    assert(cache.get(2) == 2, "get(2) 应返回 2")
}

// 测试 6：get 操作使节点变为最近使用，影响淘汰顺序
do {
    let cache = LRUCache(2)
    cache.put(1, 1)
    cache.put(2, 2)
    _ = cache.get(1)                                 // 访问 key=1，使其成为最近使用
    cache.put(3, 3)                                  // 淘汰 key=2（此时最久未使用）
    assert(cache.get(1) == 1, "key=1 被访问后不应被淘汰，应返回 1")
    assert(cache.get(2) == -1, "key=2 应被淘汰，返回 -1")
    assert(cache.get(3) == 3, "get(3) 应返回 3")
}

//: [Next](@next)
