//: [Previous](@previous)

import Foundation

/*
 给定两个以 非递减顺序排列 的整数数组 nums1 和 nums2 , 以及一个整数 k 。

 定义一对值 (u,v)，其中第一个元素来自 nums1，第二个元素来自 nums2 。

 请找到和最小的 k 个数对 (u1,v1),  (u2,v2)  ...  (uk,vk) 。

 示例 1:

 输入: nums1 = [1,7,11], nums2 = [2,4,6], k = 3
 输出: [1,2],[1,4],[1,6]
 解释: 返回序列中的前 3 对数：
      [1,2],[1,4],[1,6],[7,2],[7,4],[11,2],[7,6],[11,4],[11,6]
 示例 2:

 输入: nums1 = [1,1,2], nums2 = [1,2,3], k = 2
 输出: [1,1],[1,1]
 解释: 返回序列中的前 2 对数：
      [1,1],[1,1],[1,2],[2,1],[1,2],[2,2],[1,3],[1,3],[2,3]
 提示:

 1 <= nums1.length, nums2.length <= 105
 -109 <= nums1[i], nums2[i] <= 109
 nums1 和 nums2 均为 升序排列
 1 <= k <= 104
 k <= nums1.length * nums2.length
 
 LeetCode: https://leetcode.cn/problems/find-k-pairs-with-smallest-sums/description/
 */

//
//  PriorityQueue.swift
//
//  一个通用、接口简洁的优先级队列实现。
//

/// 通用优先级队列。
///
/// 基于二叉堆（binary heap）实现：底层用一个数组维护堆结构，
/// 出队时总是返回当前优先级最高的元素。优先级由初始化时传入的
/// 排序闭包决定，因此同一份实现既可以当最小堆，也可以当最大堆，
/// 还能表达任意自定义顺序。
///
/// 复杂度：
/// - `enqueue(_:)` / `dequeue()`：O(log n)
/// - `peek` / `count` / `isEmpty`：O(1)
/// - 由序列批量构造：O(n)
///
/// 用法示例：
/// ```swift
/// // 最小堆：每次出队返回最小值
/// var numbers = PriorityQueue<Int>(sort: <)
/// numbers.enqueue(5)
/// numbers.enqueue(1)
/// numbers.enqueue(3)
/// numbers.dequeue()        // 1
///
/// // 自定义优先级：紧急程度高的任务先出队
/// var tasks = PriorityQueue<Task>(sort: { $0.urgency > $1.urgency })
///
/// // 对 Comparable 元素的便捷构造
/// let maxHeap = PriorityQueue<Int>.maxHeap([4, 9, 2])
/// ```
///
/// - Note: `PriorityQueue` 是值类型，复制后两份队列互不影响。
struct PriorityQueue<Element> {

    // MARK: - Stored Properties

    /// 底层堆存储。满足堆性质：每个父节点的优先级都不低于其子节点。
    /// 索引 0 始终是优先级最高的元素。
    private var storage: [Element] = []

    /// 排序规则：`order(a, b)` 返回 `true` 表示 `a` 的优先级高于 `b`
    /// （即 `a` 应该比 `b` 更早出队）。传入 `<` 得到最小堆，传入 `>` 得到最大堆。
    private let order: (Element, Element) -> Bool

    // MARK: - Computed Properties

    /// 队列中的元素个数。
    var count: Int { storage.count }

    /// 队列是否为空。
    var isEmpty: Bool { storage.isEmpty }

    /// 优先级最高的元素；队列为空时返回 `nil`。该操作不会改变队列。
    var peek: Element? { storage.first }

    // MARK: - Initialization

    /// 创建一个空的优先级队列。
    /// - Parameter sort: 排序闭包。给定两个元素，若第一个应更早出队则返回 `true`。
    ///   例如传入 `<` 得到最小堆，传入 `>` 得到最大堆。
    init(sort: @escaping (Element, Element) -> Bool) {
        self.order = sort
    }

