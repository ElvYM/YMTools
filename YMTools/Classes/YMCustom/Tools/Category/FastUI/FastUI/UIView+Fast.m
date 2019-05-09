//
//  UIView+Fast.m
//  YMTools
//
//  Created by Y on 2018/11/30.
//  Copyright © 2018 YM. All rights reserved.
//

#import "UIView+Fast.h"

#define ColorHex(rgbValue,a) [UIColor colorWithRed:((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float) ((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float) (rgbValue & 0xFF)) / 255.0 alpha:a]

@implementation UIView (Fast)


+ (UIView *)fas_make:(void(^)(UIView *make))block {
    UIView *view = [UIView new];
    block(view);
    return view;
}

+ (UIView *)f_init {
    return [UIView new];
}

-(UIView * _Nonnull (^)(CGRect))f_frame {
    return ^(CGRect rect) {
        self.frame = rect;
        return self;
    };
}

-(UIView * _Nonnull (^)(UIColor * _Nonnull))f_bgColor  {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

#pragma mark - Custom View
-(UIView * _Nonnull (^)(CGRect))f_lineView {
    return ^(CGRect frame) {
        self.frame = frame;
        self.backgroundColor = ColorHex(0xe0e0e0, 1);
        return self;
    };
    
}
@end
