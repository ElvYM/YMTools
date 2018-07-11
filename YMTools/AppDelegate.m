//
//  AppDelegate.m
//  YMTools
//
//  Created by jike on 17/3/11.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "AppDelegate.h"
// URLSessionDEMO
#import "NSURLSessionViewController.h"
#import "ViewController.h"
#import <Bugly/Bugly.h>
#import "YMTabBarController.h"
@interface AppDelegate ()<BuglyDelegate>

@end

@implementation AppDelegate
static NSString *BuglyID = @"119944f337";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"del:%@",NSStringFromSelector(_cmd));
    NSLog(@"del:%s",__func__);
    // Override point for customization after application launch.
//    NSURLSessionViewController *sessionVC =[[NSURLSessionViewController alloc]init];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YMTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    [self catchCrashLogs];
//    [self getError];
    
    [self bugly];
    
    [self versionInfo];

    return YES;
}

- (void)versionInfo {
    NSLog(@"SYSTEM_VERSION:%f",SYSTEM_VERSION);
    
    NSLog(@"YM_isIphone:%d",YM_isIphone);
    
    NSLog(@"YM_CurrentLanguage:%@",YM_CurrentLanguage);
    
    NSLog(@"YM_AppVersion:%@",YM_AppVersion);
    
    NSString *str1;
    NSString *str2 = nil;
    NSString *str3 = @"";
    
    UIButton *btn;
    
    NSArray *arr;
    NSArray *arr1 = @[@""];
    
    NSLog(@"1:%d---2:%d--3:%d--4:%d--5:%d--6:%d",YMIsEmpty(str1),YMIsEmpty(str2),YMIsEmpty(str3),YMIsEmpty(btn),YMIsEmpty(arr),YMIsEmpty(arr1));
    
    
    
   
}

- (void)bugly {
    [Bugly startWithAppId:BuglyID];
//    [Bugly startWithAppId:BuglyID config:^{
//        BuglyConfig *config = [[BuglyConfig alloc] init];
//        config.blockMonitorEnable = YES;
//        config.blockMonitorTimeout = 2;
//        config.consolelogEnable = YES;
//        config.delegate = self;
//        return config;
//    }()];

}


- (void)getError {
    //上传崩溃日志
    NSString * errorMessageFile = [NSString stringWithFormat:@"%@/error.txt",NSHomeDirectory()];
    if ([[NSFileManager defaultManager]fileExistsAtPath:errorMessageFile]) {
        NSString *errorStr = [[NSString alloc]initWithContentsOfFile:errorMessageFile encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"error:%@",errorStr);
//        [HttpTool uploadErrorMessage:[[NSString alloc]initWithContentsOfFile:errorMessageFile encoding:NSUTF8StringEncoding error:nil] Success:^(NSDictionary *resultDic) {
//            //上传成功后删除
//            [[NSFileManager defaultManager]removeItemAtPath:errorMessageFile error:nil];
//        } failure:^(NSError *error) {
//
//        }];
//    }}
    }
}


/**
 系统收集crash日志
 */
- (void)catchCrashLogs{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

// 异常日志获取,崩溃把日志写入本地，等下次开启app再上传
void UncaughtExceptionHandler(NSException *exception){
    
    NSArray  *excpArr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSDictionary * userInfo = [exception userInfo];
    NSString *excpCnt = [NSString stringWithFormat:@"exceptionType: %@ \n reason: %@ \n stackSymbols: %@ \n userInfo: %@",name,reason,excpArr,userInfo];
    //NSDOCUMENTPATH是沙盒路径
    NSString * errorMessageFile = [NSString stringWithFormat:@"%@/error.txt",NSHomeDirectory()];
    //将崩溃信息写入沙盒里的error.txt文件
    [excpCnt writeToFile:errorMessageFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // 设置后台快照：修改界面内容，生成需要的快照。
    // 其他界面中可以监听applicationWillResignActive通知，实现。
    UIView *snapShotView = [UIView new];
    snapShotView.backgroundColor = [UIColor blueColor].flatten;
    snapShotView.tag = 99;
    [[UIApplication sharedApplication].keyWindow addSubview:snapShotView];
    
    UILabel *label = [UILabel new];
    label.textColor = FlatRed;
    label.text = @"捂眼睛，看不到~~";
    [snapShotView addSubview:label];
    
    [snapShotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(snapShotView);
    }];
    
    
    // 如果是不需要显示快照，比如当前页面展示的是无网络的错误提示界面。使用`ignoreSnapshotOnNextApplicationLaunch`，会使用启动图代替快照。
//    [[UIApplication sharedApplication] ignoreSnapshotOnNextApplicationLaunch];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 返回应用时执行的操作。
    UIView *snapShotView = [[UIApplication sharedApplication].keyWindow viewWithTag:99];
    if (snapShotView) {
        [snapShotView removeFromSuperview];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 状态恢复：默认是禁止的，如果需要启用，必须手动在委托中设置
 */
- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    
    return YES;
}

-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}





@end
