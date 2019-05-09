//
//  NSObject+runtime.h
//  YMTools
//
//  Created by longxian on 2018/11/8.
//  Copyright © 2018 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (runtime)
+ (void)runtime_exchangeMethodWithClass:(Class)class
Method1:(SEL)method1
Method2:(SEL)method2;
@end

NS_ASSUME_NONNULL_END
