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
@interface MasonryUsageViewController ()<UIScrollViewDelegate>
/** UIView */
@property (strong, nonatomic)UIView *cyanView;
@property (strong, nonatomic)UIView *greenView;
/**  */
@property (strong, nonatomic)UIView *blueView;
/** UILabel */
@property (strong, nonatomic)UILabel *label;

/**  */
@property (strong, nonatomic)YMMasonryView *masonryView;

/** UIScrollView */
@property (strong, nonatomic)UIScrollView *scrollView;

/**  */
@property (strong, nonatomic)UIView *containerView;

/** lastView */
@property (strong, nonatomic)UIView *lastView;

@end

@implementation MasonryUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self scrollView_masonry];
    
    
    
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
        _masonryView = [[YMMasonryView alloc] initWithFrame:CGRectMake(0, 74, kWidth, kHeight - 49 - 74)];
        _masonryView.backgroundColor = [UIColor lightGrayColor].flatten;
    }
    return _masonryView;
}

/**
 ScrollView利用masonry约束，原理是创建一个containerView约束和scrollView同大小，然后子视图添加到containerView上并撑开它。
 */
- (void)scrollView_masonry {
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    // 添加一个 containerView, containerView里边放子控件,通过子控件约束 containerView 大小
    self.containerView = [[UIView alloc] init];
    [self.scrollView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
        // 约束宽度
        make.width.mas_equalTo(self.scrollView.mas_width);
    }];
    
    [self createItemView];
    
    // 最后收尾的时候更新contaiberView的大小，撑开scrollView
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.mas_equalTo(self.lastView.mas_bottom).offset(20);
    }];
}

- (void)createItemView {
    
    //多行布局 要考虑换行的问题
    CGFloat marginX = 15;  //按钮距离左边和右边的距离
    CGFloat marginY = 1;  //距离上下边缘距离
    CGFloat toTop = 9;  //按钮距离顶部的距离
    CGFloat gapX = 15;    //左右按钮之间的距离
    CGFloat gapY = 15;    //上下按钮之间的距离
    NSInteger col = 5;    //这里只布局3列
    
    CGFloat itemWidth = (kWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat itemHeight = 52.f;   //按钮的高度可以根据情况设定 这里设置为相等
    
    UIView *last = nil;   //上一个按钮
    for (int i = 0; i < 100; i++) {
        UIView *itemView = [self itemViewGreate];
        [self.containerView addSubview:itemView];
        
        // 布局
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemHeight);
            
            //topTop距离顶部的距离，，单行不用考虑太多，多行，还需要计算距顶部的距离。
            //计算距离顶部的距离 --- 根据换行
            CGFloat top = toTop + marginY + (i/col)*(itemHeight+gapY);
            make.top.mas_equalTo(toTop).offset(top);
            
            if (!last || (i%col) == 0) {  //last为nil  或者(i%col) == 0 说明换行了 每行的第一个确定它距离左边边缘的距离
                make.left.mas_offset(marginX);
                
            }else{
                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                make.left.mas_equalTo(last.mas_right).mas_offset(gapX);
            }
        }];
        last = itemView;
    }
    _lastView = last;
}

- (UIView *)itemViewGreate {
    UIView *view = [UIView new];
    view.backgroundColor = RandomFlatColor;
    
    return view;
}
#pragma mark -- getters and setters
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor lightGrayColor];
        scrollView.showsVerticalScrollIndicator = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = NO;
        scrollView.bounces = YES;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
