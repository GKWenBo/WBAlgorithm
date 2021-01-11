import UIKit

/*
 最好：O(1)
 最坏：O(n)
 平均：O(n）
 */
func find(array: Array<Int>, x: Int) ->Int  {
    var pos = -1
    for (index, item) in array.enumerated() {
        if item == x {
            pos = index
        }
    }
    return pos
}
 
