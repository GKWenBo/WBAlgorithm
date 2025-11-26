//: [Previous](@previous)

import Foundation

/*
 给定一个包含红色、白色和蓝色、共 n 个元素的数组 nums ，原地 对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。

 我们使用整数 0、 1 和 2 分别表示红色、白色和蓝色。

 必须在不使用库内置的 sort 函数的情况下解决这个问题。

  

 示例 1：

 输入：nums = [2,0,2,1,1,0]
 输出：[0,0,1,1,2,2]
 示例 2：

 输入：nums = [2,0,1]
 输出：[0,1,2]
  

 提示：

 n == nums.length
 1 <= n <= 300
 nums[i] 为 0、1 或 2
  

 进阶：

 你能想出一个仅使用常数空间的一趟扫描算法吗？
 
 LeetCode：https://leetcode.cn/problems/sort-colors/description/
 */

class Solution {
    func sortColors(_ nums: inout [Int]) {
        /// 注意区间的开闭，初始化时区间内应该没有元素
        /// 所以我们定义 [0，p0) 是元素 0 的区间，(p2, nums.length - 1] 是 2 的区间
        var p = 0
        var p0 = 0
        var p2 = nums.count - 1
        while p <= p2 { /// 由于 p2 是开区间，所以 p <= p2
            if nums[p] == 2 {
                nums.swapAt(p, p2)
                p2 -= 1
            } else if nums[p] == 0 {
                nums.swapAt(p, p0)
                p0 += 1
            } else if nums[p] == 1 {
                p += 1
            }
            
            /// 因为小于 p0 都是 0，所以 p 不要小于 p0
            if p < p0 {
                p = p0
            }
        }
    }
}

var nums = [2,0,2,1,1,0]
Solution().sortColors(&nums)
print(nums)

//: [Next](@next)
