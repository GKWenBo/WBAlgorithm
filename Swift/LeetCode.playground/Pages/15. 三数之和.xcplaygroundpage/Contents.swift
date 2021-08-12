//: [Previous](@previous)

/*
 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。

 注意：答案中不可以包含重复的三元组。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/3sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

import Foundation

func threeSum(_ nums: [Int]) -> [[Int]] {
    guard nums.count > 2 else {
        return []
    }
    /// 结果记录
    var result: Array<Array<Int>> = []
    /// 排序
    let array = nums.sorted()
    
    let n = array.count
    /// a
    for first in 0..<n {
        // 枚举 a
        if first > 0 && array[first] == array[first - 1] {
            continue
        }
        
        /// b
        var second = first + 1
        /// c
        var third = n - 1
        let target = 0 - array[first]
        while second < third {
            let sum = array[second] + array[third]
            if sum == target {
                result.append([array[first], array[second], array[third]])
                
                /// 低指针重复
                while second < third && array[second] == array[second + 1] {
                    second += 1
                }
                
                /// 高指针重复
                while second < third && array[third] == array[third - 1] {
                    third -= 1
                }
                
                second += 1
                third -= 1
            } else if sum < target {
                second += 1
            } else {
                third -= 1
            }
        }
    }
    return result
}

let nums = [-1,0,1,2,-1,-4]
threeSum(nums)


//: [Next](@next)
