import java.util.Arrays;

public class 插入排序 {
    static int[] selectionSort(int[] sourceArray) {
        if (sourceArray.length <= 1) return sourceArray;

        int[] arr = Arrays.copyOf(sourceArray, sourceArray.length);
        for (int i = 1; i < arr.length; i++) {
            int value = arr[i];
            int j = i - 1;
            for (; j >= 0; j--) { // 查找插入位置
                if (arr[j] > value) {
                    arr[j + 1] = arr[j]; // 数据移动
                } else  {
                    break;
                }
            }
            arr[j+1] = value;
        }
        return arr;
    }

    public static void main(String[] args) {
        int[] arr = {6, 5, 3, 8};
        System.out.println(Arrays.toString(selectionSort(arr)));

    }
}
