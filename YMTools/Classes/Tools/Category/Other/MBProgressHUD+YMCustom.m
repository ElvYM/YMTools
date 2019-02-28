//
//  MBProgressHUD+YMCustom.m
//  YMTools
//
//  Created by jike on 17/6/14.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "MBProgressHUD+YMCustom.h"

@implementation MBProgressHUD (YMCustom)
+(void)showCustomHud:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //hud.labelText = @"懒猫";
    
    //设置下面一句，可以点击后面的事件(不建议打开)
    //hud.userInteractionEnabled = NO;
    
    // 设置图片
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    v.backgroundColor = [UIColor clearColor];
    //创建一个layer
    CALayer *contentLayer = [CALayer layer];
    contentLayer.frame = CGRectMake(10, 10, 30, 30);
    contentLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"load_view_01"].CGImage);
    contentLayer.backgroundColor = [UIColor clearColor].CGColor;
    [v.layer addSublayer:contentLayer];
    
    //设置layer的动画属性
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    NSArray *times = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.1], [NSNumber numberWithFloat:0.2], [NSNumber numberWithFloat:0.3],[NSNumber numberWithFloat:0.4f],[NSNumber numberWithFloat:0.5f],[NSNumber numberWithFloat:0.6f],[NSNumber numberWithFloat:0.7f],[NSNumber numberWithFloat:0.8f],[NSNumber numberWithFloat:0.9f], nil];
    
    UIImage *image_1 = [UIImage imageNamed:@"load_view_01"];
    UIImage *image_2 = [UIImage imageNamed:@"load_view_02"];
    UIImage *image_3 = [UIImage imageNamed:@"load_view_03"];
    UIImage *image_4 = [UIImage imageNamed:@"load_view_04"];
    UIImage *image_5 = [UIImage imageNamed:@"load_view_05"];
    UIImage *image_6 = [UIImage imageNamed:@"load_view_06"];
    UIImage *image_7 = [UIImage imageNamed:@"load_view_07"];
    UIImage *image_8 = [UIImage imageNamed:@"load_view_08"];
    UIImage *image_9 = [UIImage imageNamed:@"load_view_09"];
    UIImage *image_10 = [UIImage imageNamed:@"load_view_010"];
    
    NSArray *values = @[(id)image_1.CGImage,(id)image_2.CGImage,(id)image_3.CGImage,(id)image_4.CGImage,(id)image_5.CGImage,(id)image_6.CGImage,(id)image_7.CGImage,(id)image_8.CGImage,(id)image_9.CGImage,(id)image_10.CGImage,(id)image_1.CGImage];
    [anim setValues:values];
    [anim setDuration:0.8];
    [anim setKeyTimes:times];
    anim.repeatCount = MAXFLOAT;
    
    [contentLayer addAnimation:anim forKey:@"content"];
    
    hud.customView = v;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    //    hud.opacity = 0.0001; //菊花背景的不透明度
    hud.color = [UIColor clearColor]; //设置color，opacity就失效
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
}
+(void)hideCustomHud:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
