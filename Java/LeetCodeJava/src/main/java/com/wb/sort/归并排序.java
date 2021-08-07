package com.wb.sort;

import java.util.Arrays;

public class 归并排序 {
    private static int[] leftArray;

    public static int[] sort(int[] sourceArray) {
        // 对 arr 进行拷贝，不改变参数内容
        int[] arr = Arrays.copyOf(sourceArray, sourceArray.length);
        if (arr.length <= 1) return arr;
        leftArray = new int[arr.length >> 1];
        return mergeSort(arr, 0, arr.length);
    }

     /*com.wb.sort.归并排序*/
    public static int[] mergeSort(int[] arr, int begin, int end) {
        if (end - begin < 2) return arr;

        int mid = (begin + end) >> 1;
        mergeSort(arr, begin, mid);
        mergeSort(arr, mid, end);
        return merge(arr, begin, mid, end);
    }

    /*
    * arr 要排序的数组
    * begin 开始位置
    * end 结束位置
    * */
    private static int[] merge(int[] arr, int begin, int mid, int end) {
        int li = 0, le = mid - begin;
        int ri = mid, re = end;
        int ai = begin;

        /// 备份左边数组
        for (int i = li; i < le; i++) {
            leftArray[i] = arr[begin + i];
        }

        // 如果左边还没有结束
        while (li < le) {
            if (ri < re && leftArray[li] > arr[ri]) {
                arr[ai++] = arr[ri++];
            } else {
                arr[ai++] = leftArray[li++];
            }
        }

        return arr;
    }

    public static void main(String[] args) {
        int[] arr = {6, 5, 3, 8, 1, 9, 2};
        System.out.println(Arrays.toString(sort(arr)));
    }
}
