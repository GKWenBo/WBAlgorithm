//
//  WBInsertionSort.m
//  WBSort
//
//  Created by WENBO on 2021/8/6.
//

#import "WBInsertionSort.h"

@implementation WBInsertionSort

- (void)sort {
    if (self.sortedArray.count < 2) return;
    for (int i = 1; i < self.sortedArray.count; i ++) {
        int preIndex = i - 1;
        NSInteger current = self.sortedArray[i].integerValue;
        while (preIndex >= 0 && self.sortedArray[preIndex].integerValue > current) {
            self.sortedArray[preIndex + 1] =  self.sortedArray[preIndex];
            preIndex--;
        }
        self.sortedArray[preIndex + 1] = @(current);
    }
}

@end
