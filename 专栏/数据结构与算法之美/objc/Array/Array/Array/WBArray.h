//
//  WBArray.h
//  Array
//
//  Created by wenbo on 2021/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBArray : NSObject

- (instancetype)initWithCapacity:(NSUInteger)capacity;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)addObject:(id)anObject;
- (void)printAll;

@end

NS_ASSUME_NONNULL_END
