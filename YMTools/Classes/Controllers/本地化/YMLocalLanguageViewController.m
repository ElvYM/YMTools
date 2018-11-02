//
//  YMLocalLanguageViewController.m
//  YMTools
//
//  Created by longxian on 2018/9/12.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "YMLocalLanguageViewController.h"

@interface YMLocalLanguageViewController ()
/**  */
@property (nonatomic, strong) UIButton *btn;
@end

@implementation YMLocalLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocalizedString];
}

- (void)getLocalizedString {
//    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Cancel" value:@"Cancel" table:@"language"];
    NSString *title = NSLocalizedStringFromTable(@"Cancel", @"language", nil);
    
    NSString *desc = NSLocalizedStringFromTable(@"Desc", @"language", nil);
    
    [self.btn setTitle:[NSString stringWithFormat:@"%@-%@",title, desc] forState:UIControlStateNormal];
    [self.btn sizeToFit];
    self.btn.center = self.view.center;

}

-(UIButton *)btn {
    if (!_btn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor cyanColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn = button;
        [self.view addSubview:_btn];
    }
    return _btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
