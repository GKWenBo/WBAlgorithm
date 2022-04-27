import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class _50_第一个只出现一次的字符 {
    /// 方法1 哈希表
//    public char firstUniqChar(String s) {
//        HashMap<Character, Boolean> dic = new HashMap<>();
//        char[] sc = s.toCharArray();
//        for (char c : sc
//             ) {
//            dic.put(c, !dic.containsKey(c));
//        }
//        for (char c : sc
//             ) {
//            if (dic.get(c)) {
//                return c;
//            }
//        }
//        return ' ';
//    }

    // 方法二：有序哈希表
    public char firstUniqChar(String s) {
        Map<Character, Boolean> dic = new LinkedHashMap<>();
        char[] sc = s.toCharArray();
        for (char c : sc
             ) {
            dic.put(c, !dic.containsKey(c));
        }
        for(Map.Entry<Character, Boolean> d : dic.entrySet()){
            if(d.getValue()) return d.getKey();
        }
        return ' ';
    }
}
