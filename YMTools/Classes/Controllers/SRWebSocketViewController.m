//
//  SRWebSocketViewController.m
//  YMTools
//
//  Created by jike on 2017/12/22.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "SRWebSocketViewController.h"
#import "TYHSocketManager.h"

@interface SRWebSocketViewController ()<SRWebSocketDelegate>
@property (strong, nonatomic)SRWebSocket * socket;
@end

@implementation SRWebSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TYHSocketManager share];
}
//连接
- (void)connectAction
{
    [[TYHSocketManager share] connect];
    
}
//断开连接
- (void)disConnectAction
{
    [[TYHSocketManager share] disConnect];
}

//发送消息
- (void)sendAction
{
    [[TYHSocketManager share]sendMsg:@"aa"];
}

- (void)pingAction
{
    [[TYHSocketManager share]ping];
    
}

@end
