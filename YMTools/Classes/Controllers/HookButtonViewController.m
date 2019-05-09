//
//  HookButtonViewController.m
//  YMTools
//
//  Created by jike on 17/9/5.
//  Copyright © 2017年 YM. All rights reserved.
/*
 * Click https://github.com/Chris-Pan
 * or http://www.jianshu.com/users/e2f2d779c022/latest_articles to contact me.
 */

#import "HookButtonViewController.h"
#import "UIControl+JPBtnClickDelay.h"
@interface HookButtonViewController ()
@property (strong, nonatomic) UIButton *normalBtn;
@property (strong, nonatomic) UIButton *delayBtn;
@property (strong, nonatomic) UITextView *logTF;

/** 打印文字 */
@property(nonatomic, strong)NSString *logTextString;
@end

@implementation HookButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logTextString = @"";
    self.logTF.text = self.logTextString;
    
    [self.view addSubview:self.normalBtn];
    [self.view addSubview:self.delayBtn];
    [self.view addSubview:self.logTF];
    
    self.delayBtn.jp_acceptEventInterval = 2.0f;
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

-(void)normalBtnClick{
    self.logTextString = [self.logTextString stringByAppendingString:[NSString stringWithFormat:@"\n%@", @"正常按钮点击"]];
    self.logTF.attributedText = [self getAttrString];
}

-(void)delayBtnClick{
    self.logTextString = [self.logTextString stringByAppendingString:[NSString stringWithFormat:@"\n%@", @"延迟按钮点击"]];
    self.logTF.attributedText = [self getAttrString];
}

-(NSAttributedString *)getAttrString{
    NSString *pattern = @"延迟按钮点击";
    
    NSMutableAttributedString *attrStringM = [[NSMutableAttributedString alloc]initWithString:self.logTextString attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray<NSTextCheckingResult *> * results = [regular matchesInString:self.logTextString options:NSMatchingReportProgress range:NSMakeRange(0, self.logTextString.length)];
    
    for (NSTextCheckingResult *result in results) {
        
        NSAttributedString *attr = [[NSAttributedString alloc]initWithString:@"延迟按钮点击" attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
        [attrStringM replaceCharactersInRange:result.range withAttributedString:attr];
    }
    return [attrStringM copy];
}

#pragma mark - delegate
-(UIButton *)normalBtn {
    if (!_normalBtn) {
        _normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _normalBtn.frame = CGRectMake(50, 74, 100, 50);
        _normalBtn.backgroundColor = [UIColor blueColor];
        [_normalBtn setTitle:@"正常按钮" forState:UIControlStateNormal];
        [_normalBtn addTarget:self action:@selector(normalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _normalBtn;
}

-(UIButton *)delayBtn {
    if (!_delayBtn) {
        _delayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delayBtn.frame = CGRectMake(200, 74, 100, 50);
        _delayBtn.backgroundColor = [UIColor cyanColor];
        [_delayBtn setTitle:@"延时按钮" forState:UIControlStateNormal];
        [_delayBtn addTarget:self action:@selector(delayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delayBtn;
}

-(UITextView *)logTF {
    if (!_logTF) {
        _logTF = [[UITextView alloc] initWithFrame:CGRectMake(20, 150, kWidth, 300)];
        _logTF.backgroundColor = [UIColor lightGrayColor];
        _logTF.scrollEnabled = NO;
        
    }
    return _logTF;
}

@end
