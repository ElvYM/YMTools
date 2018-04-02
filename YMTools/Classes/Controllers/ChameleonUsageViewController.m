//
//  ChameleonUsageViewController.m
//  YMTools
//
//  Created by longxian on 2018/3/29.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "ChameleonUsageViewController.h"

@interface ChameleonUsageViewController ()
/** RedView */
@property (strong, nonatomic)UIView *redView;

/** ImageColor */
@property (strong, nonatomic)UIView *imageColorView;
@end

@implementation ChameleonUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 渐变色
    /**
     //渐变类型
     UIGradientStyleLeftToRight,// 从左到右
    UIGradientStyleRadial,// 放射状
    UIGradientStyleTopToBottom // 从上到下
     
     // 扁平色 Flat_Color
     */
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleRadial withFrame:self.view.frame andColors:@[FlatBlue, FlatPink]];
    
    self.redView = [UIView new];
    self.redView.backgroundColor = [[UIColor redColor] flatten];
    [self.view addSubview:self.redView];
    
    self.imageColorView = [UIView new];
    [self.view addSubview:self.imageColorView];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(74);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.imageColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.redView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.redView);
    }];
    
    //获取图片色
    UIImage *image = [UIImage imageNamed:@"pic"];
    UIColor *imageColor = [UIColor colorWithAverageColorFromImage:image];
    self.imageColorView.backgroundColor = imageColor;
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}













@end