    /// 用一组初始元素创建优先级队列。
    /// - Parameters:
    ///   - elements: 初始元素序列。
    ///   - sort: 排序闭包，含义同上。
    /// - Complexity: O(n)，采用自底向上的方式建堆，比逐个 `enqueue` 更快。
    init<S: Sequence>(_ elements: S, sort: @escaping (Element, Element) -> Bool)
        where S.Element == Element {
        self.order = sort
        self.storage = Array(elements)
        // 从最后一个非叶子节点开始，依次向下调整，即可在 O(n) 内完成建堆。
        for index in stride(from: storage.count / 2 - 1, through: 0, by: -1) {
            siftDown(from: index)
        }
    }

    // MARK: - Public Methods

    /// 入队一个元素。
    /// - Parameter element: 待加入的元素。
    /// - Complexity: O(log n)。
    mutating func enqueue(_ element: Element) {
        storage.append(element)
        siftUp(from: storage.count - 1)
    }

    /// 出队并返回优先级最高的元素；队列为空时返回 `nil`。
    /// - Returns: 优先级最高的元素，若队列为空则为 `nil`。
    /// - Complexity: O(log n)。
    @discardableResult
    mutating func dequeue() -> Element? {
        guard !storage.isEmpty else { return nil }
        // 把堆顶与末尾元素交换，移除末尾（即原堆顶），再对新的堆顶向下调整。
        storage.swapAt(0, storage.count - 1)
        let highest = storage.removeLast()
        if !storage.isEmpty {
            siftDown(from: 0)
        }
        return highest
    }

    // MARK: - Heap Index Helpers

    /// 父节点索引。
    private func parentIndex(of index: Int) -> Int { (index - 1) / 2 }

    /// 左子节点索引。
    private func leftChildIndex(of index: Int) -> Int { index * 2 + 1 }

    /// 右子节点索引。
    private func rightChildIndex(of index: Int) -> Int { index * 2 + 2 }

    // MARK: - Heap Adjustment

    /// 向上调整：把 `index` 处的元素不断与父节点比较，只要它的优先级更高
    /// 就与父节点交换并继续上移，直到重新满足堆性质。
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(of: child)
        while child > 0 && order(storage[child], storage[parent]) {
            storage.swapAt(child, parent)
            child = parent
            parent = parentIndex(of: child)
        }
    }

    /// 向下调整：把 `index` 处的元素与其左右子节点中优先级最高者比较，
    /// 只要子节点优先级更高就交换并继续下移，直到重新满足堆性质。
    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(of: parent)
            let right = rightChildIndex(of: parent)
            var candidate = parent

            // 在「父、左子、右子」三者中挑出优先级最高的节点。
            if left < storage.count && order(storage[left], storage[candidate]) {
                candidate = left
            }
            if right < storage.count && order(storage[right], storage[candidate]) {
                candidate = right
            }
            // 父节点已经是三者中优先级最高的，堆性质成立，调整结束。
            if candidate == parent { return }

            storage.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

// MARK: - Comparable Convenience

extension PriorityQueue where Element: Comparable {

    /// 创建一个最小优先队列：最小的元素最先出队。
    /// - Parameter elements: 可选的初始元素序列。
    static func minHeap<S: Sequence>(_ elements: S) -> PriorityQueue where S.Element == Element {
        PriorityQueue(elements, sort: <)
    }

    /// 创建一个空的最小优先队列。
    static func minHeap() -> PriorityQueue {
        PriorityQueue(sort: <)
    }

    /// 创建一个最大优先队列：最大的元素最先出队。
    /// - Parameter elements: 可选的初始元素序列。
    static func maxHeap<S: Sequence>(_ elements: S) -> PriorityQueue where S.Element == Element {
        PriorityQueue(elements, sort: >)
    }

    /// 创建一个空的最大优先队列。
    static func maxHeap() -> PriorityQueue {
        PriorityQueue(sort: >)
    }
}

/// 算法思路（最小堆 + 懒加载扩展）：
///
/// 核心观察：nums1 和 nums2 均已升序排列。
/// 对于 nums1[i]，最优的搭档一定从 nums2[0] 开始，
/// 且每次取出 (nums1[i], nums2[j]) 后，下一个候选是 (nums1[i], nums2[j+1])。
///
/// 步骤：
/// 1. 将所有 (nums1[i], nums2[0], 0) 入堆，共 nums1.count 个初始候选。
///    堆中每个元素存 [nums1值, nums2值, nums2当前索引]，按元素和排最小堆。
/// 2. 循环弹出堆顶（当前和最小的数对），加入结果；
///    同时将同一行的下一列候选 (nums1[i], nums2[j+1]) 入堆，实现懒加载。
/// 3. 重复直到取满 k 对或堆空为止。
///
/// 时间复杂度：O((m + k) log m)，m = nums1.count
/// 空间复杂度：O(m)（堆的大小最多为 m）
class Solution {
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        // 最小堆：按数对之和升序排列
        // 每个元素格式：[nums1值, nums2值, nums2的索引]
        var pq = PriorityQueue<[Int]> { a, b in
            (a[0] + a[1]) < (b[0] + b[1])
        }

