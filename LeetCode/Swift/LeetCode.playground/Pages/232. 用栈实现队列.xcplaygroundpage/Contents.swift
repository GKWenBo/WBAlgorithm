//: [Previous](@previous)

import Foundation

class MyQueue {
    
    var inStack: Array<Int>
    var outStack: Array<Int>

    /** Initialize your data structure here. */
    init() {
        inStack = []
        outStack = []
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        inStack.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        checkOutStack()
        return outStack.popLast() ?? -1
    }
    
    /** Get the front element. */
    func peek() -> Int {
        checkOutStack()
        return outStack.last ?? -1
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return inStack.isEmpty && outStack.isEmpty
    }
    
    func checkOutStack() {
        if outStack.isEmpty {
            while !inStack.isEmpty {
                outStack.append(inStack.popLast()!)
            }
        }
    }
}

//: [Next](@next)
