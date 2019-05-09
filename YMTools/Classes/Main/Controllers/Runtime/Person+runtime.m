//
//  Person+runtime.m
//  YMTools
//
//  Created by Y on 2019/4/25.
//  Copyright © 2019 YM. All rights reserved.
//

#import "Person+runtime.h"
#import <objc/runtime.h>
@implementation Person (runtime)

// runtime 关联对象给分类添加getter、setter
-(NSString *)interest {
    //_cmd就是当前方法的选择子，也就是@selector(interest)
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setInterest:(NSString *)interest {
    objc_setAssociatedObject(self, @selector(interest), interest, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
