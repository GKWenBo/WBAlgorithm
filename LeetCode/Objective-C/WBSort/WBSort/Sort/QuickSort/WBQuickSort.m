//
//  WBQuickSort.m
//  WBSort
//
//  Created by WENBO on 2021/8/6.
//

#import "WBQuickSort.h"

@implementation WBQuickSort

- (void)sort {
    [self quickSort:self.sortedArray left:0 right:self.sortedArray.count - 1];
}

- (NSArray *)quickSort:(NSMutableArray *)sourceArray left:(NSInteger)left right:(NSInteger)right {
    if (left < right) {
        NSInteger mid = [self partition:sourceArray left:left right:right];
        [self quickSort:sourceArray left:left right:mid - 1];
        [self quickSort:sourceArray left:mid + 1 right:right];
    }
    return sourceArray;
}

- (NSInteger)partition:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right {
    NSInteger pivot = left;
    NSInteger index = pivot + 1;
    for (NSInteger i = index; i <= right; i++) {
        if ([self compare:i j:pivot] < 0) {
            [self swap:i j:index];
            index++;
        }
    }
    [self swap:pivot j:index - 1];
    return index - 1;
}

@end
