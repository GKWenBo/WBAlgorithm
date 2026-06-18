//: [Previous](@previous)

import Foundation

/*
 给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。

 请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。

 你必须设计并实现时间复杂度为 O(n) 的算法解决此问题。



 示例 1:

 输入: [3,2,1,5,6,4], k = 2
 输出: 5
 示例 2:

 输入: [3,2,3,1,2,4,5,5,6], k = 4
 输出: 4


 提示：

 1 <= k <= nums.length <= 105
 -104 <= nums[i] <= 104

 LeetCode: https://leetcode.cn/problems/kth-largest-element-in-an-array/description/

 算法思路：快速选择（QuickSelect）
 - 第 k 大元素等价于升序排列后索引为 n-k 的元素
 - 每次随机选取 pivot 进行分区，分区后 pivot 落在其最终排序位置
 - 若 pivot 索引恰好等于 target，直接返回；否则只递归目标所在的一侧
 - 平均时间复杂度 O(n)，最坏 O(n²)（随机化 pivot 可极大降低最坏情况概率）
 */

class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var priorityQuue = PriorityQueue<Int>(sort: < )
        
        for num in nums {
            priorityQuue.enqueue(num)
            
            if priorityQuue.count > k {
                priorityQuue.dequeue()
            }
        }
        
        return priorityQuue.peek!
    }
}


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

// MARK: - 测试

let solution = Solution()

// 辅助：断言并打印结果
func assertEqual(_ result: Int, _ expected: Int, _ testName: String) {
    if result == expected {
        print("✅ \(testName): \(result)")
    } else {
        print("❌ \(testName): 期望 \(expected)，实际 \(result)")
    }
}

// 题目示例
assertEqual(solution.findKthLargest([3, 2, 1, 5, 6, 4], 2), 5, "示例1 - 基本用例")
assertEqual(solution.findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4), 4, "示例2 - 含重复元素")

// 边界：单元素数组
assertEqual(solution.findKthLargest([1], 1), 1, "单元素数组")

// 边界：k=1（最大值）
assertEqual(solution.findKthLargest([7, 3, 5, 1, 9], 1), 9, "k=1 取最大值")

// 边界：k=n（最小值）
assertEqual(solution.findKthLargest([7, 3, 5, 1, 9], 5), 1, "k=n 取最小值")

// 全部相同元素
assertEqual(solution.findKthLargest([4, 4, 4, 4], 2), 4, "全相同元素")

// 含负数
assertEqual(solution.findKthLargest([-1, -2, -3, -4, -5], 2), -2, "全负数数组")

// 正负混合
assertEqual(solution.findKthLargest([3, -1, 0, 2, -5], 3), 0, "正负混合")

// 已升序排列
assertEqual(solution.findKthLargest([1, 2, 3, 4, 5], 2), 4, "已升序排列")

// 已降序排列
assertEqual(solution.findKthLargest([5, 4, 3, 2, 1], 3), 3, "已降序排列")

//: [Next](@next)
