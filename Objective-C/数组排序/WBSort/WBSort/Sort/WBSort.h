//
//  WBSort.h
//  WBSort
//
//  Created by WENBO on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBSort : NSObject

@property (nonatomic, strong) NSMutableArray <NSNumber *>*sortedArray;

+ (instancetype)sortWithArray:(NSArray <NSNumber *>*)array;
- (instancetype)initWithArray:(NSArray <NSNumber *>*)array NS_DESIGNATED_INITIALIZER;

- (void)sort;
- (void)swap:(NSInteger)i j:(NSInteger)j;
- (NSInteger)compare:(NSInteger)i j:(NSInteger)j;

@end

NS_ASSUME_NONNULL_END
