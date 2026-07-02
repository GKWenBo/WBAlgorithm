//: [Previous](@previous)

import Foundation

/*
 给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。

 在每一天，你可以决定是否购买和/或出售股票。你在任何时候 最多 只能持有 一股 股票。然而，你可以在 同一天 多次买卖该股票，但要确保你持有的股票不超过一股。

 返回 你能获得的 最大 利润 。

  

 示例 1：

 输入：prices = [7,1,5,3,6,4]
 输出：7
 解释：在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5 - 1 = 4。
 随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6 - 3 = 3。
 最大总利润为 4 + 3 = 7 。
 示例 2：

 输入：prices = [1,2,3,4,5]
 输出：4
 解释：在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5 - 1 = 4。
 最大总利润为 4 。
 示例 3：

 输入：prices = [7,6,4,3,1]
 输出：0
 解释：在这种情况下, 交易无法获得正利润，所以不参与交易可以获得最大利润，最大利润为 0。
  

 提示：

 1 <= prices.length <= 3 * 104
 0 <= prices[i] <= 104
 
 LeetCode: https://leetcode.cn/problems/best-time-to-buy-and-sell-stock-ii/description/
 */

// MARK: - 解法：贪心 / 动态规划（状态机）
//
// 定义两个状态：
//   rest：当天结束时「不持股」的最大利润
//   hold：当天结束时「持股」的最大利润（初始化为 Int.min 表示尚未买入）
//
// 状态转移（每天遍历价格 price）：
//   rest = max(rest, hold + price)   // 继续空仓 OR 今天卖出
//   hold = max(hold, rest - price)   // 继续持股 OR 今天买入（用 temp 保存上一轮 rest，防止同天买卖影响结果）
//
// 时间复杂度 O(n)，空间复杂度 O(1)
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var rest = 0        // 不持股状态的最大利润
        var hold = Int.min  // 持股状态的最大利润
        for price in prices {
            let temp = rest                  // 保存上一天「不持股」利润，避免同天买卖
            rest = max(rest, hold + price)   // 今天卖出 vs 继续空仓
            hold = max(hold, temp - price)   // 今天买入 vs 继续持股
        }
        return rest
    }
}

// MARK: - 测试

// 辅助函数：断言并打印结果
func check(_ prices: [Int], expected: Int, label: String) {
    let result = Solution().maxProfit(prices)
    let pass = result == expected
    print("\(pass ? "✅" : "❌") \(label): maxProfit(\(prices)) = \(result)，期望 \(expected)")
    assert(pass, "\(label) 失败：期望 \(expected)，实际 \(result)")
}

// 题目示例
check([7, 1, 5, 3, 6, 4], expected: 7,  label: "示例1 多次交易")
check([1, 2, 3, 4, 5],    expected: 4,  label: "示例2 持续上涨")
check([7, 6, 4, 3, 1],    expected: 0,  label: "示例3 持续下跌")

// 边界 & 特殊情况
check([5],                 expected: 0,  label: "单天无法交易")
check([1, 2],              expected: 1,  label: "两天上涨")
check([2, 1],              expected: 0,  label: "两天下跌")
check([1, 2, 1, 2, 1, 2], expected: 3,  label: "波动行情多次小额获利")
check([0, 0, 0],           expected: 0,  label: "全零价格")
check([3, 3, 3, 3],        expected: 0,  label: "价格不变")

print("所有测试通过 🎉")

//: [Next](@next)
