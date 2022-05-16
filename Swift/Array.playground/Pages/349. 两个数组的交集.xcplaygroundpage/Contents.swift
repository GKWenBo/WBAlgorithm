//: [Previous](@previous)

import Foundation

/*
 https://leetcode.cn/problems/intersection-of-two-arrays/
 */

class Solution {
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        guard !nums1.isEmpty && !nums2.isEmpty else {
            return []
        }
        
        let set1 = Set.init(nums1)
        let set2 = Set.init(nums2)
        
        return Array.init(set1.intersection(set2))
    }
}

let s = Solution()
s.intersection([1, 3, 2], [1])


//: [Next](@next)
