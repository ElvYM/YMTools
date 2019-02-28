//
//  UIButton+YMButton.h
//  YMTools
//
//  Created by jike on 17/3/17.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YMButton)

/**
 快速创建按钮

 @param frame 尺寸
 @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame;


/**
 快速创建按钮

 @param frame 尺寸
 @param tag tag值
 @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag;


/**
 快速创建按钮

 @param frame 尺寸
 @param tag tag值
 @param title 文字
 @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title;


/**
 快速创建按钮

 @param frame 尺寸
 @param tag tag值
 @param title 文字
 @param titleColor 文字颜色
 @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor;



/**
 快速创建按钮

 @param frame 尺寸
 @param tag tag值
 @param title 文字
 @param titleColor 文字颜色
 @param titleLabelFont 文字大小
 @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont;


/**
 快速创建按钮
 
 *  @param frame          尺寸
 *  @param tag            tag值
 *  @param title          文字
 *  @param titleColor     文字颜色
 *  @param titleLabelFont 文字大小
 *  @param normalImage    默认图片
 *
 *  @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont
        normalImage:(UIImage *)normalImage;


/**
 *  @author https://github.com/yaoqi-github
 快速创建按钮
 
 *  @param frame          尺寸
 *  @param tag            tag值
 *  @param title          文字
 *  @param titleColor     文字颜色
 *  @param titleLabelFont 文字大小
 *  @param normalImage    默认图片
 *  @param highlightImage 高亮图片
 *
 *  @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont
        normalImage:(UIImage *)normalImage
     highlightImage:(UIImage *)highlightImage;


/**
 *快速创建按钮
 
 *  @param frame            尺寸
 *  @param tag              tag值
 *  @param title            文字
 *  @param titleColor       文字颜色
 *  @param titleLabelFont   文字大小
 *  @param normalImage      默认图片
 *  @param highlightImage   高亮图片
 *  @param backgroundColor  背景颜色
 *
 *  @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont
        normalImage:(UIImage *)normalImage
     highlightImage:(UIImage *)highlightImage
    backgroundColor:(UIColor *)backgroundColor;


/**
 快速创建按钮
 
 *  @param frame                    尺寸
 *  @param tag                      tag值
 *  @param title                    文字
 *  @param titleColor               文字颜色
 *  @param titleLabelFont           文字大小
 *  @param normalImage              默认图片
 *  @param highlightImage           高亮图片
 *  @param backgroundColor          背景颜色
 *  @param normalBackgroundImage    默认背景图片
 *
 *  @return UIButton
 */
+ (id)initWithFrame:(CGRect)frame
                tag:(NSInteger)tag
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
     titleLabelFont:(UIFont *)titleLabelFont
        normalImage:(UIImage *)normalImage
     highlightImage:(UIImage *)highlightImage
    backgroundColor:(UIColor *)backgroundColor
normalBackgroundImage:(UIImage *)normalBackgroundImage;

@end
