//: [Previous](@previous)

import Foundation

/*
 给你一个长度为 n 的链表，每个节点包含一个额外增加的随机指针 random ，该指针可以指向链表中的任何节点或空节点。
 
 构造这个链表的 深拷贝。 深拷贝应该正好由 n 个 全新 节点组成，其中每个新节点的值都设为其对应的原节点的值。新节点的 next 指针和 random 指针也都应指向复制链表中的新节点，并使原链表和复制链表中的这些指针能够表示相同的链表状态。复制链表中的指针都不应指向原链表中的节点 。
 
 例如，如果原链表中有 X 和 Y 两个节点，其中 X.random --> Y 。那么在复制链表中对应的两个节点 x 和 y ，同样有 x.random --> y 。
 
 返回复制链表的头节点。
 
 用一个由 n 个节点组成的链表来表示输入/输出中的链表。每个节点用一个 [val, random_index] 表示：
 
 val：一个表示 Node.val 的整数。
 random_index：随机指针指向的节点索引（范围从 0 到 n-1）；如果不指向任何节点，则为  null 。
 你的代码 只 接受原链表的头节点 head 作为传入参数。
 
 
 
 示例 1：
 
 
 
 输入：head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
 输出：[[7,null],[13,0],[11,4],[10,2],[1,0]]
 示例 2：
 
 
 
 输入：head = [[1,1],[2,1]]
 输出：[[1,1],[2,1]]
 示例 3：
 
 
 
 输入：head = [[3,null],[3,0],[3,null]]
 输出：[[3,null],[3,0],[3,null]]
 
 
 提示：
 
 0 <= n <= 1000
 -104 <= Node.val <= 104
 Node.random 为 null 或指向链表中的节点。
 
 LeetCode: https://leetcode.cn/problems/copy-list-with-random-pointer/description/
 */

public class Node {
    public var val: Int
    public var next: Node?
    public var random: Node?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
        self.random = nil
    }
}

extension Node: Hashable {
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs === rhs
    }
    
    public func hash(into hasher: inout Hasher) {
        // 按引用地址哈希，避免递归调用自身
        hasher.combine(ObjectIdentifier(self))
    }
}

class Solution {
    /// 哈希表法：时间 O(n)，空间 O(n)
    /// 思路：两次遍历
    ///   第一次：为每个原节点创建对应的新节点，存入哈希表 map[原节点] = 新节点
    ///   第二次：利用哈希表为新节点设置 next 和 random 指针
    func copyRandomList(_ head: Node?) -> Node? {
        guard let head else { return nil }

        // 第一次遍历：创建所有新节点
        var map: [Node: Node] = [:]
        var cur: Node? = head
        while let c = cur {
            map[c] = Node(c.val)
            cur = c.next
        }

        // 第二次遍历：建立新链表的 next 和 random 连接
        cur = head
        while let c = cur {
            if let next = c.next {
                map[c]?.next = map[next]
            }
            if let random = c.random {
                map[c]?.random = map[random]
            }
            cur = c.next
        }
        return map[head]
    }
}

// MARK: - 测试辅助

/// 根据 [(val, randomIndex?)] 构建随机链表，返回头节点
/// randomIndex 为 nil 表示该节点的 random 指针为空
func buildList(_ data: [(Int, Int?)]) -> Node? {
    guard !data.isEmpty else { return nil }
    let nodes = data.map { Node($0.0) }
    for i in 0 ..< nodes.count {
        nodes[i].next = i + 1 < nodes.count ? nodes[i + 1] : nil
        if let ri = data[i].1 {
            nodes[i].random = nodes[ri]
        }
    }
    return nodes[0]
}

/// 将随机链表序列化为 [(val, randomIndex?)]，用于断言比较
func serialize(_ head: Node?) -> [(Int, Int?)] {
    var nodes: [Node] = []
    var cur = head
    while let c = cur { nodes.append(c); cur = c.next }
    // 建立节点 → 下标的映射，用于还原 random 的索引位置
    var indexMap: [ObjectIdentifier: Int] = [:]
    for (i, node) in nodes.enumerated() {
        indexMap[ObjectIdentifier(node)] = i
    }
    return nodes.map { node in
        (node.val, node.random.flatMap { indexMap[ObjectIdentifier($0)] })
    }
}

/// 验证两条链表的序列化结果相同
func assertEqual(_ a: [(Int, Int?)], _ b: [(Int, Int?)], label: String) {
    var ok = a.count == b.count
    if ok {
        for (x, y) in zip(a, b) {
            if x.0 != y.0 || x.1 != y.1 { ok = false; break }
        }
    }
    print("\(label): \(ok ? "✅ PASS" : "❌ FAIL — expected \(b), got \(a)")")
}

// MARK: - 测试用例

let sol = Solution()

// 测试 1：示例 [[7,null],[13,0],[11,4],[10,2],[1,0]]
do {
    let head = buildList([(7, nil), (13, 0), (11, 4), (10, 2), (1, 0)])
    let copy = sol.copyRandomList(head)
    let expected: [(Int, Int?)] = [(7, nil), (13, 0), (11, 4), (10, 2), (1, 0)]
    assertEqual(serialize(copy), expected, label: "测试1")
}

// 测试 2：示例 [[1,1],[2,1]]
do {
    let head = buildList([(1, 1), (2, 1)])
    let copy = sol.copyRandomList(head)
    let expected: [(Int, Int?)] = [(1, 1), (2, 1)]
    assertEqual(serialize(copy), expected, label: "测试2")
}

// 测试 3：示例 [[3,null],[3,0],[3,null]]
do {
    let head = buildList([(3, nil), (3, 0), (3, nil)])
    let copy = sol.copyRandomList(head)
    let expected: [(Int, Int?)] = [(3, nil), (3, 0), (3, nil)]
    assertEqual(serialize(copy), expected, label: "测试3")
}

// 测试 4：空链表
do {
    let copy = sol.copyRandomList(nil)
    print("测试4（空链表）: \(copy == nil ? "✅ PASS" : "❌ FAIL")")
}

// 测试 5：单节点，random 指向自身
do {
    let head = buildList([(42, 0)])
    let copy = sol.copyRandomList(head)
    // 验证结构正确
    let ok = copy?.val == 42 && copy?.random === copy
    print("测试5（单节点self-random）: \(ok ? "✅ PASS" : "❌ FAIL")")
}

// 测试 6：深拷贝验证——新链表节点不能是原链表节点
do {
    let head = buildList([(1, 1), (2, 0)])
    let copy = sol.copyRandomList(head)
    // 收集原链表所有节点的内存地址
    var origNodes: Set<ObjectIdentifier> = []
    var cur = head
    while let c = cur { origNodes.insert(ObjectIdentifier(c)); cur = c.next }
    // 收集拷贝链表所有节点
    var isDeepCopy = true
    cur = copy
    while let c = cur {
        if origNodes.contains(ObjectIdentifier(c)) { isDeepCopy = false; break }
        cur = c.next
    }
    print("测试6（深拷贝隔离）: \(isDeepCopy ? "✅ PASS" : "❌ FAIL")")
}

//: [Next](@next)
