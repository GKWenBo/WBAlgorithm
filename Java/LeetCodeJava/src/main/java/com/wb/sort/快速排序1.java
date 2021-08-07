package com.wb.sort;

import java.util.Arrays;

public class 快速排序1 {
    public static int[] sort(int[] sourceArray) {
        // 对 arr 进行拷贝，不改变参数内容
        int[] arr = Arrays.copyOf(sourceArray, sourceArray.length);
        if (arr.length < 2) return arr;
        return quickSort(arr, 0, arr.length - 1);
    }

    private static int[] quickSort(int[] arr, int begin, int end) {
        if (end - begin < 2) return arr;
        int mid = pivoIndex(arr, begin, end);
        quickSort(arr, begin, mid);
        quickSort(arr, mid + 1, end);
        return arr;
    }

    static private  int pivoIndex(int[] arr, int begin, int end) {
        /// 备份begin元素的位置
        int pivot = arr[begin];
        while (begin < end) {
            while (begin < end) {
                if (arr[end] > pivot) { /// 右边元素大于轴点元素
                    end--;
                } else { /// 右边元素小于等于轴点元素
                    arr[begin++] = arr[end];
                    break;
                }
            }

            while (begin < end) {
                if (arr[begin] < pivot) {
                    begin++;
                } else {
                    arr[end--] = arr[begin];
                    break;
                }
            }
        }

        /// 将轴点元素放在最终位置
        arr[begin] = pivot;
        /// 返回轴点元素
        return begin;
    }

    public static void main(String[] args) {
        int[] arr = {6, 5, 3, 8, 1};
        System.out.println(Arrays.toString(sort(arr)));
    }
}