        // 初始化：每个 nums1[i] 配上 nums2[0] 作为起始候选
        for i in 0..<nums1.count {
            pq.enqueue([nums1[i], nums2[0], 0])
        }

        var res: [[Int]] = []

        // 取出堆顶（当前最小和数对），并将该行下一列候选入堆
        // 用 res.count < k 控制恰好取 k 对（原代码 k > 0 但未递减，是 bug）
        while !pq.isEmpty && res.count < k {
            guard let cur = pq.dequeue() else {
                break
            }
                        
            let num0 = cur[0]       // 来自 nums1 的值
            let num1 = cur[1]       // 来自 nums2 的值
            let nextJ = cur[2] + 1  // nums2 的下一个索引

            // 将同一个 nums1[i] 与 nums2 下一个元素组成的候选入堆
            if nextJ < nums2.count {
                pq.enqueue([num0, nums2[nextJ], nextJ])
            }

            res.append([num0, num1])
        }
        return res
    }
}

// MARK: - 测试

let solution = Solution()

/// 辅助：将二维数组转成字符串，便于打印
func pairsDesc(_ pairs: [[Int]]) -> String {
    pairs.map { "[\($0[0]),\($0[1])]" }.joined(separator: ", ")
}

/// 辅助：对数对列表按升序规范化，用于不依赖输出顺序的比较
func sortedPairs(_ pairs: [[Int]]) -> [[Int]] {
    pairs.sorted { lhs, rhs in
        lhs[0] != rhs[0] ? lhs[0] < rhs[0] : lhs[1] < rhs[1]
    }
}

/// 辅助：验证结果（对顺序不敏感，只比较排序后是否相等）
func assertEqual(_ result: [[Int]], _ expected: [[Int]], testName: String) {
    let sortedResult   = sortedPairs(result)
    let sortedExpected = sortedPairs(expected)
    if sortedResult == sortedExpected {
        print("✅ \(testName) 通过 → \(pairsDesc(result))")
    } else {
        print("❌ \(testName) 失败")
        print("   期望: \(pairsDesc(sortedExpected))")
        print("   实际: \(pairsDesc(sortedResult))")
    }
}

// 示例 1：基础验证
assertEqual(
    solution.kSmallestPairs([1, 7, 11], [2, 4, 6], 3),
    [[1,2],[1,4],[1,6]],
    testName: "示例1 - 基础用例"
)

// 示例 2：重复元素
assertEqual(
    solution.kSmallestPairs([1, 1, 2], [1, 2, 3], 2),
    [[1,1],[1,1]],
    testName: "示例2 - 重复元素"
)

// 边界：k = 1，只取最小的一对
assertEqual(
    solution.kSmallestPairs([1, 2, 3], [4, 5, 6], 1),
    [[1,4]],
    testName: "边界 - k=1"
)

// 边界：nums2 只有一个元素
assertEqual(
    solution.kSmallestPairs([1, 2, 3], [1], 3),
    [[1,1],[2,1],[3,1]],
    testName: "边界 - nums2 只有一个元素"
)

// 边界：负数元素
// 按和排序：(-5,-2)=-7, (-3,-2)=-5, (-5,1)=-4, (-3,1)=-2
assertEqual(
    solution.kSmallestPairs([-5, -3, 0], [-2, 1, 4], 4),
    [[-5,-2],[-3,-2],[-5,1],[-3,1]],
    testName: "边界 - 含负数"
)

// 边界：k 等于所有数对的总数
assertEqual(
    solution.kSmallestPairs([1, 2], [3, 4], 4),
    [[1,3],[1,4],[2,3],[2,4]],
    testName: "边界 - k 等于总数对数"
)

//: [Next](@next)
