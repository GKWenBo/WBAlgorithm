package 队列;

import java.util.stream.Stream;

public class 滑动窗口最大值 {

    // 求滑动窗口最大值
    public static int[] maxSlidingWindow(int k, int[] nums) {
        int n = nums.length;
        int sum = 0;
        int[] ans = new int[n - k + 1];
        for (int i = 0; i < n; i++) {
            sum += nums[i];
            if (i < k - 1) {
                continue;
            }
            if (i == k - 1) {
                ans[0] = sum;
            } else {
                sum -= nums[i - k];
                ans[i - k + 1] = sum;
            }
        }
        return ans;
    }

    public static void main(String[] args) {
        int[] ints = maxSlidingWindow(3, new int[]{1, 2, 3, 4, 5, 6, 7});

        for (int anInt : ints) {
            System.out.println(anInt);
        }
    }

}
