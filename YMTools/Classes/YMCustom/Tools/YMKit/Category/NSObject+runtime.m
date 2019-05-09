//
//  NSObject+runtime.m
//  YMTools
//
//  Created by longxian on 2018/11/8.
//  Copyright © 2018 YM. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>
@implementation NSObject (runtime)
+ (void)runtime_exchangeMethodWithClass:(Class)class
                                Method1:(SEL)method1
                                Method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(class, method1), class_getInstanceMethod(class, method2));
}
@end
