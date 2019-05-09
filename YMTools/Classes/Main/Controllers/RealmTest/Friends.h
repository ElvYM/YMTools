//
//  Friends.h
//  YMTools
//
//  Created by Y on 2019/2/27.
//  Copyright © 2019 YM. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Friends : RLMObject
@property int groupId;
@property int friendsId;
@property NSString *face;
@property NSString *name;
@property NSString *desc;

@end

NS_ASSUME_NONNULL_END
