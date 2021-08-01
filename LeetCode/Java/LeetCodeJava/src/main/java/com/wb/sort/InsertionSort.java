package com.wb.sort;

import java.util.Arrays;

/* 插入排序二分搜索优化 */
public class InsertionSort extends Sort {

    @Override
    protected void sort() {
        for (int begin = 1; begin < array.length; begin++) {
           insert(begin, search(begin));
        }
    }
    private void insert(int source, int dest) {
        int v = array[source];
        for (int i = source; i > dest; i--) {
            array[i] = array[i - 1];
        }
        array[dest] = v;
    }

    /*
     * 利用二分搜索找到index位置元素的待插入位置
     * 已经排好序数组的区间范围是[0, index）
     * */
    private int search(int index) {
        int begin = 0;
        int end = index;
        while (begin < end) {
            int mid = (begin + end) >> 1;
            if (cmp(index, mid) < 0) {
                end = mid;
            } else {
                begin = mid + 1;
            }
        }
        return begin;
    }

    public static void main(String[] args) {
        int[] arr = {6, 5, 3, 8};
        new InsertionSort().sort(arr);
        System.out.println(Arrays.toString(arr));
    }
}
