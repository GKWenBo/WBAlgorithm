//
//  49. 字母异位词分组 (Group Anagrams)
//
//  方案 A：直接用 [UInt8] 频次数组作为字典 key（Array 元素 Hashable 时数组本身即 Hashable）
//  相比原实现 String(decoding:as: UTF8.self)，彻底规避「频次 > 127 被解码成 U+FFFD 导致错误合组」的问题。
//

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        // [UInt8] 频次数组作为 key：内容相同即哈希相等，无需再转成字符串
        var map: [[UInt8]: [String]] = [:]

        for str in strs {
            let key = encode(str)
            map[key, default: []].append(str)
        }

        return Array(map.values)
    }

    /// 将字符串编码为长度 26 的频次数组（a-z 各字母出现次数）
    /// 互为字母异位词的两个字符串，26 个计数完全相同 → key 相同
    private func encode(_ str: String) -> [UInt8] {
        var freq = [UInt8](repeating: 0, count: 26)
        let base = UInt8(ascii: "a")   // 97

        for byte in str.utf8 {
            freq[Int(byte - base)] += 1
        }

        return freq
    }
}

// MARK: - 溢出安全版（若字符串可能超长，单个字母出现次数 > 255 时改用 Int 计数）

class SolutionSafe {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var map: [[Int]: [String]] = [:]
        for str in strs {
            map[encode(str), default: []].append(str)
        }
        return Array(map.values)
    }

    private func encode(_ str: String) -> [Int] {
        var freq = [Int](repeating: 0, count: 26)
        let base = UInt8(ascii: "a")
        for byte in str.utf8 {
            freq[Int(byte - base)] += 1
        }
        return freq
    }
}

// MARK: - 验证

func check(_ input: [String], _ expectedGroups: Int) {
    let result = Solution().groupAnagrams(input)
    let sorted = result.map { $0.sorted() }.sorted { $0.count < $1.count }
    print("输入: \(input)")
    print("分组数: \(result.count)  期望: \(expectedGroups)  \(result.count == expectedGroups ? "✅" : "❌")")
    print("结果: \(sorted)")
    print("---")
}

check(["eat", "tea", "tan", "ate", "nat", "bat"], 3)
check([""], 1)
check(["a"], 1)
check(["", "", ""], 1)
check(["bbbbbbbbbb", "b", "ab", "ba"], 3)   // 含长度 10 的同字符，验证频次编码不塌陷
