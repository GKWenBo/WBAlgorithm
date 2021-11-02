//: [Previous](@previous)

/*
 请你仅使用两个队列实现一个后入先出（LIFO）的栈，并支持普通栈的全部四种操作（push、top、pop 和 empty）。

 实现 MyStack 类：

 void push(int x) 将元素 x 压入栈顶。
 int pop() 移除并返回栈顶元素。
 int top() 返回栈顶元素。
 boolean empty() 如果栈是空的，返回 true ；否则，返回 false 。
  

 注意：
 你只能使用队列的基本操作 —— 也就是 push to back、peek/pop from front、size 和 is empty 这些操作。
 你所使用的语言也许不支持队列。 你可以使用 list （列表）或者 deque（双端队列）来模拟一个队列 , 只要是标准的队列操作即可。
  

 示例：
 输入：
 ["MyStack", "push", "push", "top", "pop", "empty"]
 [[], [1], [2], [], [], []]
 输出：
 [null, null, null, 2, 2, false]

 解释：
 MyStack myStack = new MyStack();
 myStack.push(1);
 myStack.push(2);
 myStack.top(); // 返回 2
 myStack.pop(); // 返回 2
 myStack.empty(); // 返回 False
  
 提示：
 1 <= x <= 9
 最多调用100 次 push、pop、top 和 empty
 每次调用 pop 和 top 都保证栈不为空

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/implement-stack-using-queues
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class MyStack {

    var queue: Array<Int>
    
    /** Initialize your data structure here. */
    init() {
        queue = []
    }
    
    /** Push element x onto stack. */
    func push(_ x: Int) {
        queue.append(x)
    }
    
    /** Removes the element on top of the stack and returns that element. */
    func pop() -> Int {
        return queue.popLast() ?? -1
    }
    
    /** Get the top element. */
    func top() -> Int {
        return queue.last ?? -1
    }
    
    /** Returns whether the stack is empty. */
    func empty() -> Bool {
        return queue.isEmpty
    }
}

/**
 * Your MyStack object will be instantiated and called as such:
 * let obj = MyStack()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Bool = obj.empty()
 */

//: [Next](@next)
