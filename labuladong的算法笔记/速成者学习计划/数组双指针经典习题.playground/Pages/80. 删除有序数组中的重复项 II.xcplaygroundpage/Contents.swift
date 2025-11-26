//: [Previous](@previous)

import Foundation

/*
 给你一个有序数组 nums ，请你 原地 删除重复出现的元素，使得出现次数超过两次的元素只出现两次 ，返回删除后数组的新长度。

 不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。

  

 说明：

 为什么返回数值是整数，但输出的答案是数组呢？

 请注意，输入数组是以「引用」方式传递的，这意味着在函数里修改输入数组对于调用者是可见的。

 你可以想象内部操作如下:

 // nums 是以“引用”方式传递的。也就是说，不对实参做任何拷贝
 int len = removeDuplicates(nums);

 // 在函数里修改输入数组对于调用者是可见的。
 // 根据你的函数返回的长度, 它会打印出数组中 该长度范围内 的所有元素。
 for (int i = 0; i < len; i++) {
     print(nums[i]);
 }
  

 示例 1：

 输入：nums = [1,1,1,2,2,3]
 输出：5, nums = [1,1,2,2,3]
 解释：函数应返回新长度 length = 5, 并且原数组的前五个元素被修改为 1, 1, 2, 2, 3。 不需要考虑数组中超出新长度后面的元素。
 示例 2：

 输入：nums = [0,0,1,1,1,1,2,3,3]
 输出：7, nums = [0,0,1,1,2,3,3]
 解释：函数应返回新长度 length = 7, 并且原数组的前七个元素被修改为 0, 0, 1, 1, 2, 3, 3。不需要考虑数组中超出新长度后面的元素。
  

 提示：

 1 <= nums.length <= 3 * 104
 -104 <= nums[i] <= 104
 nums 已按升序排列
 
 LeetCode：https://leetcode.cn/problems/remove-duplicates-from-sorted-array-ii/description/
 */

class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard !nums.isEmpty else {
            return 0
        }
        /// 快慢指针，维护 nums[0..slow] 为结果子数组
        var fast = 0
        var slow = 0
        var count = 0
        while fast < nums.count {
            if nums[slow] != nums[fast] {
                /// 此时，对于 nums[0..slow] 来说，nums[fast] 是一个新的元素，加进来
                slow += 1
                nums[slow] = nums[fast]
            } else if slow < fast && count < 2 {
                /// 此时，对于 nums[0..slow] 来说，nums[fast] 重复次数小于 2，也加进来
                slow += 1
                nums[slow] = nums[fast]
            }
            
            fast += 1
            count += 1
            
            if fast < nums.count && nums[fast] != nums[fast - 1] { /// // fast 遇到新的不同的元素时，重置 count
                count = 0
            }
        }
        return slow + 1
    }
}

var nums = [1,1,1,2,2,3]
Solution().removeDuplicates(&nums)
print(nums)

//: [Next](@next)
