//
//  ViewController.m
//  Longest Common Prefix
//
//  Created by Mr_Lucky on 2019/3/20.
//  Copyright © 2019 tcsd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *prefix = [self longestCommonPrefix:@[@"leet",
                                                   @"leets",
                                                   @"leetCode"]];
    NSLog(@"%@",prefix);
}

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
