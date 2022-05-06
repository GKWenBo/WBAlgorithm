package 二分查找;

/**
 * https://leetcode-cn.com/problems/sqrtx/
 */
public class _69_x_的平方根 {
    static class Solution {
        public int mySqrt(int x) {
            int l = 0, r = x, ans = -1;
            while (l <= r) {
                int mid = l + ((r - l) >> 1);
                if ((long)mid * mid <= x) {
                    ans = mid;
                    l = mid + 1;
                } else  {
                    r = mid - 1;
                }
            }
            return ans;
        }

        public static void main(String[] args) {
            Solution solution = new Solution();
            System.out.println(solution.mySqrt(64));
        }

    }
}
