//
//  NSString+SafeString.h
//  YMTools
//
//  Created by jike on 17/3/17.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SafeString)
/**
 *
 *	@param fromString	传入值
 *
 *	@return 始终返回一个有效的字符串
 */

+ (NSString *)safeString:(NSString *)fromString;
@end
