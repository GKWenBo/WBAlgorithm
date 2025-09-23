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
 
 LeetCode：https://leetcode.cn/problems/find-k-pairs-with-smallest-sums/description/
 */

struct PriorityQueue<Element> {
    private var elements: [Element] = []
    private let priorityFunction: (Element, Element) -> Bool
    
    // 初始化时传入一个比较闭包。对于最小堆，当第一个元素应具有更高优先级（即更小）时返回 true。
    init(priorityFunction: @escaping (Element, Element) -> Bool) {
        self.priorityFunction = priorityFunction
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
    mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        if elements.count == 1 {
            return elements.removeLast()
        } else {
            let value = elements[0]
            elements[0] = elements.removeLast()
            siftDown(from: 0)
            return value
        }
    }
    
    private mutating func siftUp(from index: Int) {
        var childIndex = index
        let child = elements[childIndex]
        var parentIndex = (childIndex - 1) / 2
        
        while childIndex > 0 && priorityFunction(child, elements[parentIndex]) {
            elements[childIndex] = elements[parentIndex]
            childIndex = parentIndex
            parentIndex = (childIndex - 1) / 2
        }
        
        elements[childIndex] = child
    }
    
    private mutating func siftDown(from index: Int) {
        let parentIndex = index
        let leftChildIndex = 2 * parentIndex + 1
        let rightChildIndex = 2 * parentIndex + 2
        
        var first = parentIndex
        if leftChildIndex < elements.count && priorityFunction(elements[leftChildIndex], elements[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < elements.count && priorityFunction(elements[rightChildIndex], elements[first]) {
            first = rightChildIndex
        }
        if first == parentIndex { return }
        
        elements.swapAt(parentIndex, first)
        siftDown(from: first)
    }
}

class Solution {
    /// 时间复杂度：O(klogk)
    /// 空间复杂度：O(k)
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        var pq: PriorityQueue<[Int]> = PriorityQueue { a, b in
            return (a[0] + a[1]) < (b[0] + b[1])
        }
        
        /// 初始化队列：将 nums1 中每个元素与 nums2 的第一个元素组合成三元组 [num1, num2[0], index_in_nums2] 入队
        for i in 0..<nums1.count {
            if !nums2.isEmpty { /// 确保num2不为空
                pq.enqueue([nums1[i], nums2[0], 0])
            }
        }
        
        var res: [[Int]] = []
        var k = k
        /// // 执行 k 次出队操作，或直到队列为空
        while !pq.isEmpty && k > 0 {
            guard let cur = pq.dequeue() else { break }
            
            k -= 1
            
            let num1Value = cur[0]
            let num2Value = cur[1]
            /// // 获取当前数对在 nums2 中的下一个索引
            let num2NextIndex = cur[2] + 1
            /// // 如果 nums2 中还有下一个元素，则生成新数对 [num1Val, nums2[nextIndexInNums2]] 并入队
            if num2NextIndex < nums2.count {
                pq.enqueue([num1Value, nums2[num2NextIndex], num2NextIndex])
            }
            /// // 将当前数对加入结果列表
            res.append([num1Value, num2Value])
        }
        return res
    }
}
