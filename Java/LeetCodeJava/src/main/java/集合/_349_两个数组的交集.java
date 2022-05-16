package 集合;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/*
https://leetcode.cn/problems/intersection-of-two-arrays/
 */
public class _349_两个数组的交集 {
    class Solution {
        public int[] intersection(int[] nums1, int[] nums2) {
            if (!(nums1.length > 0 && nums2.length > 0)) {
                return new int[1];
            }

            Set<Integer> set1 = new HashSet();
            Set<Integer> set2 = new HashSet();

            for (int i = 0; i < nums1.length; i++) {
                set1.add(nums1[i]);
            }

            for (int i = 0; i < nums2.length; i++) {
                if (set1.contains(nums2[i])) {
                    set2.add(nums2[i]);
                }
            }

            int[] result = new int[set2.size()];
            int index = 0;
            for (int num : set2) {
                result[index++] = num;
            }
            return result;
        }

        public int[] intersection1(int[] nums1, int[] nums2) {
            if (!(nums1.length > 0 && nums2.length > 0)) {
                return new int[1];
            }

            Arrays.sort(nums1);
            Arrays.sort(nums2);

            int length1 = nums1.length;
            int length2 = nums2.length;

            int index1= 0, index2 = 0, index = 0;
            int[] result = new int[length1 + length2];

            while (index1 < length1 && index2 < length2) {
                int num1 = nums1[index1];
                int num2 = nums2[index2];
                if (num1 == num2) {
                    // 过滤重复数据
                    if (index == 0 || num1 != result[index - 1] ) {
                        result[index++] = num1;
                    }
                    index1++;
                    index2++;
                } else if (num1 < num2) {
                    index1++;
                } else {
                    index2++;
                }
            }
            return Arrays.copyOfRange(result,0, index);
        }
    }
}
