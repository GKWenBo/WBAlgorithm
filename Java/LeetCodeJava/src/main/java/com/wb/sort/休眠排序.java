package com.wb.sort;

public class 休眠排序 extends Thread {
    private int value;
    public 休眠排序(int value) {
        this.value = value;
    }

    public void run() {
        try {
            Thread.sleep(value);
            System.out.println(value);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        int[] array = {10, 100, 50, 30, 60};
        for (int i = 0; i < array.length; i++) {
            new 休眠排序(array[i]).start();
        }
    }
}
