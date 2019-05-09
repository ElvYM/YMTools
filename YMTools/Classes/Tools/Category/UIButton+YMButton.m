//
//  UIButton+YMButton.m
//  YMTools
//
//  Created by jike on 17/3/17.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "UIButton+YMButton.h"

@implementation UIButton (YMButton)
+ (id)initWithFrame:(CGRect)frame {
    return [UIButton initWithFrame:frame tag:0];
}

+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag {
    return [UIButton initWithFrame:frame tag:tag title:nil];
}

+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title {
    return [UIButton initWithFrame:frame tag:tag title:title titleColor:nil];
}

+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor {
    return [UIButton initWithFrame:frame tag:tag title:title titleColor:titleColor titleLabelFont:nil];
}

+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont {
    return [UIButton initWithFrame:frame tag:tag title:title titleColor:titleColor titleLabelFont:titleLabelFont normalImage:nil];
}

+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont
        normalImage:(UIImage *)normalImage {
    return [UIButton initWithFrame:frame tag:tag title:title titleColor:titleColor titleLabelFont:titleLabelFont normalImage:normalImage highlightImage:nil];
}

+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont
        normalImage:(UIImage *)normalImage
     highlightImage:(UIImage *)highlightImage {
    return [UIButton initWithFrame:frame tag:tag title:title titleColor:titleColor titleLabelFont:titleLabelFont normalImage:normalImage highlightImage:highlightImage backgroundColor:nil];
}

+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont
        normalImage:(UIImage *)normalImage
     highlightImage:(UIImage *)highlightImage
    backgroundColor:(UIColor *)backgroundColor {
    return [UIButton initWithFrame:frame tag:tag title:title titleColor:titleColor titleLabelFont:titleLabelFont normalImage:normalImage highlightImage:highlightImage backgroundColor:backgroundColor normalBackgroundImage:nil];
}

+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont
        normalImage:(UIImage *)normalImage
     highlightImage:(UIImage *)highlightImage
    backgroundColor:(UIColor *)backgroundColor
normalBackgroundImage:(UIImage *)normalBackgroundImage {
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tempButton.tag = tag;
    [tempButton setTitle:title forState:UIControlStateNormal];
    [tempButton setTitleColor:titleColor forState:UIControlStateNormal];
    tempButton.titleLabel.font = titleLabelFont;
    [tempButton setImage:normalImage forState:UIControlStateNormal];
    [tempButton setImage:highlightImage forState:UIControlStateHighlighted];
    [tempButton setBackgroundColor:backgroundColor];
    [tempButton setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    tempButton.frame = frame;
    return tempButton;
}

@end
