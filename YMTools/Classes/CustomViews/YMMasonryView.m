//
//  YMMasonryView.m
//  YMTools
//
//  Created by longxian on 2018/4/7.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "YMMasonryView.h"
@interface YMMasonryView()
/** View1 */
@property (strong, nonatomic)UIView *headView;

/** MidView */
@property (strong, nonatomic)UIView *midView;

/** head */
@property (strong, nonatomic)UIImageView *headImg;
/** label */
@property (strong, nonatomic)UILabel *headLabel;

@end
@implementation YMMasonryView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.headView];
    [self addSubview:self.midView];
    [self.headView addSubview:self.headImg];
    [self.headView addSubview:self.headLabel];
    
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(300);
    }];
    
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(20);
        make.left.right.bottom.equalTo(self);
    }];
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImg.mas_bottom).offset(20);
        make.left.right.equalTo(self.headView);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - Getter -- Setter
- (UIView *)headView {
    if (!_headView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor yellowColor].flatten;
        _headView = view;
    }
    return _headView;
}

- (UIView *)midView {
    if (!_midView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor].flatten;
        _midView = view;
    }
    return _midView;
}

-(UIImageView *)headImg {
    if (!_headImg) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"44"];
        _headImg = imageView;
    }
    return _headImg;
}

-(UILabel *)headLabel {
    if (!_headLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor].flatten;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"We are the super start";
        _headLabel = label;
    }
    return _headLabel;
}

@end
