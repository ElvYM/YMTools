//
//  IntroductoryPagesHelper.m
//  YMTools
//
//  Created by longxian on 2018/9/25.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "IntroductoryPagesHelper.h"
#import "IntroductoryPagesView.h"
@interface IntroductoryPagesHelper()
/**  */
@property (nonatomic, weak) UIWindow *curWindow;

/**  */
@property (strong, nonatomic)IntroductoryPagesView *curIntroductoryPagesView;
@end

@implementation IntroductoryPagesHelper

static IntroductoryPagesHelper *shareInstance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[IntroductoryPagesHelper alloc] init];
    });
    
    return shareInstance;
}

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray
{
    if (![IntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [IntroductoryPagesHelper shareInstance].curIntroductoryPagesView = [IntroductoryPagesView pagesViewWithFrame:CGRectMake(0, 0, kWidth, kHeight) images:imageArray];
    }
    [IntroductoryPagesHelper shareInstance].curWindow = [UIApplication sharedApplication].keyWindow;
    [[IntroductoryPagesHelper shareInstance].curWindow addSubview:[IntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
}

@end
