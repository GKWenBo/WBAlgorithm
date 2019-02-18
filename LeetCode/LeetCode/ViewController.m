//
//  ViewController.m
//  LeetCode
//
//  Created by Mr_Lucky on 2019/2/15.
//  Copyright © 2019 wenbo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSArray *arr = @[@2, @7, @11, @15];
//    NSArray *result = [self twoSum:arr
//                            target:18];
//    NSLog(@"%@",result);
    
//    int result = [self reverseInt:0123];
//    NSLog(@"%d",result);
    
//    BOOL res = [self IsPalindrome:121];
    
    NSString *prefix = [self longestCommonPrefix:@[@"leet",
                                                   @"leets",
                                                   @"leetCode"]];
    NSLog(@"%@",prefix);
}

// MARK:Two Sum
/*
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */
//- (NSArray *)twoSum:(NSArray *)array
//             target:(int)target {
//    for (NSInteger i = 0; i < array.count; i ++) {
//        for (NSInteger j = i + 1; j < array.count; j++) {
//            if ([array[j] intValue] == target - [array[i] intValue]) {
//                return @[@(i),@(j)];
//            }
//        }
//    }
//    return nil;
//}

//- (NSArray *)twoSum:(NSArray *)array
//             target:(int)target {
//    NSMutableDictionary *dict = @{}.mutableCopy;
//    for (int i = 0; i < array.count; i ++) {
//        [dict setObject:@(i) forKey:array[i]];
//    }
//    for (int i = 0; i < array.count; i ++) {
//        int result = target - [array[i] intValue];
//        if ([dict.allKeys containsObject:@(result)] && [[dict objectForKey:@(result)] intValue] != i) {
//            return @[@(i),[dict objectForKey:@(result)]];
//        }
//    }
//    return nil;
//}

//- (NSArray *)twoSum:(NSArray *)array
//             target:(int)target {
//    NSMutableDictionary *dict = @{}.mutableCopy;
//    for (int i = 0; i < array.count; i ++) {
//        int resulut = target - [array[i] intValue];
//        if ([dict.allKeys containsObject:@(resulut)]) {
//            return @[[dict objectForKey:@(resulut)],@(i)];
//        }
//        [dict setObject:@(i) forKey:array[i]];
//    }
//    return nil;
//}

// MARK:Reverse Integer
//- (int)reverseInt:(int)x {
//    int rev = 0;
//    while (x != 0) {
//        int pop = x % 10;
//        x /= 10;
//        if (rev > (INT_MAX / 10) || (rev == INT_MAX / 10 && pop > 7)) {
//            return 0;
//        }
//        if (rev < INT_MIN || (rev == INT_MIN && pop < -8)) {
//            return 0;
//        }
//        rev = rev * 10 + pop;
//    }
//    return rev;
//}

// MARK:IsPalindrome
- (BOOL)IsPalindrome:(int)aNumber {
    if (aNumber < 0 || (aNumber % 10 == 0 && aNumber != 0)) {
        return NO;
    }
    int revertedNumber = 0;
    while (aNumber > revertedNumber) {
        revertedNumber = revertedNumber * 10 + aNumber % 10;
        aNumber /= 10;
    }
    return aNumber == revertedNumber || aNumber == revertedNumber / 10;
}

// MARK:Longest Common Prefix
//Approach 1
//- (NSString *)longestCommonPrefix:(NSArray *)stringArr {
//    if (stringArr.count == 0) return @"";
//    NSString *prefixString = stringArr[0];
//    for (int i = 0; i < stringArr.count; i ++) {
//        while (![stringArr[i] hasPrefix:prefixString]) {
//            prefixString = [prefixString substringWithRange:NSMakeRange(0, prefixString.length - 1)];
//            if (prefixString.length == 0) return @"";
//        }
//    }
//    return prefixString;
//}

//Aproach 2
//- (NSString *)longestCommonPrefix:(NSArray *)stringArr {
//    if (stringArr.count == 0) return @"";
//    for (int i = 0; i < [stringArr[0] length]; i ++) {
//        char c = [stringArr[0] characterAtIndex:i];
//        for (int j = 1; j < stringArr.count; j ++) {
//            if (i == [stringArr[j] length] || [stringArr[j] characterAtIndex:i] != c) {
//                return [stringArr[0] substringWithRange:NSMakeRange(0, i)];
//            }
//        }
//    }
//    return stringArr[0];
//}

//Approach 3
//- (NSString *)longestCommonPrefix:(NSArray *)stringArr {
//    if (stringArr.count == 0) return @"";
//    return [self longestCommonPrefix:stringArr
//                                left:0
//                               right:(int)(stringArr.count - 1)];
//}
//
//- (NSString *)longestCommonPrefix:(NSArray *)stringArr
//                             left:(int)left
//                            right:(int)right
//{
//    if (left == right) {
//        return stringArr[left];
//    }else {
//        int mid = (left + right) / 2;
//        NSString *lcpLeft = [self longestCommonPrefix:stringArr
//                                                 left:left
//                                                right:mid];
//        NSString *lcpRight = [self longestCommonPrefix:stringArr
//                                                  left:mid + 1
//                                                 right:right];
//        return [self commonPrefix:lcpLeft
//                         lcpRight:lcpRight];
//    }
//}
//
//- (NSString *)commonPrefix:(NSString *)lcpLeft
//                  lcpRight:(NSString *)lcpRight {
//    int min = (int)MIN(lcpLeft.length, lcpRight.length);
//    for (int i = 0; i < min; i ++) {
//        if ([lcpLeft characterAtIndex:i] != [lcpRight characterAtIndex:i]) {
//            return [lcpLeft substringWithRange:NSMakeRange(0, i)];
//        }
//    }
//    return [lcpLeft substringWithRange:NSMakeRange(0, min)];
//}

//Approach 4
- (NSString *)longestCommonPrefix:(NSArray *)stringArr {
    if (stringArr.count == 0) return @"";
    int minLen = INT_MAX;
    for (NSString *str in stringArr) {
        minLen = (int)MIN(minLen, str.length);
    }
    int low = 1;
    int high = minLen;
    while (low <= high) {
        int mid = (low + high) / 2;
        if ([self isCommonPrefix:stringArr len:mid]) {
            low = mid + 1;
        }else {
            high = mid - 1;
        }
    }
    return [stringArr[0] substringWithRange:NSMakeRange(0, (low + high) / 2)];
}

- (BOOL)isCommonPrefix:(NSArray *)strs
                   len:(int)len {
    NSString *str1 = [strs[0] substringWithRange:NSMakeRange(0, len)];
    for (int i = 0; i < strs.count; i ++) {
        if (![strs[i] hasPrefix:str1]) {
            return NO;
        }
    }
    return YES;
}
@end
