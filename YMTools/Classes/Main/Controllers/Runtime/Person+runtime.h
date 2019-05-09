//
//  Person+runtime.h
//  YMTools
//
//  Created by Y on 2019/4/25.
//  Copyright © 2019 YM. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (runtime)
/** 兴趣 */
@property (copy, nonatomic)NSString *interest;
@end

NS_ASSUME_NONNULL_END
