//: [Previous](@previous)

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

//: [Next](@next)
