//: [Previous](@previous)

import Foundation

func firstUniqChar(_ s: String) -> Character {
    let space: Character = " "
    
    guard !s.isEmpty else {
        return space
    }
    var dict: Dictionary<Character, Bool> = [:]
    for c in s {
        dict.updateValue(!dict.keys.contains(c), forKey: c)
    }
    
    for c in s {
        if let first = dict[c], first {
            return c
        }
    }
    return space
}

let s = "abaccdeff"
firstUniqChar(s)

//: [Next](@next)
