//
//  YMLabelViewController.m
//  YMTools
//
//  Created by jike on 17/9/4.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "YMLabelViewController.h"
//类似微博，话题，@等文字匹配
#import "JPLabel.h"
@interface YMLabelViewController ()<JPLabelDelegate>
@property (strong, nonatomic)JPLabel * textLabel;
@end

@implementation YMLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupYMLabel];
}

- (void)setupNav {
    self.title = @"YMLabel";
}

- (void)setupYMLabel {
    _textLabel = [[JPLabel alloc] initWithFrame:CGRectMake(0, 100, MainScreenWidth, MainScreenHeight - 100)];
    [self.view addSubview:_textLabel];
    
    _textLabel.text = @"#JPLabel# 用于匹配字符串的内容显示, 用户:@盼盼, 包括话题:#怎么追漂亮女孩?#, 链接:https://github.com/Chris-Pan/JPLabel, 协议:《退款政策》, 还有自定义要 高亮显示 的字符串. 再次 高亮显示.";
    
    // 非匹配内容文字颜色
    self.textLabel.jp_commonTextColor = [UIColor colorWithRed:112.0/255 green:93.0/255 blue:77.0/255 alpha:1];
    
    // 点选高亮文字颜色
    self.textLabel.jp_textHightLightBackgroundColor = [UIColor colorWithRed:237.0/255 green:213.0/255 blue:177.0/255 alpha:1];
    
    // 匹配文字颜色
    [self.textLabel setHightLightTextColor:[UIColor colorWithRed:132.0/255 green:77.0/255 blue:255.0/255 alpha:1] forHandleStyle:HandleStyleUser];
    [self.textLabel setHightLightTextColor:[UIColor colorWithRed:9.0/255 green:163.0/255 blue:213.0/255 alpha:1] forHandleStyle:HandleStyleLink];
    [self.textLabel setHightLightTextColor:[UIColor colorWithRed:254.0/255 green:156.0/255 blue:59.0/255 alpha:1] forHandleStyle:HandleStyleTopic];
    [self.textLabel setHightLightTextColor:[UIColor colorWithRed:255.0/255 green:69.0/255 blue:0.0/255 alpha:1] forHandleStyle:HandleStyleAgreement];
    
    //自定义匹配的文字和颜色#8FDF5C
    self.textLabel.jp_matchArr = @[
                                   @{
                                       @"string" : @"高亮显示",
                                       @"color" : [UIColor colorWithRed:0.55 green:0.86 blue:0.34 alpha:1]
                                       }
                                   ];
    
    // 匹配到合适内容的回调
    self.textLabel.jp_tapOperation = ^(UILabel *label, HandleStyle style, NSString *selectedString, NSRange range){
        
        // 你想要做的事
        NSLog(@"block打印 %@", selectedString);
        
        if (style == HandleStyleLink) {
//            JPWebViewController *web = [JPWebViewController new];
//            web.URLString = selectedString;
//            [self.navigationController pushViewController:web animated:YES];
        }
    };
    
    self.textLabel.delegate = self;
}

#pragma mark --------------------------------------------------
#pragma mark JPLabelDelegate

-(void)jp_label:(JPLabel *)label didSelectedString:(NSString *)selectedStr forStyle:(HandleStyle)style inRange:(NSRange)range{
    
    // 你想要做的事
    NSLog(@"代理打印 %@", selectedStr);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
