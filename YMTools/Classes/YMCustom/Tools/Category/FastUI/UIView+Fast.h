//
//  UIView+Fast.h
//  YMTools
//
//  Created by Y on 2018/11/30.
//  Copyright © 2018 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 @property (copy, nonatomic, readonly)UIView *(^<#name#>)(<#Class#> <#name#>);
 */
NS_ASSUME_NONNULL_BEGIN

@interface UIView (Fast)

/**
 common
 */



/** f_frame */
@property (copy, nonatomic, readonly)UIView *(^f_frame)(CGRect rect);

@property(nonatomic, copy, readonly) UIView *(^f_bgColor)(UIColor *color);

/* LineView */
@property (copy, nonatomic, readonly)UIView *(^f_lineView)(CGRect frame);





+ (UIView *)fas_make:(void(^)(UIView *make))block;

+ (UIView *)f_init;



@end

NS_ASSUME_NONNULL_END
