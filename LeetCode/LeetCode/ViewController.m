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
    
    int result = [self reverseInt:0123];
    NSLog(@"%d",result);
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

- (NSArray *)twoSum:(NSArray *)array
             target:(int)target {
    NSMutableDictionary *dict = @{}.mutableCopy;
    for (int i = 0; i < array.count; i ++) {
        int resulut = target - [array[i] intValue];
        if ([dict.allKeys containsObject:@(resulut)]) {
            return @[[dict objectForKey:@(resulut)],@(i)];
        }
        [dict setObject:@(i) forKey:array[i]];
    }
    return nil;
}

// MARK:Reverse Integer
- (int)reverseInt:(int)x {
    int rev = 0;
    while (x != 0) {
        int pop = x % 10;
        x /= 10;
        if (rev > (INT_MAX / 10) || (rev == INT_MAX / 10 && pop > 7)) {
            return 0;
        }
        if (rev < INT_MIN || (rev == INT_MIN && pop < -8)) {
            return 0;
        }
        rev = rev * 10 + pop;
    }
    return rev;
}

@end
