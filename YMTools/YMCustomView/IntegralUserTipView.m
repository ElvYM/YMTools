//
//  IntegralUserTipView.m
//  LazyCat
//
//  Created by jike on 17/6/8.
//  Copyright © 2017年 zhanshu. All rights reserved.
//

#import "IntegralUserTipView.h"
static NSString *title = @"积分使用规则";
static NSString *tipsOne = @"1.订单金额大于20元(含);\n2.积分大于1000分(含);\n3.积分支付不得超过每笔订单应付金额的50%;";
static NSString *tipsTwo = @"1.使用积分为1000的整数倍;\n2.1000积分抵扣10元";

@interface IntegralUserTipView ()

/**
 tipsView背部滚动视图*/
@property (strong, nonatomic)UIScrollView *tipsScrollView;

/**
 sureBtn */
@property (strong, nonatomic)UIButton *sureBtn;
@end

@implementation IntegralUserTipView
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupIntegralUseTipView];
    }
    return self;
}

- (void)setupIntegralUseTipView {
//    self.layer.cornerRadius = 5;
//    self.layer.masksToBounds = YES;
//    CGFloat leftSpace = 15;
//    CGFloat zero = 0;
//    CGFloat width = self.frame.size.width;
//    CGFloat labelW = width - leftSpace * 2;
//    UILabel *titleLabel = [self createLabelWithFrame:CGRectMake(leftSpace, 15, width - 30, 17)
//                                             textStr:title
//                                          titleColor:SetColorRGBValue(0x000000, 1)
//                                            FontSize:17];
//    [self addSubview:titleLabel];
//    
//    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(titleLabel.frame) + 5, labelW, self.frame.size.height - 20 - 17 - 5 - 45)];
//    self.tipsScrollView = scrollV;
//    [self addSubview:self.tipsScrollView];
//    
//    UILabel *tipOneTitleLabel = [self createLabelWithFrame:CGRectMake(zero, 10, labelW, 14)
//                                         textStr:@"使用条件"
//                                      titleColor:SetColorRGBValue(0x000000, 1)
//                                        FontSize:14];
//    [self.tipsScrollView addSubview:tipOneTitleLabel];
//    
//    CGSize oneSize = [Utils calculateSizeWithText:tipsOne maxW:labelW fontSize:13];
//    UILabel *tipOneLabel = [self createLabelWithFrame:CGRectMake(zero, CGRectGetMaxY(tipOneTitleLabel.frame) + 8, labelW, oneSize.height) textStr:tipsOne titleColor:SetColorRGBValue(0x666666, 1) FontSize:13];
//    tipOneLabel.numberOfLines = 0;
//    [self.tipsScrollView addSubview:tipOneLabel];
//    
//    UILabel *tipTwoTitleLabel = [self createLabelWithFrame:CGRectMake(zero, CGRectGetMaxY(tipOneLabel.frame) + 15, labelW, 14)
//                                                   textStr:@"使用数量"
//                                                titleColor:SetColorRGBValue(0x000000, 1)
//                                                  FontSize:14];
//    [self.tipsScrollView addSubview:tipTwoTitleLabel];
//    
//    CGSize twoSize = [Utils calculateSizeWithText:tipsTwo maxW:labelW fontSize:13];
//    UILabel *tipTwoLabel = [self createLabelWithFrame:CGRectMake(zero, CGRectGetMaxY(tipTwoTitleLabel.frame) + 8, labelW, twoSize.height) textStr:tipsTwo titleColor:SetColorRGBValue(0x666666, 1) FontSize:13];
//    tipTwoLabel.numberOfLines = 0;
//    [self.tipsScrollView addSubview:tipTwoLabel];
//    
//    self.tipsScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(tipTwoLabel.frame));
//    
//    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 45.5, self.frame.size.width, 0.5)];
//    lineV.backgroundColor = SetColorRGBValue(0xdddddd, 1);
//    [self addSubview:lineV];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, self.frame.size.height - 45, self.frame.size.width, 45);
//    [button setTitle:@"我知道了" forState:UIControlStateNormal];
//    [button setTitleColor:SetColorRGBValue(0xff6600, 1) forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [button setBackgroundImage:[UIImage imageWithColor:SetColorRGBValue(0xdddddd, 1) size:CGSizeMake(labelW, 45)] forState:UIControlStateHighlighted];
//    self.sureBtn = button;
//    [self addSubview:self.sureBtn];
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


@end
