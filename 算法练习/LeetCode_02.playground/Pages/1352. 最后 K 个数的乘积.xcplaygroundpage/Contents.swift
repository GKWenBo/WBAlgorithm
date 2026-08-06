//: [Previous](@previous)

import Foundation

/*
 设计一个算法，该算法接受一个整数流并检索该流中最后 k 个整数的乘积。

 实现 ProductOfNumbers 类：

 ProductOfNumbers() 用一个空的流初始化对象。
 void add(int num) 将数字 num 添加到当前数字列表的最后面。
 int getProduct(int k) 返回当前数字列表中，最后 k 个数字的乘积。你可以假设当前列表中始终 至少 包含 k 个数字。
 题目数据保证：任何时候，任一连续数字序列的乘积都在 32 位整数范围内，不会溢出。

  

 示例：

 输入：
 ["ProductOfNumbers","add","add","add","add","add","getProduct","getProduct","getProduct","add","getProduct"]
 [[],[3],[0],[2],[5],[4],[2],[3],[4],[8],[2]]

 输出：
 [null,null,null,null,null,null,20,40,0,null,32]

 解释：
 ProductOfNumbers productOfNumbers = new ProductOfNumbers();
 productOfNumbers.add(3);        // [3]
 productOfNumbers.add(0);        // [3,0]
 productOfNumbers.add(2);        // [3,0,2]
 productOfNumbers.add(5);        // [3,0,2,5]
 productOfNumbers.add(4);        // [3,0,2,5,4]
 productOfNumbers.getProduct(2); // 返回 20 。最后 2 个数字的乘积是 5 * 4 = 20
 productOfNumbers.getProduct(3); // 返回 40 。最后 3 个数字的乘积是 2 * 5 * 4 = 40
 productOfNumbers.getProduct(4); // 返回  0 。最后 4 个数字的乘积是 0 * 2 * 5 * 4 = 0
 productOfNumbers.add(8);        // [3,0,2,5,4,8]
 productOfNumbers.getProduct(2); // 返回 32 。最后 2 个数字的乘积是 4 * 8 = 32
  

 提示：

 0 <= num <= 100
 1 <= k <= 4 * 104
 add 和 getProduct 最多被调用 4 * 104 次。
 在任何时间点流的乘积都在 32 位整数范围内。
  

 进阶：您能否 同时 将 GetProduct 和 Add 的实现改为 O(1) 时间复杂度，而不是 O(k) 时间复杂度？
 
 LeetCode：https://leetcode.cn/problems/product-of-the-last-k-numbers/description/
 */


// MARK: - 解题思路（前缀积 + 遇零重置）
//
// 核心：维护一个前缀积数组 preProdct，preProdct[i] 表示从上次重置后前 i 个数的累积乘积。
// 初始放入哨兵 1（preProdct[0] = 1），方便用除法 O(1) 求区间乘积。
//
// add(num)：
//   - 若 num == 0，则之前所有前缀积对后续查询都无用，直接重置为 [1]。
//   - 否则，在末尾追加 preProdct.last! * num。
//
// getProduct(k)：
//   - 若 k >= n（n = preProdct.count），说明最后 k 个数的范围跨越了某次重置点，
//     即中间存在 0，直接返回 0。
//   - 否则，利用前缀积公式：最后 k 个数的乘积 = preProdct[n-1] / preProdct[n-1-k]
//
// 时间复杂度：add O(1)，getProduct O(1)
// 空间复杂度：O(n)

class ProductOfNumbers {

    // 前缀积数组，下标 0 为哨兵 1
    var preProdct: [Int]

    init() {
        preProdct = [1]
    }

    func add(_ num: Int) {
        if num == 0 {
            // 遇到 0：任何包含该 0 的乘积均为 0，旧前缀积全部失效，重置
            preProdct = [1]
            return
        }
        // 将新数与当前末尾累积乘积相乘并追加
        preProdct.append(preProdct.last! * num)
    }

    func getProduct(_ k: Int) -> Int {
        let n = preProdct.count
        // k >= n 说明范围内含有 0（跨越了重置点），直接返回 0
        if k >= n { return 0 }
        // 前缀积相除得到最后 k 个数的乘积
        return preProdct[n - 1] / preProdct[n - 1 - k]
    }
}

/**
 * Your ProductOfNumbers object will be instantiated and called as such:
 * let obj = ProductOfNumbers()
 * obj.add(num)
 * let ret_2: Int = obj.getProduct(k)
 */

// MARK: - 测试

// 测试用例 1：题目官方示例（含 0）
do {
    let p = ProductOfNumbers()
    p.add(3)
    p.add(0)
    p.add(2)
    p.add(5)
    p.add(4)
    assert(p.getProduct(2) == 20, "❌ getProduct(2) 期望 20，实际 \(p.getProduct(2))")
    assert(p.getProduct(3) == 40, "❌ getProduct(3) 期望 40，实际 \(p.getProduct(3))")
    assert(p.getProduct(4) == 0,  "❌ getProduct(4) 期望 0（含 0），实际 \(p.getProduct(4))")
    p.add(8)
    assert(p.getProduct(2) == 32, "❌ getProduct(2) 期望 32，实际 \(p.getProduct(2))")
    print("测试 1 通过：官方示例 ✅")
}

// 测试用例 2：末尾 k 个数中恰好含 0
do {
    let p = ProductOfNumbers()
    p.add(0)
    p.add(0)
    p.add(5)
    assert(p.getProduct(1) == 5, "❌ getProduct(1) 期望 5，实际 \(p.getProduct(1))")
    assert(p.getProduct(2) == 0, "❌ getProduct(2) 期望 0（含 0），实际 \(p.getProduct(2))")
    print("测试 2 通过：末尾含 0 ✅")
}

// 测试用例 3：全程无 0
do {
    let p = ProductOfNumbers()
    p.add(2)
    p.add(3)
    p.add(4)
    assert(p.getProduct(1) == 4,  "❌ getProduct(1) 期望 4，实际 \(p.getProduct(1))")
    assert(p.getProduct(2) == 12, "❌ getProduct(2) 期望 12，实际 \(p.getProduct(2))")
    assert(p.getProduct(3) == 24, "❌ getProduct(3) 期望 24，实际 \(p.getProduct(3))")
    print("测试 3 通过：无 0 场景 ✅")
}

// 测试用例 4：add 0 后立即查询
do {
    let p = ProductOfNumbers()
    p.add(6)
    p.add(0)
    p.add(7)
    assert(p.getProduct(1) == 7, "❌ getProduct(1) 期望 7，实际 \(p.getProduct(1))")
    assert(p.getProduct(2) == 0, "❌ getProduct(2) 期望 0（含 0），实际 \(p.getProduct(2))")
    print("测试 4 通过：add 0 后立即查询 ✅")
}

print("全部测试通过 🎉")

//: [Next](@next)
