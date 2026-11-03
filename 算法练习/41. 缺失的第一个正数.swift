//
//  41. 缺失的第一个正数 (First Missing Positive)
//
//  算法思想（一句话）：
//  把数组本身当作哈希表 —— 先把所有「不可能成为答案」的数（<= 0 或 > n）改写成哨兵 n + 1，
//  再用「下标 x - 1 上的负号」标记数字 x 出现过，最后第一个仍为正数的下标 i 就对应答案 i + 1。
//
//  时间复杂度：O(n)
//    - 第 1、2、3 步各线性扫描一次，共 3n 次常数操作；每个位置只被访问常数次，
//      不存在嵌套循环（不同于「交换归位」写法的 while，那种需要均摊分析才能得出 O(n)）。
//  空间复杂度：O(1)
//    - 只用 n、x、i 等常数个变量；所有标记都写在入参数组的副本上，
//      没有 Set / 计数数组等随 n 增长的辅助结构（入参数组副本按 LeetCode 惯例不计入额外空间）。
//
//  易错点：
//  1. 第 1 步的归一化不能省：否则第 2 步 abs(nums[i]) 可能 > n 而越界，负数或 0 也会污染结果；
//  2. 第 2 步必须取 abs：同一个下标可能被不同数字重复标记，读到的可能已经是负数；
//  3. 用「负号」而不是「另开一个 bool 数组」做标记，正是把 O(n) 空间压到 O(1) 的关键。
//

import Playgrounds

