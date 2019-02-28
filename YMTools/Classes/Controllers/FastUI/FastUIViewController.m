//
//  FastUIViewController.m
//  YMTools
//
//  Created by Y on 2019/2/28.
//  Copyright © 2019 YM. All rights reserved.

/**
 快速创建常用控件，更友好的接口扩展常用配置
 */

#import "FastUIViewController.h"
#import "Fast.h"
@interface FastUIViewController ()

@end

@implementation FastUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    UILabel *label = [UILabel fas_make:^(UILabel * _Nonnull make) {
        make
        .f_frame(CGRectMake(10, 100, 200, 60))
        .f_text(@"别戳~我是Label.")
        .f_fontSize(25)
        .f_textColor([UIColor orangeColor])
        .f_textAlignment(NSTextAlignmentCenter);
    }];
    
    [self.view addSubview:label];
    
    
    UIButton *fastBtn = [UIButton fas_make:^(UIButton * _Nonnull make) {
        make
        .f_frame(CGRectMake(10, 180, 100, 50))
        .f_bgColor([UIColor yellowColor])
        .f_title(@"戳我试试", UIControlStateNormal)
        .f_titleColor([UIColor blackColor], UIControlStateNormal)
        .f_addTarget(self, @selector(test), UIControlEventTouchUpInside);
    }];
    
    [self.view addSubview:fastBtn];
    
    UIView *line = [UIView fas_make:^(UIView * _Nonnull make) {
        make
        .f_lineView(CGRectMake(0, 240, kWidth, 1));
    }];
    UIView *line2 = UIView.f_init.f_lineView(CGRectMake(0, 250, kWidth, 1));
    
    [self.view addSubview:line];
    [self.view addSubview:line2];
}


- (void)test {
    NSLog(@"被点了...");
}

@end
