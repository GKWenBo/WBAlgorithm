//: [Previous](@previous)

/*
 请编写一个函数，用于 删除单链表中某个特定节点 。在设计函数时需要注意，你无法访问链表的头节点 head ，只能直接访问 要被删除的节点 。
 题目数据保证需要删除的节点 不是末尾节点 。

 示例 1：
 输入：head = [4,5,1,9], node = 5
 输出：[4,1,9]
 解释：指定链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9
 
 示例 2：
 输入：head = [4,5,1,9], node = 1
 输出：[4,5,9]
 解释：指定链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9
 
 示例 3：
 输入：head = [1,2,3,4], node = 3
 输出：[1,2,4]
 
 示例 4：
 输入：head = [0,1], node = 0
 输出：[1]
 
 示例 5：
 输入：head = [-3,5,-99], node = -3
 输出：[5,-99]
  
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/delete-node-in-a-linked-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
 
class Solution {
    func deleteNode(_ node: ListNode?) {
        node?.val = node?.next?.val ?? 0
        node?.next = node?.next?.next
    }
}

//: [Next](@next)
