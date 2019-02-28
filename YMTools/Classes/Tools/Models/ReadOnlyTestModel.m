//
//  ReadOnlyTestModel.m
//  YMTools
//
//  Created by jike on 17/4/24.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "ReadOnlyTestModel.h"
// 全局变量
NSString * const YMTStringConstant = @"Yaoming";

// 私有变量
static const NSString *YMTStringSelf = @"Yaoming";

@interface ReadOnlyTestModel()

// .m中属性设置为 readwrite
@property (nonatomic, copy, readwrite) NSString *firstName;
@property (nonatomic, copy, readwrite) NSString *lastName;
@end

@implementation ReadOnlyTestModel
{
    NSMutableSet *_internalFriends;  //实现文件里的可变集合
}

-(NSSet *)friends {
    return [_internalFriends copy];
}

- (void)addFriend:(ReadOnlyTestModel*)person {
    [_internalFriends addObject:person]; //在外部增加集合元素的操作
    //do something when add element
}

- (void)removeFriend:(ReadOnlyTestModel*)person {
    [_internalFriends removeObject:person]; //在外部移除元素的操作
    //do something when remove element
}

- (id)initWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName {
    if ((self = [super init])) {
        _firstName = firstName;
        _lastName = lastName;
        _internalFriends = [NSMutableSet new];
    }
    return self;
}
@end

@implementation ReadOnlyTestModel (Work)

-(void)addData {
    
}

@end
