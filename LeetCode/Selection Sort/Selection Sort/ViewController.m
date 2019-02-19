//
//  ViewController.m
//  Selection Sort
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
    
    NSMutableArray *arr = @[@(3),
                            @(5),
                            @(7),
                            @(1)].mutableCopy;
    NSLog(@"%@",[self selectionSort:arr]);
}

/*
 原理：从第一个元素开始，依次查找对比，找到最小的元素与第一个元素交换，再从第二个元素开始找后面元素的最小值与第二个元素交换，以此类推，直到整个数组有序。
 
 时间复杂度：O(n²)
 空间复杂度：O(n²)
 稳定性：不稳定
 */

- (NSArray *)selectionSort:(NSMutableArray *)arr {
    for (int i = 0; i < arr.count; i ++) {
        int minIndex = i;
        for (int j = i + 1; j < arr.count; j ++) {
            if ([arr[j] intValue] < [arr[minIndex] intValue]) {
                minIndex = j;
            }
        }
        [arr exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    return arr.copy;
}


@end
