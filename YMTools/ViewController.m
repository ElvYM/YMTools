//
//  ViewController.m
//  YMTools
//
//  Created by jike on 17/3/11.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "EVNCarouselView.h"
#import "YMCustomBtn.h"
//多线程技术方案
#import "MultiThreadViewController.h"
//NSURLSession
#import "NSURLSessionViewController.h"
//临时测试
#import "YMTestViewController.h"
//类似微博话题文字匹配
#import "YMLabelViewController.h"
//延时按钮点击
#import "HookButtonViewController.h"
//并发其实很简单
#import "MultiThreadForDelayeShowVC.h"
//Xib_TEST UIStackView
#import "XibTestViewController.h"
//FBKVO
#import "FBKVOViewController.h"
//webSocket(facebook)
#import "SRWebSocketViewController.h"
//WKWebViewController
#import "WKWebViewController.h"
//KVO 代码原理探究
#import "KVOPrincipleVC.h"
//DZNEmptyDataSet
#import "EmptyDataSetTableViewController.h"
#import "WebViewController.h"
#import "TouchEventPrincipleVC.h"
#import "MasonryUsageViewController.h"
// 变色龙扁平化颜色管理第三方
#import "ChameleonUsageViewController.h"

//IGListKit
#import "IGListKitViewController.h"

// 打包framework静态文件
//#import <TestFW/Tool.h>

// 格式化金额字符串添加逗号","格式
#import "YMStringFormatViewController.h"

// 本地化
#import "YMLocalLanguageViewController.h"
//runtime方法
#import "NSObject+runtime.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@property (strong, nonatomic)UITableView *tableView;

@property (strong, nonatomic)UIView *view1;
@property (strong, nonatomic)UIView *view2;

/**  */
@property (nonatomic, strong) UIBarButtonItem *nightModeBtn;

/**  */
@property (nonatomic, assign, getter=isNight) BOOL night;

- (NSString *)classString:(Class )class;

@end
/*

 1.导入
 1.1 pod "DKNightVersion"
 1.2 pod install
 
 
 2.Import
 #import <DKNightVersion/DKNightVersion.h>
 
 
 3. Usage:
 1.DKColorTable.txt中可配置颜色，获取颜色：DKColorPickerWithKey(BG);
 会根据不同状态获取已配置的颜色值。
 
 2.想要View获得切换功能，需设置dk_backgroundColorPicker
 self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
 
 3.3 切换状态
 self.dk_manager.themeVersion = DKThemeVersionNormal;
 
 self.dk_manager.themeVersion = DKThemeVersionNight;
 
 
 
 */
@implementation ViewController

+ (void)load {
    [NSObject runtime_exchangeMethodWithClass:self Method1:@selector(viewDidLoad) Method2:@selector(ym_viewDidLoad)];
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell];
    [self setUpTableView];
//    [self defaultTest];
//    [self tempTest];
//    [self MBProgressUsageTest];
    
//    [self getRequest];
    [self postRequest];
//    self.navigationController.title = @"111";
    [self netReachablility];
}

- (void)ym_viewDidLoad {
    NSLog(@"ym_viewDidLoad");
    [self ym_viewDidLoad];
}

- (void)setupNav {
    UILabel *navigationLabel = [[UILabel alloc] init];
    navigationLabel.center = self.navigationController.navigationBar.center;
    navigationLabel.text = @"测试";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.textColor = RandomFlatColor;
    self.navigationItem.titleView = navigationLabel;
    
    self.navigationItem.leftBarButtonItem = self.nightModeBtn;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    self.navigationItem.leftBarButtonItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);

}


/**
 网络状态
 */
- (void)netReachablility {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if (mgr.isReachableViaWiFi) {
        NSLog(@"当前网络状态-WIFi");
    }
    else if (mgr.isReachableViaWWAN) {
        NSLog(@"当前网络状态-手机网络");
    }
}

/**
 Get
 */
- (void)getRequest {
    NSString *url = @"http://api.longxianst.com/API/Home/GetIndex?&communityid=38&terminal=iOS11.2,Simulator&OSVersion=AppStore.IOS1.1.2&sign2=dcda25abd30bc8f0d2de8a2d9fb372f4";
    
    [[AFRequestManager sharedManager] GET:url parameters:nil completion:^(RequestResponse *response) {
        NSDictionary *dic = (NSDictionary *)response.responseObject;
        NSLog(@"%@",dic);
    }];
}


/**
 Post 字符串
 */
