import com.wb.WBBinarySearchTree;
import mj.printer.BinaryTrees;

public class Main {
    public static void main(String[] args) {
//        test1();
//        test2();
//        test3();
//        test4();
        test5();
    }

    static void test1() {
        Integer array[] = new Integer[] {7, 4, 9, 2, 5, 8, 11, 3, 1};
        WBBinarySearchTree bst = new WBBinarySearchTree();
        for (int i = 0; i < array.length; i++) {
            bst.add(array[i]);
        }
        BinaryTrees.println(bst);
    }

    static void test2() {
        Integer array[] = new Integer[] {7, 4, 9, 2, 5, 8, 11, 3, 1};
        WBBinarySearchTree bst = new WBBinarySearchTree();
        for (int i = 0; i < array.length; i++) {
            bst.add(array[i]);
        }
        BinaryTrees.println(bst);
        bst.preOrderTraversal();
    }

    static void test3() {
        Integer array[] = new Integer[] {7, 4, 9, 2, 5, 8, 11, 3, 12, 1};
        WBBinarySearchTree bst = new WBBinarySearchTree();
        for (int i = 0; i < array.length; i++) {
            bst.add(array[i]);
        }
        BinaryTrees.println(bst);
        bst.inOrderTraversal1(new WBBinarySearchTree.Visitor() {
            @Override
            public boolean visit(Object element) {
                System.out.println(element);
                return true;
            }
        });
    }

    static void test4() {
        Integer array[] = new Integer[] {7, 4, 9, 2, 5, 8, 11, 3, 12, 1, 15};
        WBBinarySearchTree bst = new WBBinarySearchTree();
        for (int i = 0; i < array.length; i++) {
            bst.add(array[i]);
        }
        BinaryTrees.println(bst);
        System.out.println(bst.height());
        System.out.println(bst.height1());
    }

    static void test5() {
        Integer array[] = new Integer[] {7, 4, 9, 2, 5, 8, 3, 12, 1};
        WBBinarySearchTree bst = new WBBinarySearchTree();
        for (int i = 0; i < array.length; i++) {
            bst.add(array[i]);
        }

        BinaryTrees.println(bst);
        System.out.println(bst.isComplete());
        System.out.println(bst.isComplete1());
    }

}
