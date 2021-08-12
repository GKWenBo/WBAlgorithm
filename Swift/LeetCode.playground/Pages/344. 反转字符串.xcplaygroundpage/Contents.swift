//: [Previous](@previous)

import Foundation

func reverseString(_ s: inout [Character]) {
    guard !s.isEmpty else {
        return
    }
    
    let count = s.count
    
    for i in 0..<count / 2 {
        s.swapAt(i, count - i - 1)
    }
}


var s: [Character] = ["h","e","l","l","o"]
reverseString(&s)


//: [Next](@next)
