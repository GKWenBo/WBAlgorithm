//
//  WBSortTests.m
//  WBSortTests
//
//  Created by WENBO on 2021/8/6.
//

#import <XCTest/XCTest.h>
#import "WBInsertionSort.h"
#import "WBBubbleSort.h"
#import "WBQuickSort.h"

@interface WBSortTests : XCTestCase

@end

@implementation WBSortTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInsertionSort {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSArray *arr = @[@(3),
                     @(5),
                     @(7),
                     @(1)];
    NSArray *sortArray = @[@(1),
                           @(3),
                           @(5),
                           @(7)];
    WBSort *sort = [WBInsertionSort sortWithArray:arr];
    [sort sort];
    XCTAssertEqualObjects(sort.sortedArray, sortArray);
}

- (void)testBubbleSort {
    NSArray *arr = @[@(3),
                     @(5),
                     @(7),
                     @(1)];
    NSArray *sortArray = @[@(1),
                           @(3),
                           @(5),
                           @(7)];
    WBSort *sort = [WBBubbleSort sortWithArray:arr];
    [sort sort];
    XCTAssertEqualObjects(sort.sortedArray, sortArray);
}

- (void)testQuickSort {
    NSArray *arr = @[@(3),
                     @(5),
                     @(7),
                     @(1)];
    NSArray *sortArray = @[@(1),
                           @(3),
                           @(5),
                           @(7)];
    WBSort *sort = [WBQuickSort sortWithArray:arr];
    [sort sort];
    XCTAssertEqualObjects(sort.sortedArray, sortArray);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
