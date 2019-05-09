//
//  VersionUpdate.m
//  LazyCat
//
//  Created by longxian on 2018/5/2.
//  Copyright © 2018年 zhanshu. All rights reserved.
//

#import "VersionUpdate.h"
#import "VersionTipView.h"

/*

 */
@interface VersionUpdate()
/** TipView */
@property (nonatomic, strong) VersionTipView *tipView;

/** mengban */
@property (nonatomic, strong) UIView *mengban;

@end

@implementation VersionUpdate
+ (BOOL)versionUpdateCheckByAppid:(NSString *)appid {
    
    NSString *encodingUrl=[[@"http://itunes.apple.com/lookup?id=" stringByAppendingString:appid]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    BOOL isNew = NO;
    __block typeof(isNew)blockIsNew = isNew;
    
    [[AFRequestManager sharedManager] GET:encodingUrl parameters:nil completion:^(RequestResponse *response) {
        if (response.error) {
            NSLog(@"请求错误");
            blockIsNew = NO;
            return ;
        }
        
        NSDictionary *resultDic = (NSDictionary *)response.responseObject;
        if (resultDic[@"resultCount"] == 0) {
            return ;
        }
        
        //获取AppStore的版本号
        NSString * versionStr =[[[resultDic objectForKey:@"results"]firstObject]valueForKey:@"version"];
        NSString *versionStr_int=[versionStr stringByReplacingOccurrencesOfString:@"."withString:@""];
        int version=[versionStr_int intValue];
        
        //获取本地的版本号
        NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
        NSString * currentVersion = [infoDic valueForKey:@"CFBundleShortVersionString"];
        NSString *currentVersion_int=[currentVersion stringByReplacingOccurrencesOfString:@"."withString:@""];
        int current=[currentVersion_int intValue];
        
        //judge
        if(version > current){// true
            blockIsNew = YES;
            [self showTipsWithIsNewVersion:YES ResultDic:resultDic];
        }else{
            blockIsNew = NO;
        }
    }];
    return isNew;
}

+ (void)showTipsWithIsNewVersion:(BOOL)isNewVersion ResultDic:(NSDictionary *)resultDic {
    if (isNewVersion) {
        CGFloat space = 50.f;
        CGFloat width = (kWidth - 50 * 2);
        CGFloat height = 400;
        NSDictionary *infoDic = [[resultDic objectForKey:@"results"]firstObject];
        NSString *newVersionStr = [[[resultDic objectForKey:@"results"]firstObject]objectForKey:@"releaseNotes"];//releaseNotes,AppStore上面的APP更新内容
        VersionTipView *tipView = [[VersionTipView alloc] initWithFrame:CGRectMake(space, (kHeight - height) * 0.5, width, height)Title:@"发现了新版本" Desc:newVersionStr];
        [[UIApplication sharedApplication].keyWindow addSubview:tipView];
        
        __weak typeof(self)wself = self;
        __weak typeof(tipView)wTipView = tipView;
        [tipView setNextBtnClickBlock:^{
            [wTipView hide];
        }];
        
        [tipView setSureBtnClickBlock:^{
            [wself goAppStoreWithAppUrl:infoDic[@"trackViewUrl"]];
            [wTipView hide];
        }];
    }
}


+ (void)goAppStoreWithAppUrl:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)createMengban {

}

@end
