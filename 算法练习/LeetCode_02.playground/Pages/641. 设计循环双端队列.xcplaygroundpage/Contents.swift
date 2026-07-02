//: [Previous](@previous)

import Foundation

/*
 设计实现双端队列。

 实现 MyCircularDeque 类:

 MyCircularDeque(int k) ：构造函数,双端队列最大为 k 。
 boolean insertFront()：将一个元素添加到双端队列头部。 如果操作成功返回 true ，否则返回 false 。
 boolean insertLast() ：将一个元素添加到双端队列尾部。如果操作成功返回 true ，否则返回 false 。
 boolean deleteFront() ：从双端队列头部删除一个元素。 如果操作成功返回 true ，否则返回 false 。
 boolean deleteLast() ：从双端队列尾部删除一个元素。如果操作成功返回 true ，否则返回 false 。
 int getFront() )：从双端队列头部获得一个元素。如果双端队列为空，返回 -1 。
 int getRear() ：获得双端队列的最后一个元素。 如果双端队列为空，返回 -1 。
 boolean isEmpty() ：若双端队列为空，则返回 true ，否则返回 false  。
 boolean isFull() ：若双端队列满了，则返回 true ，否则返回 false 。
  

 示例 1：

 输入
 ["MyCircularDeque", "insertLast", "insertLast", "insertFront", "insertFront", "getRear", "isFull", "deleteLast", "insertFront", "getFront"]
 [[3], [1], [2], [3], [4], [], [], [], [4], []]
 输出
 [null, true, true, true, false, 2, true, true, true, 4]

 解释
 MyCircularDeque circularDeque = new MycircularDeque(3); // 设置容量大小为3
 circularDeque.insertLast(1);                    // 返回 true
 circularDeque.insertLast(2);                    // 返回 true
 circularDeque.insertFront(3);                    // 返回 true
 circularDeque.insertFront(4);                    // 已经满了，返回 false
 circularDeque.getRear();                  // 返回 2
 circularDeque.isFull();                        // 返回 true
 circularDeque.deleteLast();                    // 返回 true
 circularDeque.insertFront(4);                    // 返回 true
 circularDeque.getFront();                // 返回 4
  
  

 提示：

 1 <= k <= 1000
 0 <= value <= 1000
 insertFront, insertLast, deleteFront, deleteLast, getFront, getRear, isEmpty, isFull  调用次数不大于 2000 次
 
 LeetCode: https://leetcode.cn/problems/design-circular-deque/description/
 */


// 环形数组实现循环双端队列
// 核心思路：使用 capacity = k + 1 的数组，留出一个空槽位区分"满"和"空"
// - 空队列条件：start == end
// - 满队列条件：(end + 1) % capacity == start
// - start 指向队首元素，end 指向队尾下一个空位
class MyCircularDeque {

    private var store: [Int]

    // 实际分配容量 = k + 1，多出的一个槽位作为哨兵，避免满/空状态歧义
    private let capacity: Int

    // 队首索引（指向队首元素）
    private var start = 0

    // 队尾索引（指向队尾元素的下一个空位）
    private var end = 0

    init(_ k: Int) {
        self.capacity = k + 1
        self.store = Array(repeating: 0, count: self.capacity)
    }

    // 从队首插入：start 前移一位后写入
    func insertFront(_ value: Int) -> Bool {
        guard !isFull() else {
            return false
        }
        start = (start - 1 + capacity) % capacity
        store[start] = value
        return true
    }

    // 从队尾插入：先写入 end 位置，再将 end 后移一位
    func insertLast(_ value: Int) -> Bool {
        guard !isFull() else {
            return false
        }
        store[end] = value
        end = (end + 1) % capacity
        return true
    }

    // 删除队首：start 后移一位（逻辑删除）
    func deleteFront() -> Bool {
        guard !isEmpty() else {
            return false
        }
        start = (start + 1) % capacity
        return true
    }

    // 删除队尾：end 前移一位（逻辑删除）
    func deleteLast() -> Bool {
        guard !isEmpty() else {
            return false
        }
        end = (end - 1 + capacity) % capacity
        return true
    }

    func getFront() -> Int {
        guard !isEmpty() else {
            return -1
        }
        return store[start]
    }

    func getRear() -> Int {
        guard !isEmpty() else {
            return -1
        }
        // end 指向空位，队尾元素在 end 的前一位
        return store[((end - 1) + capacity) % capacity]
    }

