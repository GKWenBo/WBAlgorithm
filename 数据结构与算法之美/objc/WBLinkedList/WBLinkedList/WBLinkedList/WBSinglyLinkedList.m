//
//  WBSinglyLinkedList.m
//  WBLinkedList
//
//  Created by wenbo on 2021/11/1.
//

#import "WBSinglyLinkedList.h"
#import "WBListNode.h"

@implementation WBSinglyLinkedList

- (WBListNode *)nodeWithValue:(NSInteger)value {
    WBListNode *current = _head;
    while (current && current.value != value) {
        current = current.next;
    }
    return current;
}

- (WBListNode *)nodeAtIndex:(NSUInteger)index {
    WBListNode *current = _head;
    NSInteger pos = 0;
    while (current && pos != index) {
        current = current.next;
        pos++;
    }
    return current;
}

- (void)insertNodeWithValue:(NSInteger)value {
    WBListNode *node = [self nodeWithValue:value];
    [self insertNode:node];
}

- (void)insertNode:(WBListNode *)node {
    node.next = _head;
    _head = node;
}

+ (void)insertNodeWithValue:(NSInteger)value afterNode:(WBListNode *)node {
    WBListNode *aNode = [WBListNode nodeWithValue:value];
    [self insertNode:aNode afterNode:node];
}

+ (void)insertNode:(WBListNode *)aNode afterNode:(WBListNode *)node {
    aNode.next = node.next;
    node.next = aNode;
}

- (void)insertNodeWithValue:(NSInteger)value beforeNode:(WBListNode *)node {
    WBListNode *aNode = [WBListNode nodeWithValue:value];
    [self insertNode:aNode beforeNode:node];
}

- (void)insertNode:(WBListNode *)aNode beforeNode:(WBListNode *)node {
    WBListNode *fakeHead = [WBListNode nodeWithValue:0];
    fakeHead.next = _head;
    WBListNode *current = fakeHead;
    while (current.next && current.next != node) {
        current = current.next;
    }
    
    if (!current.next) {
        return;
    }
    aNode.next = node;
    current.next = aNode;
}

- (void)deleteNode:(WBListNode *)node {
    if (node.next) {
        node.value = node.next.value;
        node.next = node.next.next;
        return;
    }
    
    if (!_head) {
        return;
    }
    
    WBListNode *current = _head;
    while (current.next && current.next != node) {
        current = current.next;
    }
    
    current.next = nil;
}

- (void)deleteNodesWithValue:(NSInteger)value {
    WBListNode *fakeHead = [WBListNode nodeWithValue:value + 1];
    fakeHead.next = _head;
    WBListNode *pre = fakeHead;
    WBListNode *current = _head;
    while (current) {
        if (current.next.value != value) {
            pre.next = current;
            pre = pre.next;
        }
    }
    
    if (pre.next) {
        pre.next = nil;
    }
    
    _head = fakeHead.next;
}

- (NSString*)debugDescription {
    NSMutableString* info = [[NSMutableString alloc] init];
    WBListNode *current = _head;
    if (current) {
        [info appendString:current.debugDescription];
    }
    current = current.next;
    while (current) {
        [info appendString:@"->"];
        [info appendString:current.debugDescription];
        current = current.next;
    }
    return [NSString stringWithString:info];
}

@end
