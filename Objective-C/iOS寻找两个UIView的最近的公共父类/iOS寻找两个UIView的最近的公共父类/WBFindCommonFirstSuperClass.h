//
//  WBFindCommonFirstSuperClass.h
//  iOS寻找两个UIView的最近的公共父类
//
//  Created by WENBO on 2021/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBFindCommonFirstSuperClass : NSObject

/// 查找两个类最近公共父类
/// @param classA 类
/// @param classB 类
+ (Class)findCommonFirstSuperClass:(Class)classA classB:(Class)classB;

@end

NS_ASSUME_NONNULL_END
