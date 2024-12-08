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

extension Node: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        // 用于唯一标识
        hasher.combine(val)
        hasher.combine(ObjectIdentifier(self))
    }
    public static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs === rhs
    }
}

class Solution {
    func copyRandomList(_ head: Node?) -> Node? {
        guard let head = head else { return nil }
        
        var cacheNode: [Node: Node] = [:]
        var cur: Node? = head
        while let c = cur {
            cacheNode[c] = Node(c.val)
            cur = cur?.next
        }
        
        cur = head
        while let c = cur {
            // cur 老
            // map[cur] 新
            cacheNode[c]?.next = (c.next != nil) ? cacheNode[c.next!] : nil
            cacheNode[c]?.random = (c.random != nil) ? cacheNode[c.random!] : nil
            cur = cur?.next
        }
        return cacheNode[head]
    }
}

/*
 回溯 + 哈希表
 */
class Solution1 {
    var cacheNode: [Node: Node] = [:]
    func copyRandomList(_ head: Node?) -> Node? {
        guard let head else { return head }
        if cacheNode[head] == nil {
            var headNew = Node(head.val)
            cacheNode[head] = headNew
            headNew.next = copyRandomList(head.next)
            headNew.random = copyRandomList(head.random)
        }
        return cacheNode[head]
    }
}

class Solution2 {
    func copyRandomList(_ head: Node?) -> Node? {
        guard let head else { return head }
        
        var cur: Node? = head
        var next: Node? = nil
        // 1 -> 2
        // 1 -> 1' -> 2
        while cur != nil {
            next = cur?.next
            cur?.next = Node(cur!.val)
            cur?.next?.next = next
            cur = next
        }
        
        cur = head
        var curCopy: Node? = nil
        // 设置复制节点random节点
        while cur != nil  {
            next = cur?.next?.next
            curCopy = cur?.next
            curCopy?.random = cur?.random != nil ? cur?.random?.next : nil
            cur = next
        }
        
        // 分割复制节点
        var res: Node? = head.next
        cur = head
        while cur != nil {
            next = cur?.next?.next
            curCopy = cur?.next
            cur?.next = next
            curCopy?.next = next != nil ? next?.next : nil
            cur = next
        }
        return res
    }
}

func printListNode(_ head: Node?) {
    guard head != nil else {
        return
    }
    printListNode(head?.next)
    print("\(head?.val ?? 0) - \(head?.random?.val ?? 0)")
}

// Test
let node1 = Node(1)
let node2 = Node(2)
let node3 = Node(2)
let node4 = Node(1)
let node5 = Node(0)

node3.random = node1

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5

let head = Solution1().copyRandomList(node1)
printListNode(head)

print("----------")

let head1 = Solution2().copyRandomList(node1)
printListNode(head1)

head == head1

//: [Next](@next)
