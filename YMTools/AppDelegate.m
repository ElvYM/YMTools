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
#import "IntroductoryPagesHelper.h"
#import "AdvertiseHelper.h"
#import "VersionUpdate.h"
#import "DoraemonManager.h"

// 获取app进程开始时间
#import <sys/sysctl.h>
#import <mach/mach.h>

@interface AppDelegate ()<BuglyDelegate>

@end

@implementation AppDelegate
static NSString *BuglyID = @"119944f337";

- (BOOL)processInfoForPID:(int)pid procInfo:(struct kinfo_proc*)procInfo
{
    int cmd[4] = {CTL_KERN, KERN_PROC, KERN_PROC_PID, pid};
    size_t size = sizeof(*procInfo);
    return sysctl(cmd, sizeof(cmd)/sizeof(*cmd), procInfo, &size, NULL, 0) == 0;
}

- (NSTimeInterval)processStartTime
{
    struct kinfo_proc kProcInfo;
    if ([self processInfoForPID:[[NSProcessInfo processInfo] processIdentifier] procInfo:&kProcInfo]) {
        return kProcInfo.kp_proc.p_un.__p_starttime.tv_sec * 1000.0 + kProcInfo.kp_proc.p_un.__p_starttime.tv_usec / 1000.0;
    } else {
        NSAssert(NO, @"无法取得进程的信息");
        return 0;
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSTimeInterval time = [self processStartTime];
    NSLog(@"系统进程时间:%f",time);
    
    // 绘制时间
    CGFloat startTime = [[NSDate date] timeIntervalSince1970] * 1000;
    
    NSLog(@"del:%@",NSStringFromSelector(_cmd));
    NSLog(@"del:%s",__func__);
    // Override point for customization after application launch.
//    NSURLSessionViewController *sessionVC =[[NSURLSessionViewController alloc]init];
    
    // PHP测试本地接口
    [[AFRequestManager sharedManager] GET:@"http://localhost/thinkphp_5/public/index.php/demo/index/index" parameters:nil completion:^(RequestResponse *response) {
        
    }];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YMTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:old_version];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //获取本地的版本号
    NSString * currentVersion = [infoDic valueForKey:@"CFBundleShortVersionString"];
    if (![oldVersion isEqualToString:currentVersion]) {
        // 欢迎视图
        [IntroductoryPagesHelper showIntroductoryPageView:@[@"10",@"11",@"12",@"13"]];
        
        // 存储展示过欢迎界面Version
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:old_version];
    }
    
    NSArray <NSString *> *imagesURLS = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189872684&di=03f9df0b71bb536223236235515cf227&imgtype=0&src=http%3A%2F%2Fatt1.dzwww.com%2Fforum%2F201405%2F29%2F1033545qqmieznviecgdmm.gif", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189851096&di=224fad7f17468c2cc080221dd78a4abf&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201505%2F12%2F20150512124019_GPjEJ.gif"];
    
    // 启动广告
    [AdvertiseHelper showAdvertiserView:imagesURLS];
    
//  [self catchCrashLogs];
//  [self getError];
    
    [self bugly];
    
    [self versionInfo];

    // 版本更新
    [VersionUpdate versionUpdateCheckByAppid:@"414245413"];
    
    // 开始监控网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[DoraemonManager shareInstance] install];
    
    CGFloat endTime = [[NSDate date] timeIntervalSince1970] * 1000;
    NSLog(@"绘制耗时: %f ms", endTime - startTime);
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
