//
//  FastMacro.h
//  YMTools
//
//  Created by Y on 2018/11/29.
//  Copyright © 2018 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

// UIFont
#define Font(size)     [UIFont systemFontOfSize:size]
#define BoldFont(size) [UIFont boldSystemFontOfSize:size]
#define FontName(a, b) [UIFont fontWithName:a size:b]

// Color
#define ColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ColorHexA(rgbValue,a) [UIColor colorWithRed:((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float) ((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float) (rgbValue & 0xFF)) / 255.0 alpha:a]

// 

NS_ASSUME_NONNULL_BEGIN

@interface FastMacro : NSObject

@end

NS_ASSUME_NONNULL_END
