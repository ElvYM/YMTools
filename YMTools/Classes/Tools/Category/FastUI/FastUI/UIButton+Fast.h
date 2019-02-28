//
//  UIButton+Fast.h
//  YMTools
//
//  Created by Y on 2018/11/29.
//  Copyright © 2018 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIControl+JPBtnClickDelay.h"

/*
 @property (copy, nonatomic, readonly)UILabel *(^<#name#>)(<#Class#> <#name#>);
 */
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Fast)
+ (UIButton *)fas_make:(void(^)(UIButton *make))block;

// Frame
@property (copy, nonatomic, readonly)UIButton *(^f_frame)(CGRect rect);

//BGColor
@property(nonatomic, copy, readonly) UIButton *(^f_bgColor)(UIColor *color);

// Title
@property (copy, nonatomic, readonly) UIButton *(^f_title)(NSString *str, UIControlState state);

// TitleColor
@property (copy, nonatomic, readonly) UIButton *(^f_titleColor)(UIColor *color, UIControlState state);

// Font
@property (copy, nonatomic, readonly) UIButton *(^f_titleFontSize)(CGFloat size);

// Img
@property (copy, nonatomic, readonly) UIButton *(^f_img)(UIImage *img, UIControlState state);

@property (copy, nonatomic, readonly) UIButton *(^f_bgImg)(UIImage *img, UIControlState state);

// Target
@property(nonatomic, copy, readonly) UIButton *(^f_addTarget)(id target,SEL sel, UIControlEvents event);
@property(nonatomic, copy, readonly) UIButton *(^f_addTargetEventTouchUpInside)(id target,SEL sel);


// EdgeInsets
 @property (copy, nonatomic, readonly)UIButton *(^f_contentInsets)(UIEdgeInsets insets);
 @property (copy, nonatomic, readonly)UIButton *(^f_titleInsets)(UIEdgeInsets insets);
 @property (copy, nonatomic, readonly)UIButton *(^f_imageInsets)(UIEdgeInsets insets);

// 延时点击
 @property (copy, nonatomic, readonly)UIButton *(^f_delayTime)(CGFloat seconds);

@end

NS_ASSUME_NONNULL_END
