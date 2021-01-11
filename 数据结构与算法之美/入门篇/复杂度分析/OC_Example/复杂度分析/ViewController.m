//
//  ViewController.m
//  复杂度分析
//
//  Created by WENBO on 2020/6/1.
//  Copyright © 2020 WENBO. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (int)find:(NSArray *)array
          n:(int)n
          x:(int)x {
    int i = 0;
    int pos = -1;
    for (; i < n; i ++) {
        if ([array[i] intValue] == x) pos = i;
    }
    return pos;
}

- (int)find1:(NSArray *)array
           n:(int)n
           x:(int)x {
    int i = 0;
    int pos = -1;
    for (; i < n; i ++) {
        if ([array[i] intValue] == x) {
            pos = i;
            break;
        }
    }
    return pos;
}

@end
