//
//  MBProgressHUD+YMCustom.h
//  YMTools
//
//  Created by jike on 17/6/14.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (YMCustom)

/**
 创建MBHUD CustomView.现为一个loading动画

 @param view CustomHUD
 */
+(void)showCustomHud:(UIView *)view;


+(void)hideCustomHud:(UIView *)view;
@end
