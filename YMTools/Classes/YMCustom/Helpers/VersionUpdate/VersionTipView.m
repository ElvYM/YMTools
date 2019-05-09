//
//  VersionTipView.m
//  LazyCat
//
//  Created by longxian on 2018/5/2.
//  Copyright © 2018年 zhanshu. All rights reserved.
//

#import "VersionTipView.h"

@interface VersionTipView ()
{
    CGFloat _headImgVH;
}

/**
 tipsView背部滚动视图*/
@property (strong, nonatomic)UIScrollView *tipsScrollView;

/**
 sureBtn */
@property (strong, nonatomic)UIButton *sureBtn;

/**
 蒙版View */
@property (strong, nonatomic)UIView * mainView;

/** HeadImgView */
@property (nonatomic, strong) UIImageView *headImgView;

@property(nonatomic) CGRect            viewFrame;
@end

@implementation VersionTipView
//-(instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self setupIntegralUseTipView];
//    }
//    [self shakeAnimation];
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Desc:(NSString *)desc
{
    _viewFrame = frame;
    if (self = [super initWithFrame:CGRectMake(0, 0, kWidth, kHeight)]) {
        [self setupIntegralUseTipViewTitle:title Desc:desc];
    }
    [self shakeAnimation];

    return self;
}

/**
 SetUpUI
 */
- (void)setupIntegralUseTipViewTitle:(NSString *)title Desc:(NSString *)desc {
    _headImgVH = _viewFrame.size.width * 391 / 750;
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = rgba(0, 0, 0, 0.5);
    
    [self addSubview:self.headImgView];
    
    self.mainView = [[UIView alloc] initWithFrame:_viewFrame];
    [self.mainView setY:self.mainView.origin.y + _headImgVH];
    [self.mainView setHeight:self.mainView.height - _headImgVH];
    self.mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.mainView];
    
    CGFloat leftSpace = 15;
    CGFloat zero = 0;
    CGFloat width = _viewFrame.size.width;
    CGFloat labelW = width - leftSpace * 2;
    
    UILabel *titleLabel = [self createLabelWithFrame:CGRectMake(leftSpace, _headImgVH - 35, width - 30, 17)
                                             textStr:title
                                          titleColor:[UIColor blueColor]
                                            FontSize:30];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_headImgView addSubview:titleLabel];
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(leftSpace, 5, labelW, _viewFrame.size.height - 8 - 5 - 45 - 55 - _headImgVH)];
    self.tipsScrollView = scrollV;
    [_mainView addSubview:self.tipsScrollView];
    
    CGFloat labelH = [desc heightWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:labelW - leftSpace * 2];
    UILabel *tipOneLabel = [self createLabelWithFrame:CGRectMake(leftSpace, 5, labelW - leftSpace * 2, labelH) textStr:desc titleColor:ColorFromRGB(0x666666, 1) FontSize:13];
    tipOneLabel.numberOfLines = 0;
    [self.tipsScrollView addSubview:tipOneLabel];
    
    self.tipsScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(tipOneLabel.frame));
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(_mainView.size.width * 0.25, _mainView.size.height - 100, _viewFrame.size.width * 0.5, 40);
    [button setTitle:@"立即更新" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setBackgroundColor:ColorFromRGB(0xdddddd, 1)];
    [button addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    button.backgroundColor = ColorFromRGB(0x8cc63f, 1);
    button.layer.cornerRadius = 4;
    button.clipsToBounds = YES;
    self.sureBtn = button;
    [_mainView addSubview:button];
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    next.frame = CGRectMake(_mainView.size.width * 0.25, _mainView.size.height - 50, _viewFrame.size.width * 0.5, 40);
    [next setTitle:@"下次再说" forState:UIControlStateNormal];
    [next setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    next.titleLabel.font = [UIFont systemFontOfSize:15];

    [next addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    next.layer.cornerRadius = 4;
    next.clipsToBounds = YES;
    next.layer.borderColor = [UIColor blueColor].CGColor;
    next.layer.borderWidth = 0.5;
    [_mainView addSubview:next];
}


- (void)nextBtnClick {
    if (self.nextBtnClickBlock) {
        self.nextBtnClickBlock();
    }
}

/**
 The sureBtn be clicked
 
 @param sender currentButton
 */
- (void)sureBtnClick:(UIButton *)sender {
    if (self.sureBtnClickBlock) {
        self.sureBtnClickBlock();
    }
}

- (void)hide {
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)shakeAnimation {
    self.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.05, 1.05);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (UILabel *)createLabelWithFrame:(CGRect )frame
                          textStr:(NSString *)text
                       titleColor:(UIColor *)color
                         FontSize:(NSInteger)fontsize {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:fontsize];
    label.text = text;
    label.textColor = color;
    return label;
}

-(UIImageView *)headImgView {
    if (!_headImgView) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"updateBackImg"];
        imageView.frame = CGRectMake(_viewFrame.origin.x, _viewFrame.origin.y, _viewFrame.size.width, _viewFrame.size.width * 391 / 750);
        _headImgView = imageView;
    }
    return _headImgView;
}



@end
