//
//  LoginVM.m
//  YMTools
//
//  Created by Y on 2018/12/4.
//  Copyright © 2018 YM. All rights reserved.
//

#import "LoginVM.h"
#import "LoginVc.h"
@interface LoginVM()
/**  */
@property (nonatomic, strong) LoginVc *vc;

/** 登录按钮有效性 */
@property (nonatomic, strong,readwrite) RACSignal *validLoginSignal;
/** 登录按钮 */
@property (nonatomic, strong, readwrite) RACCommand *loginCommand;
@end

@implementation LoginVM

- (instancetype)init {
    if (self = [super init]) {
        self.model = [[LoginModel alloc] init];
        [self bind];
    }
    return self;
}
- (void)bind {
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber * selected) {
        @strongify(self);
        [self login];
        return [RACSignal empty];
    }];
    
    self.validLoginSignal = [[RACSignal
                              combineLatest:@[RACObserve(_model, username), RACObserve(_model, password)]
                              reduce:^(NSString *username, NSString *password) {
                                  return @(username.length > 0 && password.length > 0);
                              }]
                             distinctUntilChanged];
}

- (void)login {
    NSLog(@"loginBtnClick - %@ - %@",self.model.username, self.model.password);
}

@end
