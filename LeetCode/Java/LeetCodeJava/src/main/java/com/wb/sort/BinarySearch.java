package com.wb.sort;

public class BinarySearch {
    public static int indexOf(int[] array, int v) {
        if (array == null || array.length == 0) return -1;
        int begin = 0;
        int end = array.length;
        while (begin < end) {
            int mid = (begin + end) >> 1;
            if (v < array[mid]) {
                end = mid;
            } else if (v > array[mid]) {
                begin = mid + 1;
            } else  {
                return mid;
            }
        }
        return -1;
    }

    public static void main(String[] args) {
        int[] array  = {10, 30, 50, 60, 100};

        System.out.println(indexOf(array, 30));
    }
}