    func isEmpty() -> Bool {
        return start == end
    }

    func isFull() -> Bool {
        return (end + 1) % capacity == start
    }
}

// MARK: - 测试工具

private var passCount = 0
private var failCount = 0

@MainActor private func assert(_ condition: Bool, _ message: String) {
    if condition {
        passCount += 1
        print("✅ PASS: \(message)")
    } else {
        failCount += 1
        print("❌ FAIL: \(message)")
    }
}

@MainActor private func printSummary() {
    print("\n--- 测试结果: \(passCount) 通过 / \(failCount) 失败 ---")
}

// MARK: - 测试用例

// 测试 1：题目示例验证
@MainActor func testExample() {
    print("\n[测试 1] 题目示例")
    let dq = MyCircularDeque(3)
    assert(dq.insertLast(1) == true,  "insertLast(1) 应返回 true")
    assert(dq.insertLast(2) == true,  "insertLast(2) 应返回 true")
    assert(dq.insertFront(3) == true, "insertFront(3) 应返回 true")
    assert(dq.insertFront(4) == false,"队列已满，insertFront(4) 应返回 false")
    assert(dq.getRear()  == 2,        "队尾应为 2")
    assert(dq.isFull()   == true,     "队列应已满")
    assert(dq.deleteLast() == true,   "deleteLast() 应返回 true")
    assert(dq.insertFront(4) == true, "删除后 insertFront(4) 应返回 true")
    assert(dq.getFront() == 4,        "队首应为 4")
}

// 测试 2：空队列边界操作
@MainActor func testEmptyQueue() {
    print("\n[测试 2] 空队列边界")
    let dq = MyCircularDeque(2)
    assert(dq.isEmpty()     == true,  "初始应为空")
    assert(dq.isFull()      == false, "初始不应满")
    assert(dq.getFront()    == -1,    "空队列 getFront 应返回 -1")
    assert(dq.getRear()     == -1,    "空队列 getRear 应返回 -1")
    assert(dq.deleteFront() == false, "空队列 deleteFront 应返回 false")
    assert(dq.deleteLast()  == false, "空队列 deleteLast 应返回 false")
}

// 测试 3：容量为 1 的极端情况
@MainActor func testCapacityOne() {
    print("\n[测试 3] 容量为 1")
    let dq = MyCircularDeque(1)
    assert(dq.insertLast(7)  == true,  "insertLast(7) 应成功")
    assert(dq.isFull()       == true,  "容量 1 插入后应满")
    assert(dq.getFront()     == 7,     "getFront 应为 7")
    assert(dq.getRear()      == 7,     "getRear 应为 7")
    assert(dq.insertFront(9) == false, "已满，insertFront 应失败")
    assert(dq.deleteFront()  == true,  "deleteFront 应成功")
    assert(dq.isEmpty()      == true,  "删除后应为空")
}

// 测试 4：环形绕回行为（反复插入删除触发索引绕回）
@MainActor func testCircularWrapAround() {
    print("\n[测试 4] 环形绕回")
    let dq = MyCircularDeque(3)
    // 先填满再清空，触发指针绕回
    dq.insertLast(1); dq.insertLast(2); dq.insertLast(3)
    dq.deleteFront(); dq.deleteFront()   // 删除 1、2，start 向右移动
    dq.insertLast(4); dq.insertLast(5)  // end 绕回到数组头部
    assert(dq.getFront() == 3, "绕回后队首应为 3")
    assert(dq.getRear()  == 5, "绕回后队尾应为 5")
    assert(dq.isFull()   == true, "应已满")
}

// 测试 5：混合从两端插入和删除
@MainActor func testMixedOperations() {
    print("\n[测试 5] 两端混合操作")
    let dq = MyCircularDeque(4)
    dq.insertLast(10)
    dq.insertFront(20)
    dq.insertLast(30)
    dq.insertFront(40)
    // 队列顺序：40, 20, 10, 30
    assert(dq.getFront() == 40, "队首应为 40")
    assert(dq.getRear()  == 30, "队尾应为 30")
    dq.deleteFront()
    assert(dq.getFront() == 20, "删除队首后，新队首应为 20")
    dq.deleteLast()
    assert(dq.getRear()  == 10, "删除队尾后，新队尾应为 10")
}

testExample()
testEmptyQueue()
testCapacityOne()
testCircularWrapAround()
testMixedOperations()
printSummary()


//: [Next](@next)
