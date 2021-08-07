//
//  WBBubbleSort.m
//  WBSort
//
//  Created by WENBO on 2021/8/6.
//

#import "WBBubbleSort.h"

@implementation WBBubbleSort

- (void)sort {
    if (self.sortedArray.count < 2) return;
    
    for (NSInteger i = 0; i < self.sortedArray.count; i++) {
        BOOL swaped = NO;
        for (NSInteger j = 0; j < self.sortedArray.count - i - 1; j ++) {
            if ([self compare:j j:j + 1] > 0) {
                [self swap:j j:j + 1];
                swaped = YES;
            }
        }
        
        if (!swaped) break;
    }
}

@end
