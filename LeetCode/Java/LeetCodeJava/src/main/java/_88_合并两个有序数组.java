import java.lang.reflect.Array;
import java.util.Arrays;

public class _88_合并两个有序数组 {
    // 方法一：直接合并后排序
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        for (int i = 0; i < n; i++) {
            nums1[m+i] = nums2[i];
        }
        Arrays.sort(nums1);
    }
}
