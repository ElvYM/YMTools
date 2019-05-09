//
//  YMGuidancePageCell.m
//  YMTools
//
//  Created by longxian on 2018/7/11.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "YMGuidancePageCell.h"

@implementation YMGuidancePageCell
//init way
-(instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}


//init func
- (void)commonInit {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.finishBtn];
}

// MARK: - layoutSubviews
-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    
    [self.finishBtn sizeToFit];
    
    CGFloat margin = 5.f;
    CGFloat btnH = self.finishBtn.bounds.size.height + 2 * margin;
    CGFloat btnW = self.finishBtn.bounds.size.width + 2*margin;
    CGFloat btnX = (self.bounds.size.width - btnW)/2;
    CGFloat btnY = self.bounds.size.height - 100.f - btnH;
    self.finishBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
}


// MARK: - Setter & Getter
-(UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView = imageView;
    }
    return _imageView;
}

-(UIButton *)finishBtn {
    if (!_finishBtn) {
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor flatBlueColor];
        btn.layer.cornerRadius = 5.f;
        btn.layer.masksToBounds = YES;
        _finishBtn = btn;
    }
    return _finishBtn;
}

@end
