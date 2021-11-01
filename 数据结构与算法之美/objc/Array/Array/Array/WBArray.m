//
//  WBArray.m
//  Array
//
//  Created by wenbo on 2021/11/1.
//

#import "WBArray.h"

@implementation WBArray
{
    @private
    NSMutableArray *_data;
    NSUInteger _capacity;
    NSUInteger _count;
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    if (self = [super init]) {
        _data = @[].mutableCopy;
        _capacity = capacity;
        _count = 0;
    }
    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= _count) return nil;
    return _data[index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    if (index >= _count) {
        [NSException raise:NSRangeException format:@"index out of range."];
    }
    for (NSInteger i = index + 1; i < _count; i++) {
        _data[i - 1] = _data[i];
    }
    _count--;
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index >= _count || index == _capacity) {
        [NSException raise:NSRangeException format:@"index out of range."];
    }
    for (NSInteger i = _count - 1; i >= index; i--) {
        _data[i + 1] = _data[i];
    }
    _data[index] = anObject;
    _count++;
}

- (void)addObject:(id)anObject {
    if (_count == _capacity) {
        [NSException raise:NSRangeException format:@"Array is full."];
    }
    [_data addObject:anObject];
    _count++;
}

- (void)printAll {
    for (id object in _data) {
        NSLog(@"%@", object);
    }
}

@end
