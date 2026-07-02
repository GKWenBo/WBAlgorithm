import UIKit

var x = 10
let closure = { [x] in print(x) }  // 创建时复制当前值
x = 20
closure()  // 打印 10
