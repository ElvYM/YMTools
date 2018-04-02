//
//  YMCustomBtn.m
//  YMTools
//
//  Created by jike on 17/4/20.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "YMCustomBtn.h"


@implementation YMCustomBtn

-(instancetype)initWithFrame:(CGRect)frame
                    ImgFrame:(CGRect)imgFrame
                  TitleFrame:(CGRect)titleFrame
                     ImgName:(NSString *)imgName
                       Title:(NSString *)title
                   TitleFont:(CGFloat )titleFont
                  TitleColor:(UIColor *)titleColor {
    if(self=[super initWithFrame:frame]){
        _imgFrame     = imgFrame;
        _titleFrame   = titleFrame;
        [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:titleFont];
        self.titleLabel.textColor = titleColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    return _imgFrame;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return _titleFrame;
}
@end
