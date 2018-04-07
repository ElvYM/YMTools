//
//  MasonryUsageViewController.m
//  YMTools
//
//  Created by longxian on 2018/3/28.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "MasonryUsageViewController.h"
#import "YMMasonryView.h"
/**
 更新约束和布局，主要用以下四个API：
 - (void)updateConstraintsIfNeeded  调用此方法，如果有标记为需要重新布局的约束，则立即进行重新布局，内部会调用updateConstraints方法
 - (void)updateConstraints          重写此方法，内部实现自定义布局过程
 - (BOOL)needsUpdateConstraints     当前是否需要重新布局，内部会判断当前有没有被标记的约束
 - (void)setNeedsUpdateConstraints  标记需要进行重新布局
 
 

 */
@interface MasonryUsageViewController ()
/** UIView */
@property (strong, nonatomic)UIView *cyanView;
@property (strong, nonatomic)UIView *greenView;
/**  */
@property (strong, nonatomic)UIView *blueView;
/** UILabel */
@property (strong, nonatomic)UILabel *label;

/**  */
@property (strong, nonatomic)YMMasonryView *masonryView;

@end

@implementation MasonryUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self showMasonryView];
    
    
    
}

- (void)base {
    self.cyanView = [UIView new];
    self.cyanView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.cyanView];
    
    //设置内边距
    //    [self.cyanView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(74, 355, 10, 10));
    //    }];
    
    // 更新约束
    // 设置center和size，这样就可以达到简单进行约束的目的
    self.greenView = [UIView new];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];
    
    //    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.equalTo(self.view);
    //        make.size.mas_equalTo(CGSizeMake(300, 300));
    //    }];
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 指定更新size，其他约束不变。
    //        [self.greenView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            // 设置约束比例
    //            make.width.equalTo(self.view).multipliedBy(0.1);
    //        }];
    //    });
    
    //    self.label = [UILabel new];
    //    self.label.numberOfLines = 0;
    //    self.label.backgroundColor = [UIColor lightGrayColor];
    //    [self.view addSubview:self.label];
    //
    //    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.equalTo(self.view);
    //        //设置宽度小于等于200
    //        make.width.lessThanOrEqualTo(@200);
    //        // 设置高度小于定于10
    //        make.height.greaterThanOrEqualTo(@10);
    //    }];
    //
    //    self.label.text = @"我没有很想你，只是在早上醒来时，看看有没有你发来信息和未接来电；我没有很想你，只是把你来电调成唯一的铃音；我没有很想你，只是在听歌时，被某句歌词击中，脑中出现短暂的空白；我没有很想你，只是想看看你的样子，听听你的声音；我又没有很想你，只是每次醒来时，第一个想到你。";
    
    
    
    //视图等高练习
    self.blueView = [UIView new];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    //    CGFloat padding = 74.f;
    //    [self.cyanView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
    //        make.bottom.equalTo(self.greenView.mas_top).offset(-padding);
    //    }];
    //
    //    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, 0, padding));
    //        make.bottom.equalTo(self.blueView.mas_top).offset(-padding);
    //    }];
    //
    //    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, padding, padding));
    //        make.height.equalTo(@[self.cyanView, self.greenView]);
    //    }];
    
    
    // 子视图垂直居中练习
    CGFloat padding = 10.f;
    [self.cyanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).mas_offset(padding);
        make.right.equalTo(self.blueView.mas_left).mas_offset(-padding);
        make.width.equalTo(self.blueView);
        make.height.mas_equalTo(150);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.right.equalTo(self.view).mas_offset(-padding);
        make.width.equalTo(self.cyanView);
        make.height.mas_equalTo(150);
    }];
    
    self.blueView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blueColor];
        view;
    });
}


- (void)showMasonryView {
    [self.view addSubview:self.masonryView];
}

-(YMMasonryView *)masonryView {
    if (!_masonryView) {
        _masonryView = [[YMMasonryView alloc] initWithFrame:CGRectMake(0, 74, MainScreenWidth, MainScreenHeight - 49 - 74)];
        _masonryView.backgroundColor = [UIColor lightGrayColor].flatten;
    }
    return _masonryView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
