//: [Previous](@previous)

import Foundation

class Node {
    var val: Int
    var children: [Node]
    
    init(val: Int, children: [Node]) {
        self.val = val
        self.children = children
    }
}

func traverse(_ root: Node?) {
    guard let root else { return }
    
    /// 前序位置
    for node in root.children {
        traverse(node)
    }
    
    /// 后续位置
}

//: [Next](@next)
