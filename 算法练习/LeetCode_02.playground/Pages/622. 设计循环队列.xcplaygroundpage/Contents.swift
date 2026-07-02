//: [Previous](@previous)

import Foundation

/*
 设计你的循环队列实现。 循环队列是一种线性数据结构，其操作表现基于 FIFO（先进先出）原则并且队尾被连接在队首之后以形成一个循环。它也被称为"环形缓冲器"。

 循环队列的一个好处是我们可以利用这个队列之前用过的空间。在一个普通队列里，一旦一个队列满了，我们就不能插入下一个元素，即使在队列前面仍有空间。但是使用循环队列，我们能使用这些空间去存储新的值。

 你的实现应该支持如下操作：

 MyCircularQueue(k): 构造器，设置队列长度为 k 。
 Front: 从队首获取元素。如果队列为空，返回 -1 。
 Rear: 获取队尾元素。如果队列为空，返回 -1 。
 enQueue(value): 向循环队列插入一个元素。如果成功插入则返回真。
 deQueue(): 从循环队列中删除一个元素。如果成功删除则返回真。
 isEmpty(): 检查循环队列是否为空。
 isFull(): 检查循环队列是否已满。


 示例：

 MyCircularQueue circularQueue = new MyCircularQueue(3); // 设置长度为 3
 circularQueue.enQueue(1);  // 返回 true
 circularQueue.enQueue(2);  // 返回 true
 circularQueue.enQueue(3);  // 返回 true
 circularQueue.enQueue(4);  // 返回 false，队列已满
 circularQueue.Rear();  // 返回 3
 circularQueue.isFull();  // 返回 true
 circularQueue.deQueue();  // 返回 true
 circularQueue.enQueue(4);  // 返回 true
 circularQueue.Rear();  // 返回 4


 提示：

 所有的值都在 0 至 1000 的范围内；
 操作数将在 1 至 1000 的范围内；
 请不要使用内置的队列库。

 LeetCode: https://leetcode.cn/problems/design-circular-queue/description/
 */

// 设计思路：定长数组 + 头尾双指针
//
// 数组大小取 k+1，用一个额外的空位区分"满"和"空"两种状态：
//   ┌───┬───┬───┬───┐
//   │ 1 │ 2 │ 3 │   │   capacity = 4 (k=3)
//   └───┴───┴───┴───┘
//     ↑               ↑
//   start(队首)      end(下一插入位)
//
// 空条件：start == end
// 满条件：(end + 1) % capacity == start
class MyCircularQueue {

    // 实际数组容量 = k + 1，留一个空位用于区分空满
    let capacity: Int

    // 队首指针：指向第一个有效元素
    private var start = 0

    // 队尾指针：指向下一个待插入的空位（不是最后一个元素）
    private var end = 0

    private var store: [Int]

    init(_ k: Int) {
        self.capacity = k + 1
        self.store = Array(repeating: 0, count: capacity)
    }

    // 入队：先写入 end 位置，再将 end 向后移一步（取模实现循环）
    func enQueue(_ value: Int) -> Bool {
        if isFull() {
            return false
        }
        store[end] = value
        end = (end + 1) % capacity
        return true
    }

    // 出队：start 向后移一步（逻辑删除队首元素，不需要清空数据）
    func deQueue() -> Bool {
        if isEmpty() {
            return false
        }
        start = (start + 1) % capacity
        return true
    }

    // 队首元素：start 直接指向第一个有效元素
    func Front() -> Int {
        if isEmpty() {
            return -1
        }
        return store[start]
    }

    // 队尾元素：end 的前一位即最后入队的元素（+capacity 防止 end=0 时下标为负）
    func Rear() -> Int {
        if isEmpty() {
            return -1
        }
        return store[(end - 1 + capacity) % capacity]
    }

    // 头尾指针重合 → 队列为空
    func isEmpty() -> Bool {
        return start == end
    }

    // end 前进一步后追上 start → 数组已满（那个追上的位置留空不写）
    func isFull() -> Bool {
        return (end + 1) % capacity == start
    }
}

// MARK: - 测试

// 测试用例 1：题目给出的示例
do {
    let q = MyCircularQueue(3)
    assert(q.enQueue(1) == true,  "enQueue(1) 应返回 true")
    assert(q.enQueue(2) == true,  "enQueue(2) 应返回 true")
    assert(q.enQueue(3) == true,  "enQueue(3) 应返回 true")
    assert(q.enQueue(4) == false, "队满后 enQueue(4) 应返回 false")
    assert(q.Rear()     == 3,     "Rear 应返回 3")
    assert(q.isFull()   == true,  "isFull 应返回 true")
    assert(q.deQueue()  == true,  "deQueue 应返回 true")
    assert(q.enQueue(4) == true,  "出队后 enQueue(4) 应返回 true")
    assert(q.Rear()     == 4,     "Rear 应返回 4")
    print("✅ 测试用例 1 通过：题目示例")
}

// 测试用例 2：空队列的边界操作
do {
    let q = MyCircularQueue(3)
    assert(q.isEmpty()  == true,  "初始化后队列应为空")
    assert(q.isFull()   == false, "初始化后队列不应为满")
    assert(q.Front()    == -1,    "空队列 Front 应返回 -1")
    assert(q.Rear()     == -1,    "空队列 Rear 应返回 -1")
    assert(q.deQueue()  == false, "空队列 deQueue 应返回 false")
    print("✅ 测试用例 2 通过：空队列边界操作")
}

// 测试用例 3：容量为 1 的极小情况
do {
    let q = MyCircularQueue(1)
    assert(q.enQueue(5) == true,  "容量1：enQueue(5) 应返回 true")
    assert(q.isFull()   == true,  "入队后应为满")
    assert(q.Front()    == 5,     "Front 应返回 5")
    assert(q.Rear()     == 5,     "Rear 应返回 5")
    assert(q.enQueue(6) == false, "队满后 enQueue(6) 应返回 false")
    assert(q.deQueue()  == true,  "deQueue 应返回 true")
    assert(q.isEmpty()  == true,  "出队后应为空")
    assert(q.enQueue(6) == true,  "空队后再 enQueue(6) 应返回 true")
    assert(q.Rear()     == 6,     "Rear 应返回 6")
    print("✅ 测试用例 3 通过：容量为 1 的极小情况")
}

// 测试用例 4：循环复用已释放的空间
do {
    let q = MyCircularQueue(3)
    q.enQueue(10)
    q.enQueue(20)
    q.enQueue(30)
    q.deQueue()               // 移除 10，队首变为 20
    q.enQueue(40)             // 复用 10 原来占用的位置
    assert(q.Front() == 20,   "循环后 Front 应为 20")
    assert(q.Rear()  == 40,   "循环后 Rear 应为 40")
    q.deQueue()
    q.deQueue()
    q.deQueue()
    assert(q.isEmpty() == true, "全部出队后应为空")
    print("✅ 测试用例 4 通过：循环复用空间")
}

// 测试用例 5：验证 FIFO（先进先出）顺序
do {
    let q = MyCircularQueue(5)
    let values = [1, 2, 3, 4, 5]
    for v in values { _ = q.enQueue(v) }
    for v in values {
        assert(q.Front() == v, "FIFO：Front 应为 \(v)")
        _ = q.deQueue()
    }
    assert(q.isEmpty() == true, "全部出队后应为空")
    print("✅ 测试用例 5 通过：FIFO 顺序验证")
}

//: [Next](@next)
