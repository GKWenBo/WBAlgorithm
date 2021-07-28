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

    public static void main(String[] args) {
        int[] arr = {6, 5, 3, 8};
        bubbleSort(arr, 4);
        System.out.println(Arrays.toString(arr));
    }
}
