//
//  NSString+SafeString.m
//  YMTools
//
//  Created by jike on 17/3/17.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "NSString+SafeString.h"

@implementation NSString (SafeString)
+ (NSString *)safeString:(NSString *)fromString {
    NSString *tempString = [NSString stringWithFormat:@"%@", fromString];
    if ([tempString isEqual:[NSNull null]] || tempString == nil || [tempString isEqualToString:@"null"] || [tempString isEqualToString:@"<null>"] || [tempString isEqualToString:@"(null)"]) {
        return @"";
    }
    return tempString;
}

@end
