//
//  IntroductoryPagesHelper.h
//  YMTools
//
//  Created by longxian on 2018/9/25.
//  Copyright © 2018年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntroductoryPagesHelper : NSObject
+ (instancetype)shareInstance;

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray;
@end

NS_ASSUME_NONNULL_END
