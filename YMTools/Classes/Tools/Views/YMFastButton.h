//
//  YMFastButton.h
//  YMTools
//
//  Created by longxian on 2018/7/27.
//  Copyright © 2018年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageDirection) {
    ImageDirectionTop,
    ImageDirectionBottom,
    ImageDirectionRight,
    ImageDirectionLeft
};

@interface YMFastButton : UIButton

@property (nonatomic) ImageDirection imageDirection;

@end
