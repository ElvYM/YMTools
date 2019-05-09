//
//  LoginVM.h
//  YMTools
//
//  Created by Y on 2018/12/4.
//  Copyright © 2018 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
@class LoginVc;
NS_ASSUME_NONNULL_BEGIN

@interface LoginVM : NSObject
- (void)bindViewToViewModel:(LoginVc *)view;

/**  */
@property (nonatomic, strong) LoginModel *model;

/** 登录按钮有效性 */
@property (nonatomic, strong,readonly) RACSignal *validLoginSignal;
/** 登录按钮 */
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
