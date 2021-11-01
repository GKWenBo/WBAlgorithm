//
//  WBSinglyLinkedList.h
//  WBLinkedList
//
//  Created by wenbo on 2021/11/1.
//

#import <Foundation/Foundation.h>
@class WBListNode;

NS_ASSUME_NONNULL_BEGIN

@interface WBSinglyLinkedList : NSObject

@property WBListNode *head;

- (WBListNode *)nodeWithValue:(NSInteger)value;
- (WBListNode *)nodeAtIndex:(NSUInteger)index;

- (void)insertNodeWithValue:(NSInteger)value;
- (void)insertNode:(WBListNode *)node;
+ (void)insertNodeWithValue:(NSInteger)value afterNode:(WBListNode *)node;
+ (void)insertNode:(WBListNode *)aNode afterNode:(WBListNode *)node;
- (void)insertNodeWithValue:(NSInteger)value beforeNode:(WBListNode *)node;
- (void)insertNode:(WBListNode *)aNode beforeNode:(WBListNode *)node;

- (void)deleteNode:(WBListNode *)node;
- (void)deleteNodesWithValue:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
