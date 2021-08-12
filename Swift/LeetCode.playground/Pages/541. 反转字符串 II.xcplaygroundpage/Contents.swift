//: [Previous](@previous)

import Foundation

func reverseStr(_ s: String, _ k: Int) -> String {
    var stringArray = s.map { $0 }
    
    var start = 0
    while start < s.count {
        var i = start
        var j = min(start + k - 1, s.count - 1)
        
        while i < j {
            stringArray.swapAt(i, j)
            i += 1
            j -= 1
        }
        start += 2 * k
    }
    return String(stringArray)
}

let s = "abcdefg"

let res = reverseStr(s, 2)
print(res)


//: [Next](@next)
