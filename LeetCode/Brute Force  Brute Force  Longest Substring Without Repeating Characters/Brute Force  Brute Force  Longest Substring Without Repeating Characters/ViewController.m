//
//  ViewController.m
//  Brute Force  Brute Force  Longest Substring Without Repeating Characters
//
//  Created by Mr_Lucky on 2019/2/19.
//  Copyright © 2019 wenbo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int len = [self lengthOfLongestSubstring:@"pwwkew"];
    NSLog(@"%d",len);
}

/*
 Given a string, find the length of the longest substring without repeating characters.
 给定一个字符串，找出最长无重复子字符串。
 
 Example 1:
 
 Input: "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 Example 2:
 
 Input: "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 Example 3:
 
 Input: "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */
//Approach 1
//C++ code in 9 lines.
//- (int)lengthOfLongestSubstring:(NSString *)s {
//    NSMutableDictionary *dict = @{}.mutableCopy;
//    int start = -1;
//    int maxLen = 0;
//    for (int i = 0; i < s.length; i ++) {
//        unichar c = [s characterAtIndex:i];
//        NSString *key = [NSString stringWithCharacters:&c
//                                                length:1];
//        if ([dict[key] intValue] > start) {
//            start = [dict[key] intValue];
//        }
//        dict[key] = @(i);
//        maxLen = MAX(maxLen, i - start);
//    }
//    return maxLen;
//}

//Approach 2
//- (int)lengthOfLongestSubstring:(NSString *)s {
//    int maxLen = 0;
//    for (int i = 0; i < s.length; i ++) {
//        for (int j = i + 1; j < s.length; j ++) {
//            if ([self allUnique:s start:i end:j]) {
//                maxLen = MAX(maxLen, j - i);
//            }
//        }
//    }
//    return maxLen;
//}
//
//- (BOOL)allUnique:(NSString *)s
//            start:(int)start
//              end:(int)end {
//    NSMutableSet *set = [NSMutableSet set];
//    for (NSInteger i = start; i < end; i ++) {
//        unichar c = [s characterAtIndex:i];
//        NSString *string = [NSString stringWithCharacters:&c length:1];
//        if ([set containsObject:string]) {
//            return NO;
//        }
//        [set addObject:string];
//    }
//    return YES;
//}

//Approach 3
//Sliding Window
//- (int)lengthOfLongestSubstring:(NSString *)s {
//    NSMutableSet *set = [NSMutableSet set];
//    int i = 0;
//    int j = 0;
//    int maxLen = 0;
//    while (i < s.length && j < s.length) {
//        unichar c = [s characterAtIndex:j];
//        NSString *cString = [NSString stringWithCharacters:&c length:1];
//        if (![set containsObject:cString]) {
//            unichar cNext = [s characterAtIndex:j++];
//            NSString *cNextString = [NSString stringWithCharacters:&cNext length:1];
//            [set addObject:cNextString];
//            maxLen = MAX(maxLen, j - i);
//        }else {
//            unichar ci = [s characterAtIndex:i++];
//            NSString *ciString = [NSString stringWithCharacters:&ci length:1];
//            [set removeObject:ciString];
//        }
//    }
//    return maxLen;
//}

//Approach 4
//Sliding Window Optimized
- (int)lengthOfLongestSubstring:(NSString *)s {
    NSMutableDictionary *dict = @{}.mutableCopy;
    int maxLen = 0;
    for (int j = 0, i = 0; j < s.length; j ++) {
        unichar c = [s characterAtIndex:j];
        NSString *cString = [NSString stringWithCharacters:&c length:1];
        if ([dict.allKeys containsObject:cString]) {
            i = MAX([[dict objectForKey:cString] intValue], i);
        }
        [dict setObject:@(j + 1) forKey:cString];
        maxLen = MAX(maxLen, j - i + 1);
    }
    return maxLen;
}

@end
