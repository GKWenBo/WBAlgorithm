//
//  ViewController.m
//  Reverse Integer
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
    
    int result = [self reverseInt:120];
    NSLog(@"%d",result);
}

/*
 Given a 32-bit signed integer, reverse digits of an integer.
 Example 1:
 
 Input: 123
 Output: 321
 Example 2:
 
 Input: -123
 Output: -321
 Example 3:
 
 Input: 120
 Output: 21
 */

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
