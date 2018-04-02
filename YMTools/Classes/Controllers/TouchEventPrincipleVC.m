//
//  TouchEventPrincipleVC.m
//  YMTools
//
//  Created by longxian on 2018/3/28.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "TouchEventPrincipleVC.h"
#import "TouchView.h"
@interface TouchEventPrincipleVC ()
/** UIView */
@property (strong, nonatomic)TouchView *touchView;
@end

@implementation TouchEventPrincipleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.touchView setBackgroundColor:[UIColor yellowColor]];
}


#pragma Touch Event


-(TouchView *)touchView {
    if (!_touchView) {
        _touchView = [TouchView new];
        
        [self.view addSubview:_touchView];
        
        [_touchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(300, 300));
        }];
    }
    return _touchView;;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
