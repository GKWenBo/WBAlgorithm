//
//  WBFindCommonFirstSuperClass.m
//  iOS寻找两个UIView的最近的公共父类
//
//  Created by WENBO on 2021/8/9.
//

#import "WBFindCommonFirstSuperClass.h"

@implementation WBFindCommonFirstSuperClass

+ (Class)findCommonFirstSuperClass:(Class)classA classB:(Class)classB {
    NSArray *classAArray = [self findSuperClass:classA];
    NSArray *classBArray = [self findSuperClass:classB];
    NSSet *set = [NSSet setWithArray:classBArray];
    for (Class cls in classAArray) {
        if ([set containsObject:cls]) {
            return cls;
        }
    }
    return NULL;
}

+ (NSArray *)findSuperClass:(Class)class {
    if (class == NULL) return @[];
    NSMutableArray *tempArray = @[].mutableCopy;
    while (class) {
        [tempArray addObject:class];
        class = [class superclass];
    }
    return tempArray.copy;
}

@end
