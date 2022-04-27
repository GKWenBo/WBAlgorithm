package 数组;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * https://leetcode-cn.com/problems/majority-element/
 */
public class _169_多数元素 {
    class Solution {
        public int majorityElement(int[] nums) {
            Map<Integer, Integer> numsMap = numsMap(nums);
            Map.Entry<Integer, Integer> majorityEntry = null;
            for (Map.Entry<Integer, Integer> entry:numsMap.entrySet()
                 ) {
                if (majorityEntry == null || entry.getValue() > majorityEntry.getValue()) {
                    majorityEntry = entry;
                }
            }
            return majorityEntry.getKey();
        }

        /**
         * 排序解法
         * @param nums
         * @return
         */
        public int majorityElement1(int[] nums) {
            Arrays.sort(nums);
            return nums[nums.length / 2];
        }

        /**
         * 投票法
         * @param nums
         * @return
         */
        public int majorityElement2(int[] nums) {
            int count = 0;
            Integer candidate = null;
            for (int num:nums
                 ) {
                if (count == 0) {
                    candidate = num;
                }
                count += (candidate == num) ? 1 : -1;
            }
            return candidate;
        }

        /**
         * 哈希表解法
         * @param nums
         * @return
         */
        private Map<Integer, Integer> numsMap(int[] nums) {
            Map<Integer, Integer> map = new HashMap<>();
            for (int num: nums
                 ) {
                if (map.containsKey(num)) {
                    map.put(num, map.get(num) + 1);
                } else {
                    map.put(num, 1);
                }
            }
            return map;
        }
    }
}
