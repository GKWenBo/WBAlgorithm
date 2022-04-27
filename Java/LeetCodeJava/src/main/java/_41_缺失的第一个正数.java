import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

/**
 * https://leetcode-cn.com/problems/first-missing-positive/
 */
public class _41_缺失的第一个正数 {
    class Solution {
        /**
         * 将数组视为哈希表
         * @param nums
         * @return
         */
        public int firstMissingPositive(int[] nums) {
            int len = nums.length;
            for (int i = 0; i < len; i++) {
                while (nums[i] > 0 && nums[i] <= len && nums[nums[i] - 1] != nums[i]) {
                    /// 将正整数交换到合适的位置
                    swap(nums, nums[i] - 1, i);
                }
            }

            for (int i = 0; i < len; i++) {
                if (nums[i] != i + 1) {
                    return i + 1;
                }
            }
            return len + 1;
        }

        /**
         * 交换数组元素
         * @param nums
         * @param index1
         * @param index2
         */
        private void swap(int[] nums, int index1, int index2) {
            int temp = nums[index1];
            nums[index1] = nums[index2];
            nums[index2] = temp;
        }

        /**
         * 哈希表
         * @param nums
         * @return
         */
        public int firstMissingPositive1(int[] nums) {
            int len = nums.length;

            // 添加到哈希表
            HashSet<Integer> set = new HashSet<>();
            for (int i = 0; i < len; i++) {
                set.add(nums[i]);
            }

            // 遍历哈希表，第一个包含元素为所找正数
            for (int i = 1; i <= len; i++) {
                if (!set.contains(i)) {
                    return i;
                }
            }
            return len + 1;
        }

        /**
         * 二分查找法
         * @param nums
         * @return
         */
        public int firstMissingPositive2(int[] nums) {
            int len = nums.length;
            // 排序数组
            Arrays.sort(nums);

            for (int i = 1; i <= len; i++) {
                // 二分查找
                int res = binarySearch(nums, i);
                if (res == -1) {
                    return i;
                }
            }
            return len + 1;
        }

        private int binarySearch(int[] nums, int target) {
            int left = 0;
            int right = nums.length - 1;
            while (left <= right) {
                int mid = (left + right) >>> 1;
                if (nums[mid] == target) {
                    return mid;
                } else if (nums[mid] < target) {
                    left = mid + 1;
                } else  {
                    right = mid - 1;
                }
            }
            return -1;
        }

    }
}
