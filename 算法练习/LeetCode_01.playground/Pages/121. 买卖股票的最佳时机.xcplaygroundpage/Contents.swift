//: [Previous](@previous)

import Foundation

/*
 给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。

 你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。

 返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。

  

 示例 1：

 输入：[7,1,5,3,6,4]
 输出：5
 解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
      注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
 示例 2：

 输入：prices = [7,6,4,3,1]
 输出：0
 解释：在这种情况下, 没有交易完成, 所以最大利润为 0。
  

 提示：

 1 <= prices.length <= 105
 0 <= prices[i] <= 104
 
 LeetCode: https://leetcode.cn/problems/best-time-to-buy-and-sell-stock/description/
 */

/// 状态机 DP 解法
/// 定义两个状态：
///   - rest：当前未持有股票时的最大收益
///   - hold：当前持有股票时的最大收益（买入时为负数）
/// 每天状态转移：
///   - rest = max(rest, hold + price)  // 继续空仓 or 今天卖出
///   - hold = max(hold, -price)        // 继续持仓 or 今天买入（只允许一次交易，所以从 0 开始买）
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var rest = 0          // 未持仓状态下的最大利润，初始为 0
        var hold = Int.min    // 持仓状态下的最大利润，初始为负无穷（还未买入）
        for price in prices {
            rest = max(rest, hold + price)  // 卖出获得 hold + price，或继续持空仓
            hold = max(hold, -price)        // 以 price 买入收益为 -price，或继续持仓
        }
        return rest
    }
}

// MARK: - 测试

func runTests() {
    let solution = Solution()
    var passCount = 0
    var failCount = 0

    func assert(_ input: [Int], expected: Int, label: String) {
        let result = solution.maxProfit(input)
        if result == expected {
            print("✅ \(label): maxProfit(\(input)) = \(result)")
            passCount += 1
        } else {
            print("❌ \(label): maxProfit(\(input)) = \(result), 期望 \(expected)")
            failCount += 1
        }
    }

    // 题目示例
    assert([7, 1, 5, 3, 6, 4], expected: 5, label: "示例1 - 第2天买第5天卖")
    assert([7, 6, 4, 3, 1],    expected: 0, label: "示例2 - 价格持续下跌无利润")

    // 边界情况
    assert([5],                 expected: 0, label: "单个元素")
    assert([1, 2],              expected: 1, label: "两个元素升序")
    assert([2, 1],              expected: 0, label: "两个元素降序")
    assert([3, 3, 3],           expected: 0, label: "价格全部相同")

    // 常规情况
    assert([1, 2, 3, 4, 5],    expected: 4, label: "持续上涨")
    assert([5, 4, 3, 2, 1],    expected: 0, label: "持续下跌")
    assert([2, 4, 1, 7],       expected: 6, label: "中间低谷后大涨")
    assert([0, 0, 0, 10000],   expected: 10000, label: "最大利润边界值")

    print("\n共 \(passCount + failCount) 个测试，通过 \(passCount) 个，失败 \(failCount) 个")
}

runTests()

//: [Next](@next)
