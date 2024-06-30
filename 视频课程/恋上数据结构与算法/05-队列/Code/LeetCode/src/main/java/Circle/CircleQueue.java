package Circle;

import java.util.Arrays;

public class CircleQueue<E> {
    private  int front;
    private int size;
    private E[] elements;
    private  static  final int DEFAULT_CAPCITY = 10;

    public CircleQueue() {
        elements = (E[]) new Object[DEFAULT_CAPCITY];
    }

    public  Boolean isEmpty() {
        return size == 0;
    }

    public  void enQueue(E element) {
        ensureCapacity(size + 1);
        elements[index(size)] = element;
        size++;
    }

    public  E deQueue() {
        E frontElement = elements[front];
        elements[front] = null;
        front = index(1);
        size--;
        return frontElement;
    }

    public  E front() {
        return elements[front];
    }

    public void clear() {
        for (int i = 0; i < size; i++) {
            elements[index(i)] = null;
        }
        size = 0;
        front = 0;
    }

    private void ensureCapacity(int capacity) {
        int oldCapacity = elements.length;
        if (oldCapacity >= capacity) return;

        int newCapcity = oldCapacity + (oldCapacity >> 1);
        E[] newElements = (E[]) new Object[newCapcity];
        for (int i = 0; i < size; i++) {
            newElements[i] = elements[index(i)];
        }
        elements = newElements;
        front = 0;
    }

    private int index(int index) {
        return (front + index) % elements.length;
    }

    @Override
    public String toString() {
        return "CircleQueue{" +
                "front=" + front +
                ", size=" + size +
                ", elements=" + Arrays.toString(elements) +
                '}';
    }

    public static void main(String[] args) {
        CircleQueue<Integer> queue = new CircleQueue<>();
        for (int i = 0; i < 10; i++) {
            queue.enQueue(i);
        }

        for (int i = 0; i < 5; i++) {
            queue.deQueue();
        }

        for (int i = 15; i < 20; i++) {
            queue.enQueue(i);
        }

        System.out.println(queue);
    }
}
