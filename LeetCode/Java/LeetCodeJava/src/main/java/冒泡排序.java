import java.util.Arrays;

public class 冒泡排序 {
    static void bubbleSort(int[] a, int n) {
        if (n <= 1) return;
        for (int i = 0; i < n; i++) {
            Boolean flag = false; // 提前退出冒泡排序标志位
            for (int j = 0; j < n - i - 1; j++) {
                if (a[j] > a[j + 1]) {
                    int temp = a[j];
                    a[j] = a[j + 1];
                    a[j+1] = temp;
                    flag = true; // 表示有数据交换
                }
            }
            if (!flag) break; // 没有数据交换，提前退出
        }
    }

    /*排序优化*/
    static void bubbleSort1(int[] a, int n) {
        for (int end = n - 1; end > 0; end--) {
            int sortedIndex = 1;
            for (int begin = 1; begin <= end; begin++) {
                if (a[begin] < a[begin -1]) {
                    int temp = a[begin];
                    a[begin] = a[begin - 1];
                    a[begin - 1] = temp;
                    sortedIndex = begin;
                }
            }
            end = sortedIndex;
        }
    }


    public static void main(String[] args) {
        int[] arr = {6, 5, 3, 8, 1};
        bubbleSort1(arr, 5);
        System.out.println(Arrays.toString(arr));
    }
}
