//
//  ViewController.m
//  Insertion Sort
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
    NSLog(@"%@",[self insertSort:arr]);
}

/*
 插入排序（Insertion-Sort）的算法描述是一种简单直观的排序算法。它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入
 
 算法描述:
 - 从第一个元素开始，该元素可以认为已经被排序；
 - 取出下一个元素，在已经排序的元素序列中从后向前扫描；
 - 如果该元素（已排序）大于新元素，将该元素移到下一位置；
 - 重复步骤3，直到找到已排序的元素小于或者等于新元素的位置；
 - 将新元素插入到该位置后；
 - 重复步骤2~5。
 */

- (NSArray *)insertSort:(NSMutableArray *)arr {
    for (int i = 1; i < arr.count; i ++) {
        int preIndex = i - 1;
        int current = [arr[i] intValue];
        while (preIndex >= 0 && [arr[preIndex] intValue] > current) {
            arr[preIndex + 1] = arr[preIndex];
            preIndex--;
        }
        arr[preIndex + 1] = @(current);
    }
    return arr.copy;
}


@end
