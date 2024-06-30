//
//  Test.m
//  Test
//
//  Created by wenbo on 2021/11/1.
//

#import <XCTest/XCTest.h>
#import "WBListNode.h"
#import "WBSinglyLinkedList.h"

@interface Test : XCTestCase

@end

@implementation Test
{
    WBSinglyLinkedList* _list;
    NSArray* _nodes;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    WBListNode* node1 = [WBListNode nodeWithValue:1];
    WBListNode* node2 = [WBListNode nodeWithValue:2];
    WBListNode* node3 = [WBListNode nodeWithValue:3];
    WBListNode* node4 = [WBListNode nodeWithValue:4];
    WBListNode* node5 = [WBListNode nodeWithValue:5];
    WBListNode* node6 = [WBListNode nodeWithValue:6];
    node1.next = node2;
    node2.next = node3;
    node3.next = node4;
    node4.next = node5;
    node5.next = node6;
    
    _list = [[WBSinglyLinkedList alloc] init];
    _list.head = node1;
    _nodes = [NSArray arrayWithObjects:node1, node2, node3, node4, node5, node6, nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testNodeWithValue {
    XCTAssertEqualObjects([_list nodeWithValue:1], _list.head);
    XCTAssertNil([_list nodeWithValue:10]);
}

- (void)testNodeAtIndex {
    XCTAssertEqualObjects([_list nodeAtIndex:4], _nodes[4]);
    XCTAssertNil([_list nodeAtIndex:10]);
}

- (void)testInsertNodeWithValue {
    [_list insertNodeWithValue:9];
    XCTAssertEqual(_list.head.value, 9);
    XCTAssertEqual(_list.head.next.value, 1);
}

- (void)testInsertNode {
    WBListNode* aNode = [WBListNode nodeWithValue:7];
    [_list insertNode:aNode];
    XCTAssertEqualObjects(_list.head, aNode);
}

- (void)testInsertNodeWithValueAfterNode {
    [WBSinglyLinkedList insertNodeWithValue:12 afterNode:_nodes[3]];
    XCTAssertEqual([[_list nodeAtIndex:4] value], 12);
}

- (void)testInsertNodeAfterNode {
    WBListNode* aNode = [WBListNode nodeWithValue:28];
    [WBSinglyLinkedList insertNode:aNode afterNode:_nodes[5]];
    WBListNode* prevNode = (WBListNode *)_nodes[5];
    XCTAssertEqualObjects(aNode, prevNode.next);
}

- (void)testInsertNodeBeforeNode {
    WBListNode* aNode = [WBListNode nodeWithValue:27];
    WBListNode* prevNode = (WBListNode *)_nodes[3];
    [_list insertNode:aNode beforeNode:_nodes[4]];
    XCTAssertEqualObjects(aNode, prevNode.next);
}

- (void)testInsertNodeBeforeUnconnectedNode {
    WBListNode* aNode = [WBListNode nodeWithValue:27];
    WBListNode* floatingNode = [WBListNode nodeWithValue:36];
    [_list insertNode:aNode beforeNode:floatingNode];
    for (NSUInteger i = 0; i < 6; i++) {
        XCTAssertEqualObjects([_list nodeAtIndex:i], _nodes[i]);
    }
}

- (void)testDeleteNode {
    [_list deleteNode:_nodes[0]];
    XCTAssertEqual(_list.head.value, 2);
    [_list deleteNode:_nodes[5]];
    WBListNode* lastNode = (WBListNode *)_nodes[4];
    XCTAssertNil(lastNode.next);
}

- (void)testDeleteNodesWithValue {
    WBListNode* firstNode = [WBListNode nodeWithValue:1];
    WBListNode* secondNode = [WBListNode nodeWithValue:1];
    [_list insertNode:firstNode];
    [_list insertNode:secondNode];
    [_list deleteNodesWithValue:1];
    for (NSUInteger i = 1; i < 6; i++) {
        XCTAssertEqualObjects([_list nodeAtIndex:i-1], _nodes[i]);
    }
}

- (void)testDebugDescription {
    XCTAssertEqualObjects(_list.debugDescription, @"1->2->3->4->5->6");
}

@end
