//
//  WBSort.m
//  WBSort
//
//  Created by WENBO on 2021/8/6.
//

#import "WBSort.h"

@implementation WBSort

- (instancetype)initWithArray:(NSArray<NSNumber *> *)array {
    self = [super init];
    _sortedArray = array.mutableCopy;
    return self;
}

- (instancetype)init
{
    return [self initWithArray:@[]];
}

+ (instancetype)sortWithArray:(NSArray<NSNumber *> *)array {
    return [[self alloc] initWithArray:array];
}

- (void)sort {
    
}

- (void)swap:(NSInteger)i j:(NSInteger)j {
    id temp = self.sortedArray[i];
    self.sortedArray[i] = self.sortedArray[j];
    self.sortedArray[j] = temp;
}

- (NSInteger)compare:(NSInteger)i j:(NSInteger)j {
    return [self.sortedArray[i] integerValue] - [self.sortedArray[j] integerValue];
}

@end
