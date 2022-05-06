package 队列;

import java.util.*;

/**
 * https://leetcode-cn.com/problems/sliding-window-maximum/
 */
public class _239_滑动窗口最大值 {
    static class Solution {
        // 使用优先队列
        public int[] maxSlidingWindow(int[] nums, int k) {
            PriorityQueue<int[]> priorityQueue = new PriorityQueue<>(new Comparator<int[]>() {
                @Override
                public int compare(int[] o1, int[] o2) {
                    return o1[0] != o2[0] ? o2[0] - o1[0] : o2[1] - o1[1];
                }
            });

            int n = nums.length;
            int[] res = new int[n - k + 1];

            for (int i = 0; i < k; i++) {
                priorityQueue.offer(new int[] {nums[i], i});
            }

            res[0] = priorityQueue.peek()[0];
            for (int i = k; i < n; i++) {
                priorityQueue.offer(new int[] {nums[i], i});
                /// 最大值下标小于当前滑动窗口最左侧下标，则出队
                while (priorityQueue.peek()[1] <= i - k) {
                    priorityQueue.poll();
                }
                res[i - k + 1] = priorityQueue.peek()[0];
            }

            return res;
        }

        // 使用单调队列
        public int[] maxSlidingWindow1(int[] nums, int k) {
            Deque<Integer> deque = new LinkedList<>();
            int n = nums.length;
            for (int i = 0; i < k; i++) {
                while (!deque.isEmpty() && nums[i] >= deque.peekLast()) {
                    deque.pollLast();
                }
                deque.offer(i);
            }

            int []res = new int[n - k + 1];
            res[0] = nums[deque.peekFirst()];
            for (int i = k; i < n; i++) {
                // 保证右侧比左侧小
                while (!deque.isEmpty() && nums[i] >= deque.peekLast()) {
                    deque.pollLast();
                }

                deque.offer(i);

                // 如果队列最左侧元素下标小于当前最左侧下标，则移除下标
                while (deque.peekFirst() <= i - k) {
                    deque.pollFirst();
                }
                res[i - k + 1] = nums[deque.peekFirst()];
            }
            return res;
        }

        public static void main(String[] args) {
            int[] nums = {1,3,-1,-3,5,3,6,7};

            Solution s = new Solution();
            int[] res = s.maxSlidingWindow1(nums, 3);
            System.out.println(Arrays.toString(res));
        }
    }
}
