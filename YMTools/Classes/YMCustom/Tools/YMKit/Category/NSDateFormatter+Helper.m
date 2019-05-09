//
//  NSDateFormatter+Helper.m
//  YMTools
//
//  Created by longxian on 2018/11/8.
//  Copyright © 2018 YM. All rights reserved.
//

#import "NSDateFormatter+Helper.h"



@implementation NSDateFormatter (Helper)
+(instancetype)dateFormatterWithFormatterType:(DateFormatterType)dateFormatterType {
    NSString *dateFormatterStr; //默认
    switch (dateFormatterType) {
        case DateFormatterTypeLineYearMonthDayHourMinute:
            dateFormatterStr = @"yyyy-MM-dd HH:mm";
            break;
        case DateFormatterTypeTypeLineMonthDay:
            dateFormatterStr = @"MM-dd";
            break;
        case DateFormatterTypeHourMinute:
            dateFormatterStr = @"HH:mm";
            break;
        default:
            dateFormatterStr = @"yyyy-MM-dd";
            break;
    }
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = dateFormatterStr;
    return df;
}
@end
