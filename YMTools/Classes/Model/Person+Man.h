//
//  Person+Man.h
//  YMTools
//
//  Created by Y on 2019/1/8.
//  Copyright © 2019 YM. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Man)
/** 分类中添加属性，runtime实现getter，setter方法 */
@property (copy, nonatomic)NSString *name;
@end

NS_ASSUME_NONNULL_END
