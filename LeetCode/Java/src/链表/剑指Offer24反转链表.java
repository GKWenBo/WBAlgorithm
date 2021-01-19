package 链表;

public class 剑指Offer24反转链表 {

	class Solution {
		/// 递归实现
	    public ListNode reverseList(ListNode head) {
	    	if ( head == null ||head.next == null) return head;
	    	ListNode newHead = reverseList(head.next);
	    	head.next.next = head;
	    	head.next = null;
	    	return newHead;
	    }
	}
	
}
