import com.wb.WBBinarySearchTree;
import mj.printer.BinaryTrees;

public class Main {
    public static void main(String[] args) {
        test1();
    }

    static void test1() {
        Integer array[] = new Integer[] {7, 4, 9, 2, 5, 8, 11, 3, 12, 1};
        WBBinarySearchTree bst = new WBBinarySearchTree();
        for (int i = 0; i < array.length; i++) {
            bst.add(array[i]);
        }
        BinaryTrees.println(bst);
    }
}
