//: [Previous](@previous)

import Foundation


/// 两数之和
/// - Parameters:
///   - nums: 数组
///   - target: 目标和
/// - Returns: 满足的元素
func twoSum(_ nums: [Int], target: Int) -> [Int] {
    let nums = nums.sorted()
    var low = 0
    var high = nums.count - 1
    while low < high {
        let sum = nums[low] + nums[high]
        if sum < target {
            low += 1
        } else if sum > target {
            high -= 1
        } else if sum == target {
            return [nums[low], nums[high]]
        }
    }
    return []
}

func twoSumTarget(_ nums: [Int], target: Int) -> [[Int]] {
    /// 数组必须有序
    let nums = nums.sorted()
    /// 存储结果
    var res: [[Int]] = []
    var low = 0
    var high = nums.count - 1
    while low < high {
        let left = nums[low]
        let right = nums[high]
        let sum = left + right
        if sum < target {
            while low < high && nums[low] == left {
                low += 1
            }
        } else if sum > target {
            while low < high && nums[high] == right {
                high -= 1
            }
        } else if sum == target {
            res.append([left, right])
            while low < high && nums[low] == left {
                low += 1
            }
            while low < high && nums[high] == right {
                high -= 1
            }
        }
    }
    return res
}

func threeSum(_ nums: [Int], target: Int) -> [[Int]] {
    var array = nums.sorted()
    return nSumTarget(array, n: 3, start: 0, target: target)
}


func fourSum(_ nums: [Int], target: Int) -> [[Int]] {
    var array = nums.sorted()
    return nSumTarget(array, n: 4, start: 0, target: target)
}

/// 注意：调用这个函数之前一定要先给 nums 排序
/// - Parameters:
///   - nums: 数组
///   - n: 几数之和
///   - start: 从哪个索引开始计算（一般填 0）
///   - target: 想凑出的和
/// - Returns: 满足结果二元数组
func nSumTarget(_ nums: [Int], n: Int, start: Int, target: Int) -> [[Int]] {
    let sz = nums.count
    var res: [[Int]] = []
    ///至少是2sum问题，且n小于等于数组长度
    guard n > 1, n <= sz else {
        return res
    }
    if n == 2 { /// base case
        // 双指针那一套操作
        var low = start
        var high = sz - 1
        while low < high {
            let left = nums[low]
            let right = nums[high]
            let sum = left + right
            if sum < target {
                while low < high && nums[low] == left {
                    low += 1
                }
            } else if sum > target {
                while low < high && nums[high] == right {
                    high -= 1
                }
            } else if sum == target {
                res.append([left, right])
                while low < high && nums[low] == left {
                    low += 1
                }
                while low < high && nums[high] == right {
                    high -= 1
                }
            }
        }
    } else {
        var i = start
        while i < sz {
            // n > 2 时，递归计算 (n-1)Sum 的结果
            let sub = nSumTarget(nums, n: n - 1, start: i + 1, target: target - nums[i])
            for item in sub {
                // n > 2 时，递归计算 (n-1)Sum 的结果
                var item = item
                item.append(nums[i])
                res.append(item)
            }
            while i < sz - 1 && nums[i] == nums[i + 1] {
                i += 1
            }
            i += 1
        }
    }
    return res
}

let nums = [1,0,-1,0,-2,2]
print("四数之和")
print(fourSum(nums, target: 0))

//: [Next](@next)
