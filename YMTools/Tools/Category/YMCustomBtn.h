//
//  YMCustomBtn.h
//  YMTools
//
//  Created by jike on 17/4/20.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YMCustomBtn : UIButton
@property (nonatomic, assign)CGRect imgFrame;
@property (nonatomic, assign)CGRect titleFrame;

/**
 创建一个自定义按钮图片和标题的按钮

 @param frame btnFrame
 @param imgFrame imgFrame
 @param titleFrame titleFrame
 @param imgName imgName
 @param title title
 @param titleFont titleFont
 @param titleColor titleColor
 @return YMCustomBtn
 */
-(instancetype)initWithFrame:(CGRect)frame
                  ImgFrame:(CGRect)imgFrame
                  TitleFrame:(CGRect)titleFrame
                   ImgName:(NSString *)imgName
                       Title:(NSString *)title
                   TitleFont:(CGFloat )titleFont
                  TitleColor:(UIColor *)titleColor;
@end
