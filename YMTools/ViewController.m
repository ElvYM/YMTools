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

// 打包framework静态文件
#import <TestFW/Tool.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@property (strong, nonatomic)UITableView *tableView;

@property (strong, nonatomic)UIView *view1;
@property (strong, nonatomic)UIView *view2;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell];
    [self setUpTableView];
//    [self defaultTest];
//    [self tempTest];
//    [self MBProgressUsageTest];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
}

#pragma mark - private methods
/**
 创建tableView
 */
- (void)setUpTableView {
    [Tool log];
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

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
