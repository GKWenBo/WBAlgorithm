package 二分查找;

/**
 * https://leetcode-cn.com/problems/binary-search/
 */
public class _704_二分查找 {
    class Solution {
        public int search(int[] nums, int target) {
            if (nums.length == 0) {
                return -1;
            }
            int l = 0, r = nums.length;
            while (l <= r) {
                int mid = l + ((r - l) >> 1);
                if (nums[mid] == target) {
                    return mid;
                } else if (nums[mid] < target) {
                    l = mid + 1;
                } else  {
                    r = mid - 1;
                }
            }
            return -1;
        }
    }
}
