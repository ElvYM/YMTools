//
//  UILabel+YMLabel.h
//  YMTools
//
//  Created by jike on 17/6/6.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YMLabel)
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
@end
