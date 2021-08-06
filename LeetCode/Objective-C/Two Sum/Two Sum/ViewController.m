//
//  ViewController.m
//  Two Sum
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
    
//        NSArray *arr = @[@2, @7, @11, @15];
//        NSArray *result = [self twoSum:arr
//                                target:18];
//        NSLog(@"%@",result);
}

/*
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */
//Approach 1
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

//Approach 2
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

//Approach 3
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

@end
