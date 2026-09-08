//: [Previous](@previous)

import Foundation

/*
 设计一个支持 push ，pop ，top 操作，并能在常数时间内检索到最小元素的栈。

 实现 MinStack 类:

 MinStack() 初始化堆栈对象。
 void push(int value) 将元素 value 推入堆栈。
 void pop() 删除堆栈顶部的元素。
 int top() 获取堆栈顶部的元素。
 int getMin() 获取堆栈中的最小元素。


 示例 1:

 输入：
 ["MinStack","push","push","push","getMin","pop","top","getMin"]
 [[],[-2],[0],[-3],[],[],[],[]]

 输出：
 [null,null,null,null,-3,null,0,-2]

 解释：
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.getMin();   --> 返回 -2.


 提示：

 -231 <= val <= 231 - 1
 pop、top 和 getMin 操作总是在 非空栈 上调用
 push, pop, top, and getMin最多被调用 3 * 104 次

 LeetCode: https://leetcode.cn/problems/min-stack/description/
 */

// 思路：辅助栈法
// 用 data 栈存储所有元素，用 min 栈存储当前每一层的最小值（单调非递增）。
// push 时，若新值 <= min 栈顶，同步压入 min 栈，保证 min 栈顶始终是当前最小值。
// pop 时，若弹出值恰好等于 min 栈顶，则同步弹出 min 栈，维护最小值的正确性。
// getMin 直接返回 min 栈顶，O(1) 时间复杂度。
class MinStack {

    /// 主栈，存储所有压入的元素
    var data: [Int] = []
    /// 辅助栈，栈顶始终为当前 data 栈中的最小值
    var min: [Int] = []

    init() {}

    func push(_ value: Int) {
        data.append(value)
        // 只有新值 <= 当前最小值时，才压入辅助栈（等于也压，确保重复最小值能正确 pop）
        if min.isEmpty || value <= min[min.count - 1] {
            min.append(value)
        }
    }

    func pop() {
        guard let top = data.popLast() else { return }
        // 弹出的值等于当前最小值时，辅助栈同步弹出
        if let minValue = min.last, top == minValue {
            min.popLast()
        }
    }

    func top() -> Int {
        return data.last ?? -1
    }

    func getMin() -> Int {
        return min.last ?? -1
    }
}

// MARK: - 测试

func check(_ label: String, _ actual: Int, _ expected: Int) {
    if actual == expected {
        print("✅ \(label): \(actual)")
    } else {
        print("❌ \(label): 期望 \(expected)，实际 \(actual)")
    }
}

// 测试 1：题目示例
// push -2, 0, -3 → getMin=-3, pop, top=0, getMin=-2
do {
    let s = MinStack()
    s.push(-2)
    s.push(0)
    s.push(-3)
    check("示例 getMin()", s.getMin(), -3)
    s.pop()
    check("示例 top()", s.top(), 0)
    check("示例 pop 后 getMin()", s.getMin(), -2)
}

// 测试 2：重复最小值
// push 1, 2, 1 → getMin=1, pop, getMin 仍为 1（不能因 pop 把另一个最小值也丢掉）
do {
    let s = MinStack()
    s.push(1)
    s.push(2)
    s.push(1)
    check("重复最小值 getMin()", s.getMin(), 1)
    s.pop()
    check("重复最小值 pop 后 getMin()", s.getMin(), 1)
}

// 测试 3：递减序列（每次 push 都是新最小值）
do {
    let s = MinStack()
    s.push(5)
    s.push(3)
    s.push(1)
    check("递减序列 getMin()", s.getMin(), 1)
    check("递减序列 top()", s.top(), 1)
    s.pop()
    check("递减序列 pop 后 getMin()", s.getMin(), 3)
    s.pop()
    check("递减序列 pop 后 getMin()", s.getMin(), 5)
}

// 测试 4：递增序列（最小值始终是第一个元素）
do {
    let s = MinStack()
    s.push(1)
    s.push(3)
    s.push(5)
    check("递增序列 getMin()", s.getMin(), 1)
    s.pop()
    check("递增序列 pop 后 getMin()", s.getMin(), 1)
    check("递增序列 pop 后 top()", s.top(), 3)
}

// 测试 5：单个元素
do {
    let s = MinStack()
    s.push(42)
    check("单元素 top()", s.top(), 42)
    check("单元素 getMin()", s.getMin(), 42)
}

// 测试 6：含负数与正数混合
do {
    let s = MinStack()
    s.push(0)
    s.push(-1)
    s.push(2)
    check("混合 getMin()", s.getMin(), -1)
    s.pop()
    check("混合 pop 后 getMin()", s.getMin(), -1)
    s.pop()
    check("混合 pop 后 getMin()", s.getMin(), 0)
}

//: [Next](@next)
