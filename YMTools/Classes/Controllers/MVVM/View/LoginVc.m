//
//  LoginVc.m
//  YMTools
//
//  Created by Y on 2018/12/4.
//  Copyright © 2018 YM. All rights reserved.
//

#import "LoginVc.h"
#import "LoginVM.h"
@interface LoginVc ()
/**  */
@property (nonatomic, strong) UITextField *usernameTF;
/**  */
@property (nonatomic, strong) UITextField *passwordTF;
/**  */
@property (nonatomic, strong) UIButton *loginBtn;

/** VM */
@property (nonatomic, strong) LoginVM *vm;
@end

@implementation LoginVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self racBind];
}

- (void)setupUI {
    [self.view addSubview:self.usernameTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginBtn];
    
    [self.usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.usernameTF.mas_bottom).offset(20);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(20);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.mas_equalTo(40);
    }];
}

- (void)racBind {
    _vm = [LoginVM new];
    
    @weakify(self);
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       @strongify(self);
        [self.vm.loginCommand execute:nil];
    }];
    
    RAC(self.vm, model.username) = self.usernameTF.rac_textSignal;
    RAC(self.vm, model.password) = self.passwordTF.rac_textSignal;
    RAC(self.loginBtn, enabled) = self.vm.validLoginSignal;
    
    //根据loginBtn状态，改变背景色
    [[RACObserve(self.loginBtn, enabled) map:^id(NSNumber * selected) {
        return selected.boolValue?[UIColor redColor] : [UIColor lightGrayColor];
    }] subscribeNext:^(UIColor * color) {
        @strongify(self);
        [self.loginBtn setBackgroundColor:color];
    }];
}


-(UITextField *)usernameTF {
    if (!_usernameTF) {
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"Username";
        textField.backgroundColor = [UIColor lightGrayColor];
        _usernameTF = textField;
    }
    return _usernameTF;
}

-(UITextField *)passwordTF {
    if (!_passwordTF) {
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"Password";
        textField.backgroundColor = [UIColor lightGrayColor];
        _passwordTF = textField;
    }
    return _passwordTF;
}

-(UIButton *)loginBtn {
    if (!_loginBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor flatPinkColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"Login" forState:UIControlStateNormal];
        _loginBtn = button;
    }
    return _loginBtn;
}

@end
