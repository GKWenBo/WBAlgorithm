package 栈;

import java.util.Deque;
import java.util.LinkedList;
import java.util.Stack;

/**
 * https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/
 */
public class _150_逆波兰表达式求值 {
    class Solution {

        // 使用栈
        public int evalRPN(String[] tokens) {
            Deque<Integer> stack = new LinkedList<>();
            int n = tokens.length;

            for (int i = 0; i < n; i++) {
                String token = tokens[i];
                if (isNumber(token)) {
                    stack.push(Integer.parseInt(token));
                } else {
                    Integer right = stack.pop();
                    Integer left = stack.pop();
                    switch (token) {
                        case "+":
                            stack.push(left + right);
                            break;
                        case "-":
                            stack.push(left - right);
                            break;
                        case "*":
                            stack.push(left * right);
                            break;
                        case "/":
                            stack.push(left / right);
                            break;
                        default:
                    }
                }
            }
            return stack.pop();
        }

        // 是否是数字
        private Boolean isNumber(String s) {
            return !(s.equals("+") || s.equals("-") || s.equals("*") || s.equals("/"));
        }

        // 使用数组模拟栈
        public int evalRPN1(String[] tokens) {
            int n = tokens.length;
            int[] nums = new int[(n + 1) / 2];
            int index = -1;
            for (int i = 0; i < n; i++) {
                String token = tokens[i];
                switch (token) {
                    case "+":
                        index--;
                        nums[index] += nums[index + 1];
                        break;
                    case "-":
                        index--;
                        nums[index] -= nums[index + 1];
                        break;
                    case "*":
                        index--;
                        nums[index] *= nums[index + 1];
                        break;
                    case "/":
                        index--;
                        nums[index] /= nums[index + 1];
                        break;
                    default:
                        index++;
                        nums[index] = Integer.parseInt(token);
                        break;
                }
            }
            return nums[index];
        }
    }
}
