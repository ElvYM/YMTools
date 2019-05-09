//
//  UILabel+Fast.h
//  YMTools
//
//  Created by Y on 2018/11/28.
//  Copyright © 2018 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FastMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Fast)
/*
@property (copy, nonatomic, readonly)UILabel *(^<#name#>)(<#Class#> <#name#>);
 */

/** f_frame */
@property (copy, nonatomic, readonly)UILabel *(^f_frame)(CGRect rect);

@property(nonatomic, copy, readonly) UILabel *(^f_bgColor)(UIColor *color);

@property(nonatomic, copy, readonly) UILabel *(^f_textColor)(UIColor *color);

/** f_text */
@property (copy, nonatomic, readonly) UILabel *(^f_text)(NSString *text);

#pragma mark - font
/** f_font */
@property (copy, nonatomic, readonly)UILabel * (^f_font)(UIFont *font);

/** f_fontSize */
@property (copy, nonatomic, readonly)UILabel *(^f_fontSize)(CGFloat size);

/**  */
@property (copy, nonatomic, readonly)UILabel *(^f_boldFont)(CGFloat size);

/**  */
@property (copy, nonatomic, readonly)UILabel *(^f_fontNameSize)(NSString *name, CGFloat size);

/**  */
@property (copy, nonatomic, readonly)UILabel * (^f_textAlignment)(NSTextAlignment textAlignment);






+ (UILabel *)fas_make:(void(^)(UILabel *make))block;



@end

NS_ASSUME_NONNULL_END