- (void)postRequest {
    NSString *url = @"http://api.longxianst.com/API/Order/GetOrderInfo?username=17621555911&shopuser=00000&addressid=&communityid=38&terminal=iOS11.2,Simulator&OSVersion=AppStore.IOS2.0.0&sign2=3fbec88314c8d2e8e1cd259f98d2d00b";
    
    NSDictionary *postDic = @{@"shopcartids":@[@"41087",@"41088",@"41090"],@"coupon":@[@{@"amount":@"",@"title":@"",@"coupontype":@"",@"couponno":@""}],@"deliverytype":@"1"};
    
    
//    [[AFRequestManager sharedManager] POST:url perfixStr:@"data=" parameters:postDic completion:^(RequestResponse *response) {
//        NSLog(@"%@",response.responseObject);
//    }];
    
    [[NetworkManager shareInstance] post:url prefixStr:@"data=" params:postDic success:^(id result, NSURLSessionTask *task) {
        NSLog(@"%@",result);
    } failure:^(NSError *error, NSURLSessionTask *task) {
        NSLog(@"%@",error);
    }];
    
}


// 单元测试
-(int)getMaxNumber:(int)number {
    return number;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

#pragma mark - private methods
/**
 创建tableView
 */
- (void)setUpTableView {
//    [Tool log];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    MJRefreshGifHeader *refreshHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.tableView.mj_header = refreshHeader;
    
    refreshHeader.stateLabel.hidden = YES;
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    
    NSArray *imagesArr = [NSArray arrayWithObjects:
     [UIImage imageNamed:@"load_view_01.png"],
     [UIImage imageNamed:@"load_view_02.png"],
     [UIImage imageNamed:@"load_view_03.png"],
     [UIImage imageNamed:@"load_view_04.png"],
     [UIImage imageNamed:@"load_view_05.png"],
     [UIImage imageNamed:@"load_view_06.png"],
     [UIImage imageNamed:@"load_view_07.png"],
     [UIImage imageNamed:@"load_view_08.png"],
     [UIImage imageNamed:@"load_view_09.png"],
     [UIImage imageNamed:@"load_view_010.png"], nil];
    [refreshHeader setImages:imagesArr duration:0.8 forState:MJRefreshStateRefreshing];
}

- (void)addCell {
    [self addCell:@"YM常用测试" class:@"YMTestViewController"];
    [self addCell:@"多线程技术方案" class:@"MultiThreadViewController"];
    [self addCell:@"NSURLSession" class:@"NSURLSessionViewController"];
    [self addCell:@"匹配一段文字中的用户名/话题/链接/协议等" class:@"YMLabelViewController"];
    [self addCell:@"延时按钮点击hook" class:@"HookButtonViewController"];
    [self addCell:@"并发其实很简单" class:@"MultiThreadForDelayeShowVC"];
    [self addCell:@"xib测试-UIStackView" class:@"MultiThreadForDelayeShowVC"];
    [self addCell:@"Facebook_KVO" class:@"FBKVOViewController"];
    [self addCell:@"SRWebSocket" class:@"SRWebSocketViewController"];
    [self addCell:@"WKWebViewController" class:@"WKWebViewController"];
    [self addCell:@"KVOPrinciple" class:@"KVOPrincipleVC"];
    [self addCell:@"EmptyDataSet" class:@"EmptyDataSetTableViewController"];
    [self addCell:@"webView调用OC方法" class:@"WebViewController"];
    [self addCell:@"iOS事件" class:@"TouchEventPrincipleVC"];
    [self addCell:@"MasonryUsageDemo" class:@"MasonryUsageViewController"];
    [self addCell:@"扁平化颜色管理&渐变色Chameleon" class:@"ChameleonUsageViewController"];
    [self addCell:@"GCDWebServer" class:@"GCDWebServerViewController"];
    [self addCell:@"GCDWebUploader" class:@"GCDWebUploadViewController"];
    [self addCell:@"IGListKit_Test" class:NSStringFromClass([IGListKitViewController class])];
    [self addCell:@"格式化金额字符串添加逗号,格式" class:NSStringFromClass([YMStringFormatViewController class])];
    [self addCell:@"本地化" class:@"YMLocalLanguageViewController"];
    
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuserId = @"cellReuserId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuserId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuserId];
//        cell.backgroundColor = RandomFlatColor;
        cell.dk_backgroundColorPicker =  DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    }

    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
#pragma mark - CustomDelegate

#pragma mark - event response
- (void)refresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)change {
    if (self.isNight) {
        self.dk_manager.themeVersion = DKThemeVersionNormal;    }
    else {
        self.dk_manager.themeVersion = DKThemeVersionNight;
    }
    self.night = !self.isNight;
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
//        DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
        _tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
        
    }
    return _tableView;
}

-(UIBarButtonItem *)nightModeBtn {
    if (!_nightModeBtn) {
        UIBarButtonItem *nightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Night" style:UIBarButtonItemStylePlain target:self action:@selector(change)];
        _nightModeBtn = nightBtn;
    }
    return _nightModeBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
