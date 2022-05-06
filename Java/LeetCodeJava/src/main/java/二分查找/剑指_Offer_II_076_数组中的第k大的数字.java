package 二分查找;

public class 剑指_Offer_II_076_数组中的第k大的数字 {
    static class Solution {
        public int findKthLargest(int[] nums, int k) {
            if (nums.length == 0 || k > nums.length) {
                return -1;
            }

            int partitionIndex = partition(nums, 0, nums.length - 1);
            while (partitionIndex + 1 != k) {
                if (partitionIndex + 1 < k) {
                    partitionIndex = partition(nums, partitionIndex + 1, nums.length - 1);
                } else  {
                    partitionIndex = partition(nums, 0, partitionIndex - 1);
                }
            }
            return nums[partitionIndex];
        }

        private int partition(int[] nums, int left, int right) {
            int pivot = nums[right];
            int i = left;
            int index = left;
            for (; i < right; i++) {
                if (nums[i] >= pivot) {
                    swap(nums, i, index);
                    index++;
                }
            }
            swap(nums, index, right);
            return index;
        }

        private void swap(int[] nums, int i, int j) {
            int temp = nums[i];
            nums[i] = nums[j];
            nums[j] = temp;
        }

        public static void main(String[] args) {
            Solution solution = new Solution();
            System.out.println(solution.findKthLargest(new int[]{1, 4, 5 ,6}, 5));
        }
    }
}
