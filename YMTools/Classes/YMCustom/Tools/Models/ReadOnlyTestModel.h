//
//  ReadOnlyTestModel.h
//  YMTools
//
//  Created by jike on 17/4/24.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
// 第18条
@interface ReadOnlyTestModel : NSObject
//全局变量
#define AA @"yaoming"

UIKIT_EXTERN NSString * const YMTStringConstant;

// .h中属性设置为readonly
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
//向外公开的不可变集合
@property (nonatomic, strong, readonly) NSSet *friends;

- (id)initWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName;
- (void)addFriend:(ReadOnlyTestModel*)person;
- (void)removeFriend:(ReadOnlyTestModel*)person;

@end

@interface ReadOnlyTestModel (Work)

- (void)addData;

@end