#Playground {
    /*
     给你一个未排序的整数数组 nums ，请你找出其中没有出现的最小的正整数。

     请你实现时间复杂度为 O(n) 并且只使用常数级别额外空间的解决方案。
      

     示例 1：

     输入：nums = [1,2,0]
     输出：3
     解释：范围 [1,2] 中的数字都在数组中。
     示例 2：

     输入：nums = [3,4,-1,1]
     输出：2
     解释：1 在数组中，但 2 没有。
     示例 3：

     输入：nums = [7,8,9,11,12]
     输出：1
     解释：最小的正数 1 没有出现。
      

     提示：

     1 <= nums.length <= 105
     -231 <= nums[i] <= 231 - 1
     
     LeetCode: https://leetcode.cn/problems/first-missing-positive/description/
     */
    
    class Solution {
        
        func firstMissingPositive(_ nums: [Int]) -> Int {
            // 值语义复制：下面的「原地标记」不会改动调用方的数组
            var nums = nums
            
            let n = nums.count
            
            // 第 1 步：n 个数能覆盖的正整数最多是 1...n，所以答案一定落在 1...n+1 内。
            // 把 <= 0 或 > n 的数统一改写成哨兵 n + 1：
            //   - 它们不可能成为答案，也不会被第 2 步当作下标使用；
            //   - 归一化后数组里的数全为正且 <= n+1，abs 不会溢出、下标不会越界。
            for i in 0..<n where nums[i] <= 0 || nums[i] > n {
                nums[i] = n + 1
            }
            
            // 第 2 步：用符号做「出现标记」——数字 x 出现过，就把下标 x-1 位置标成负数。
            // 必须取 abs：该位置可能已经被别的数字标记过一次（已是负数）。
            for i in 0..<n {
                let x = abs(nums[i])
                if x <= n {
                    nums[x - 1] = -abs(nums[x - 1])
                }
            }
            
            // 第 3 步：第一个没有被标成负数的下标 i，说明数字 i + 1 从未出现过
            for i in 0..<n where nums[i] > 0 {
                return i + 1
            }
            
            // 1...n 全都出现过（或数组为空时 n = 0），答案是 n + 1
            return n + 1
        }
    }
    
    // MARK: - 参考解（暴力对拍用，不参与主逻辑）
    
    /// 按定义暴力找：从 1 开始逐个问「在不在集合里」。
    /// 时间 O(n)，空间 O(n) —— 只用来验证上面的 O(1) 空间解法。
    func bruteForce(_ nums: [Int]) -> Int {
        let set = Set(nums)
        var x = 1
        // n 个数最多覆盖 1...n，答案必为 n+1，因此循环次数不会超过 n+1，不会溢出
        while set.contains(x) { x += 1 }
        return x
    }
    
    // MARK: - 测试工具
    
    var passed = 0
    var failed = 0
    
    /// 控制台输出用的截断展示，避免大规模用例刷屏
    func preview(_ nums: [Int], limit: Int = 8) -> String {
        nums.count <= limit ? "\(nums)" : "\(Array(nums.prefix(limit)))…(共 \(nums.count) 个)"
    }
    
    func report(_ input: [Int], got: Int, expected: Int, label: String, verbose: Bool = true) {
        if got == expected {
            passed += 1
            if verbose { print("✅ \(label)  nums = \(preview(input))  ->  \(got)") }
        } else {
            failed += 1
            print("❌ \(label)  nums = \(preview(input))")
            print("   输出 = \(got)，期望 = \(expected)")
        }
    }
    
    /// 固定用例：期望值由人工给出，同时用暴力解反查「期望值本身有没有写错」
    func check(_ input: [Int], _ expected: Int, _ label: String, verbose: Bool = true) {
        let truth = bruteForce(input)
        if truth != expected {
            print("⚠️ 用例有误：\(label) 手写期望 \(expected)，暴力解为 \(truth)")
        }
        report(input, got: Solution().firstMissingPositive(input), expected: expected, label: label, verbose: verbose)
    }
    
    /// 随机用例：期望值完全交给暴力解
    func checkRandom(_ input: [Int], _ label: String) {
        report(input, got: Solution().firstMissingPositive(input), expected: bruteForce(input), label: label, verbose: false)
    }
    
    /// 固定种子的线性同余随机数：不依赖 Foundation，每次运行完全一致，失败可复现
    struct LCG {
        private var state: UInt64
        
        init(seed: UInt64) { state = seed }
        
        mutating func next() -> UInt64 {
            state = state &* 6_364_136_223_846_793_005 &+ 1_442_695_040_888_963_407
            return state
        }
        
        mutating func int(in range: ClosedRange<Int>) -> Int {
            range.lowerBound + Int(next() % UInt64(range.count))
        }
        
        /// 自己实现洗牌，保持随机序列可复现（系统 shuffle 不可复现）
        mutating func shuffle(_ a: inout [Int]) {
            guard a.count > 1 else { return }
            for i in stride(from: a.count - 1, through: 1, by: -1) {
                a.swapAt(i, int(in: 0...i))
            }
        }
    }
    
    // MARK: - 1. 官方示例与边界用例
    
    print("=== 1. 官方示例与边界用例 ===")
    
    check([1, 2, 0], 3, "示例 1")
    check([3, 4, -1, 1], 2, "示例 2")
    check([7, 8, 9, 11, 12], 1, "示例 3")
    
    check([], 1, "空数组（约定外，最小缺失正数应为 1）")
    check([1], 2, "单元素 [1] → 2")
    check([2], 1, "单元素 [2] → 1")
    check([0], 1, "只有 0")
    check([-1], 1, "只有负数")
    check([1, 1], 2, "重复的 1")
    check([2, 2, 2], 1, "重复的 2")
    check([2, 1], 3, "两元素乱序")
    
    check([1, 2, 3], 4, "1...n 连续 → n+1")
    check([3, 2, 1], 4, "1...n 乱序 → n+1")
    check([4, 5, 6], 1, "全部大于 n")
    check([-1, -2, -3], 1, "全部为负")
    check([100000, 1, 2, 3], 4, "大于 n 的大数不干扰结果")
    check([Int.min, Int.max], 1, "极值 Int.min / Int.max 不崩溃")
    check([Int.max, Int.min, 1, 2], 3, "极值 + 1、2")
    check([Int.min, -1, 1, 2, 3], 4, "Int.min 不能被当成下标")
    
    // MARK: - 2. 随机对拍（与暴力解逐一比对）
    
    print("\n=== 2. 随机对拍（800 组随机数组）===")
    
    var rng = LCG(seed: 0x5EED_0041)
    let randomFailBase = failed
    for _ in 0..<800 {
        let count = rng.int(in: 0...30)
        let lo = rng.int(in: -20...0)      // 保证 lo <= 0 <= hi，区间合法
        let hi = rng.int(in: 1...40)
        let input = (0..<count).map { _ in rng.int(in: lo...hi) }
        checkRandom(input, "随机数组")
    }
    if failed == randomFailBase { print("✅ 800 组随机数组全部通过（含负数、0、重复、超 n 的大数）") }
    
    print("\n=== 3. 随机对拍（1...n 的排列 / 挖空一个数）===")
    
    let permFailBase = failed
    for _ in 0..<200 {
        let count = rng.int(in: 1...20)
        var arr = Array(1...count)
        rng.shuffle(&arr)
        checkRandom(arr, "1...n 的排列，答案应为 n+1")
    }
    for _ in 0..<200 {
        let count = rng.int(in: 2...20)
        var arr = Array(1...count)
        let removed = rng.int(in: 1...count)
        arr.removeAll { $0 == removed }
        checkRandom(arr, "1...n 挖掉 \(removed)，答案应为 \(removed)")
    }
    if failed == permFailBase { print("✅ 400 组排列/挖空用例全部通过") }
    
    // MARK: - 4. 大规模用例（n = 10^5，验证不会退化）
    
    print("\n=== 4. 大规模用例（n = 100000）===")
    
    let big = 100_000
    
    check(Array(1...big), big + 1, "1...100000 顺序")
    check(Array((1...big).reversed()), big + 1, "1...100000 逆序")
    check(Array(repeating: 0, count: big), 1, "全 0")
    check(Array(repeating: 7, count: big), 1, "全 7（重复值）")
    check(Array(1..<big), big, "1...99999，缺 100000")
    check(Array(-big...0), 1, "负区间到 0，无正整数")
    check(Array(-(big / 2)...(big / 2)), big / 2 + 1, "跨 0 的连续区间")
    
    // 计时：n = 10^5 应远小于 1 秒；若退化成 O(n log n) 或 O(n²) 会明显暴露
    let clock = ContinuousClock()
    let elapsed = clock.measure {
        _ = Solution().firstMissingPositive(Array((1...big).reversed()))
    }
    print("⏱️ 单次 n = 100000 用时：\(elapsed)")
    
    // MARK: - 汇总
    
    print("\n=== 结果：\(passed) 通过，\(failed) 失败 ===")
    print(failed == 0 ? "✅ 全部用例通过，算法正确" : "❌ 存在失败用例，算法有误")
}
