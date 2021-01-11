import UIKit

/// 方法1
func isPalindrome(_ s: String) -> Bool {
    var characters: [Character] = []
    
    for c in s.lowercased() {
        if c.isLetter || c.isNumber {
            characters.append(c)
        }
    }
    
    let count = characters.count
    for i in 0..<count {
        if characters[i] != characters[count - i - 1] {
            return false
        }
    }
    return true
}

/// 法2：双指针
func isPalindrome1(_ s: String) -> Bool {
    let chars = [Character](s.lowercased())
    
    var left = 0;
    var right = chars.count - 1;
    while left < right {
        guard chars[left].isNumber || chars[left].isLetter else {
            left += 1
            continue
        }
        
        guard chars[right].isNumber || chars[right].isLetter else {
            right -= 1
            continue
        }
        
        guard chars[left] == chars[right] else {
            return false
        }
    
        left += 1
        right -= 1
    }
    return true
}

let s = "A man, a plan, a canal: Panama"
print(isPalindrome(s))
print(isPalindrome1(s))
