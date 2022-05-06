package 队列;

/**
 * https://leetcode-cn.com/problems/design-circular-deque/
 */
public class _641_设计循环双端队列 {
    class MyCircularDeque {
        private int capacity;
        private int front;
        private int rear;
        private  int[] arr;

        public MyCircularDeque(int k) {
            // 容量传入大小 + 1
            this.capacity = k + 1;
            this.front = 0;
            this.rear = 0;
            this.arr = new int[capacity];
        }

        public boolean insertFront(int value) {
            if (isFull()) {
                return false;
            }
            front = (front - 1 + capacity) % capacity;
            arr[front] = value;
            return true;
        }

        public boolean insertLast(int value) {
            if (isFull()) {
                return false;
            }
            arr[rear] = value;
            rear = (rear + 1) % capacity;
            return true;
        }

        public boolean deleteFront() {
            if (isEmpty()) {
                return false;
            }
            front = (front + 1) % capacity;
            return true;
        }

        public boolean deleteLast() {
            if (isEmpty()) {
                return false;
            }
            rear = (rear - 1 + capacity) % capacity;
            return true;
        }

        public int getFront() {
            if (isEmpty()) {
                return -1;
            }
            return arr[front];
        }

        public int getRear() {
            if (isEmpty()) {
                return -1;
            }
            return arr[(rear - 1 + capacity) % capacity];
        }

        public boolean isEmpty() {
            return front == rear;
        }

        public boolean isFull() {
            return (rear + 1) % capacity == front;
        }
    }
}
