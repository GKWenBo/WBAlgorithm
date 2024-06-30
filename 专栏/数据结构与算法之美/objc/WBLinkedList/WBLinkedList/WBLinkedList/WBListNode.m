//
//  WBListNode.m
//  WBLinkedList
//
//  Created by wenbo on 2021/11/1.
//

#import "WBListNode.h"

@implementation WBListNode

- (instancetype)initWithValue:(NSInteger)value {
    if (self = [super init]) {
        _value = value;
    }
    return self;
}

+ (instancetype)nodeWithValue:(NSInteger)value {
    return [[self alloc] initWithValue:value];
}

@end
