//
//  ViewController.m
//  Palindrome Number
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
    
    BOOL res = [self IsPalindrome:121];
    NSLog(@"%d",res);
    
}

/*
 Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.
 验证回文数字。
 
 Example 1:
 
 Input: 121
 Output: true
 Example 2:
 
 Input: -121
 Output: false
 Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
 Example 3:
 
 Input: 10
 Output: false
 Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
 */
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


@end
