//
//  NSDateFormatter+Helper.h
//  YMTools
//
//  Created by longxian on 2018/11/8.
//  Copyright © 2018 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,DateFormatterType) {
    DateFormatterTypeLineYearMonthDay = 0,                  //2017-10-12
    DateFormatterTypeLineYearMonthDayHourMinute,            //2017-10-12 09:44
    DateFormatterTypeTypeLineMonthDay,                      //10-12
    DateFormatterTypeHourMinute                             //09:44
};
NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (Helper)
+(instancetype)dateFormatterWithFormatterType:(DateFormatterType)dateFormatterType;
@end

NS_ASSUME_NONNULL_END
