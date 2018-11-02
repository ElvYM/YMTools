//
//  YMStringFormatViewController.m
//  YMTools
//
//  Created by longxian on 2018/9/11.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "YMStringFormatViewController.h"

@interface YMStringFormatViewController ()

@end

@implementation YMStringFormatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *formatStr = [self formatDecimalNumber:@"1234567.23"];
    NSLog(@"%@", formatStr);

}


/**
 格式化金额字符串格式化显示
 */
- (NSString *)formatDecimalNumber:(NSString *)string {
    if (!string || string.length == 0) {
        return string;
    }
    
    NSNumber *number = @([string doubleValue]);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    formatter.positiveFormat = @"###,##0.00";
    
    NSString *amountString = [formatter stringFromNumber:number];
    return amountString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
