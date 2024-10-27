import Foundation

func getMax(_ arr: [Int]) -> Int {
    return process(arr, L: 0, R: arr.count - 1)
}

func process(_ arr: [Int], L: Int, R: Int) -> Int {
    if L == R {
        return arr[L]
    }
    let mid = L + (R - L) >> 1
    let lMax = process(arr, L: L, R: mid)
    let rMax = process(arr, L: mid + 1, R: R)
    return max(lMax, rMax)
}


// Test
let arr = [1, 3, 5, 6, 100, 6666]
print(getMax(arr))
 
