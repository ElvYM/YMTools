//
//  DoraemonSwitchView.m
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2018/6/13.
//

#import "DoraemonSwitchView.h"
#import "UIColor+DoreamonKit.h"
#import "UIView+Positioning.h"

@interface DoraemonSwitchView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *downLine;

@end

@implementation DoraemonSwitchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor doraemon_colorWithHexString:@"#666666"];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
        
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChange:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:_switchView];
        
        _topLine = [[UIView alloc] init];
        _topLine.hidden = YES;
        _topLine.backgroundColor = [UIColor doraemon_colorWithHexString:@"#22000000"];
        [self addSubview:_topLine];
        
        _downLine = [[UIView alloc] init];
        _downLine.hidden = YES;
        _downLine.backgroundColor = [UIColor doraemon_colorWithHexString:@"#22000000"];
        [self addSubview:_downLine];
    }
    return self;
}

- (void)renderUIWithTitle:(NSString *)title switchOn:(BOOL)on{
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(20, self.height/2-_titleLabel.height/2, _titleLabel.width, _titleLabel.height);
    
    _switchView.on = on;
    _switchView.frame = CGRectMake(self.width-20-_switchView.width, self.height/2-_switchView.height/2, _switchView.width, _switchView.height);
}

- (void)needTopLine{
    _topLine.hidden = NO;
    _topLine.frame = CGRectMake(0, 0, self.width, 0.5);
}

- (void)needDownLine{
    _downLine.hidden = NO;
    _downLine.frame = CGRectMake(0, self.height-0.5, self.width, 0.5);
}

- (void)switchChange:(UISwitch*)sender{
    BOOL on = sender.on;
    if (_delegate && [_delegate respondsToSelector:@selector(changeSwitchOn:)]) {
        [_delegate changeSwitchOn:on];
    }
}


@end
