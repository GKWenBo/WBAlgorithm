//
//  WBListNode.h
//  WBLinkedList
//
//  Created by wenbo on 2021/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBListNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong, nullable) WBListNode *next;

- (instancetype)initWithValue:(NSInteger)value;
+ (instancetype)nodeWithValue:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
