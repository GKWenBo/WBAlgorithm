package 递归;

/**
 * https://leetcode-cn.com/problems/climbing-stairs/
 */
public class _70_爬楼梯 {
    static class Solution {

        // 解法1
         public int climbStairs(int n) {
            int p = 0, q = 0, r = 1;
            for (int i = 1; i <= n; i++) {
                p = q;
                q = r;
                r  = p + q;
            }
            return r;
        }

        // 解法2
        public int climbStairs1(int n) {
            int[] dp = new int[n + 1];
            dp[0] = 1;
            dp[1] = 1;
            for (int i = 2; i <= n; i++) {
                dp[i] = dp[i - 1] + dp[i - 2];
            }
            return dp[n];
        }

        // 通项公式
        public int climbStairs2(int n) {
             double sqrt5 = Math.sqrt(5);
             double fibn = Math.pow((1 + sqrt5) / 2, n + 1) - Math.pow((1 - sqrt5) / 2, n + 1);
             return (int)Math.round(fibn / sqrt5);
        }

        public static void main(String[] args) {
            Solution s = new Solution();
            int res =  s.climbStairs2(4);
            System.out.println(res);
        }
    }
}
