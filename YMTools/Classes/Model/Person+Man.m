//
//  Person+Man.m
//  YMTools
//
//  Created by Y on 2019/1/8.
//  Copyright © 2019 YM. All rights reserved.
//

#import "Person+Man.h"

@implementation Person (Man)


-(NSString *)name {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
