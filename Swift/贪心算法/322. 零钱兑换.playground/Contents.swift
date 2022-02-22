import UIKit
/*
 给你一个整数数组 coins ，表示不同面额的硬币；以及一个整数 amount ，表示总金额。

 计算并返回可以凑成总金额所需的 最少的硬币个数 。如果没有任何一种硬币组合能组成总金额，返回 -1 。

 你可以认为每种硬币的数量是无限的。

 示例 1：
 输入：coins = [1, 2, 5], amount = 11
 输出：3
 解释：11 = 5 + 5 + 1
 
 示例 2：
 输入：coins = [2], amount = 3
 输出：-1
 
 示例 3：
 输入：coins = [1], amount = 0
 输出：0

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/coin-change
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        var dp = [Int](repeating: 0, count: amount + 1)
        
        if amount == 0 {
            return 0
        }
        
        for i in 1...amount {
            var cases: [Int] = []
            for coin in coins {
                if (i - coin) >= 0 && dp[i - coin] != -1 {
                    cases.append(dp[i - coin] + 1)
                }
            }
            
            dp[i] = cases.isEmpty ? -1 : cases.min()!
        }
        return dp[amount]
    }
}


// test
let s = Solution()
let res = s.coinChange([1, 2, 5], 11)
