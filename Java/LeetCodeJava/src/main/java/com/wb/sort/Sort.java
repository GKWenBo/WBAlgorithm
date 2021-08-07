package com.wb.sort;

public abstract class Sort implements Comparable<Sort> {
    protected int[] array;
    protected int cmpCount;
    protected int swapCount;
    private long time;

    public void sort(int[] array) {
        if (array == null || array.length < 2) return;
        this.array = array;

        long begin = System.currentTimeMillis();
        sort();
        time = System.currentTimeMillis() - begin;
    }

    protected abstract void sort();

    /*
    * 返回值等于0，代表 array[i1] == array[i2]
    * */
    protected int cmp(int i1, int i2) {
        cmpCount++;
        return array[i1] - array[i2];
    }

    protected int cmpElements(Integer v1, Integer v2) {
        cmpCount++;
        return v1 - v2;
    }

    protected void swap(int i1, int i2) {
        swapCount++;
        int tmp = array[i1];
        array[i1] = array[i2];
        array[i2] = tmp;
    }

    @Override
    public int compareTo(Sort o) {
        int result = (int) (time - o.time);
        if (result != 0) return result;
        result = cmpCount - o.cmpCount;
        return result;
    }
}
