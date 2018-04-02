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
@interface AppDelegate ()<BuglyDelegate>

@end

@implementation AppDelegate
static NSString *BuglyID = @"119944f337";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSURLSessionViewController *sessionVC =[[NSURLSessionViewController alloc]init];
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    [self catchCrashLogs];
//    [self getError];
    
    [self bugly];

    return YES;
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
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
