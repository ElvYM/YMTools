//
//  VersionTipView.h
//  LazyCat
//
//  Created by longxian on 2018/5/2.
//  Copyright © 2018年 zhanshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VersionTipView : UIView
@property (copy, nonatomic)                    void(^sureBtnClickBlock)(void);
@property (copy, nonatomic)                    void(^nextBtnClickBlock)(void);
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Desc:(NSString *)desc;
- (void)hide;
@end
