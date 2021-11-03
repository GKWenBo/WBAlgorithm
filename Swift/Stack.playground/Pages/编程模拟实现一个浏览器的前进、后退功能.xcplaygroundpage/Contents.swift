//: [Previous](@previous)

import Foundation

struct Page {
    
    var backArray = [String]()
    var forwardArray = [String]()
    var currentURL: String? {
        return forwardArray.last
    }
    
    init(url: String) {
        forwardArray.append(url)
    }
    
    mutating func goForward(url: String) {
        forwardArray.append(url)
    }
    
    mutating func goBack() {
        backArray.append(forwardArray.popLast()!)
    }
}

//: [Next](@next)
