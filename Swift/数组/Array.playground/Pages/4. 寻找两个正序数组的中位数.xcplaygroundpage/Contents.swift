//: [Previous](@previous)

/*
 给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。

 算法的时间复杂度应该为 O(log (m+n)) 。

 示例 1：
 输入：nums1 = [1,3], nums2 = [2]
 输出：2.00000
 解释：合并数组 = [1,2,3] ，中位数 2
 
 示例 2：
 输入：nums1 = [1,2], nums2 = [3,4]
 输出：2.50000
 解释：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5
 
 示例 3：
 输入：nums1 = [0,0], nums2 = [0,0]
 输出：0.00000
 
 示例 4：
 输入：nums1 = [], nums2 = [1]
 输出：1.00000
 
 示例 5：
 输入：nums1 = [2], nums2 = []
 输出：2.00000
  
 提示：
 nums1.length == m
 nums2.length == n
 0 <= m <= 1000
 0 <= n <= 1000
 1 <= m + n <= 2000
 -106 <= nums1[i], nums2[i] <= 106

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/median-of-two-sorted-arrays
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let m = nums1.count
        let n = nums2.count
        
        /// 为了保证第一个数组比第二个数组小(或者相等)
        if m > n {
            return findMedianSortedArrays(nums2, nums1)
        }

        let halfLength: Int = (m + n + 1) >> 1
        var b = 0, e = m
        /// 左区间最大值
        var maxOfLeft = 0
        /// 右区间最小值
        var minOfRight = 0
        
        while b <= e {
            let mid1 = (b + e) >> 1
            let mid2 = halfLength - mid1
            
            if mid1 > 0 && mid2 < n && nums1[mid1 - 1] > nums2[mid2] {
                e = mid1 - 1
            } else if mid2 > 0 && mid1 < m && nums1[mid1] < nums2[mid2 - 1] {
                b = mid1 + 1
            } else {
                if mid1 == 0 {
                    maxOfLeft = nums2[mid2 - 1]
                } else if mid2 == 0 {
                    maxOfLeft = nums1[mid1 - 1]
                } else {
                    maxOfLeft = max(nums1[mid1 - 1], nums2[mid2 - 1])
                }
                
                if (m + n) % 2 == 1 {
                    return Double(maxOfLeft)
                }
                
                if mid1 == m {
                    minOfRight = nums2[mid2]
                } else if mid2 == n {
                    minOfRight = nums1[mid1]
                } else {
                    minOfRight = min(nums1[mid1], nums2[mid2])
                }
                
                break
            }
        }
        
        return Double(maxOfLeft + minOfRight) / 2.0
    }
}

// test
let s = Solution()
s.findMedianSortedArrays([], [3])

//: [Next](@next)
