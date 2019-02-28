//
//  UIButton+Fast.m
//  YMTools
//
//  Created by Y on 2018/11/29.
//  Copyright © 2018 YM. All rights reserved.
//

#import "UIButton+Fast.h"

@implementation UIButton (Fast)
+ (UIButton *)fas_make:(void(^)(UIButton *make))block {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    block(btn);
    return btn;
}

-(UIButton * _Nonnull (^)(CGRect))f_frame {
    return ^(CGRect rect) {
        self.frame = rect;
        return self;
    };
}

-(UIButton * _Nonnull (^)(UIColor * _Nonnull))f_bgColor  {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

-(UIButton * _Nonnull (^)(NSString * _Nonnull, UIControlState))f_title {
    return ^(NSString *title, UIControlState state) {
        [self setTitle:title forState:state];
        return self;
    };
}

-(UIButton * _Nonnull (^)(UIColor * _Nonnull, UIControlState))f_titleColor {
    return ^(UIColor *color, UIControlState state) {
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (UIButton * _Nonnull (^)(CGFloat))f_titleFontSize {
    return ^(CGFloat size) {
        self.titleLabel.font = [UIFont systemFontOfSize:size];
        return self;
    };
}

-(UIButton * _Nonnull (^)(UIImage * _Nonnull, UIControlState))f_img {
    return ^(UIImage *image, UIControlState state) {
        [self setImage:image forState:state];
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIImage * _Nonnull, UIControlState))f_bgImg {
    return ^(UIImage *image, UIControlState state) {
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

#pragma mark - AddTarget
- (UIButton * _Nonnull (^)(id , SEL _Nonnull, UIControlEvents))f_addTarget {
    return ^(id target, SEL sel, UIControlEvents event) {
        [self addTarget:target action:sel forControlEvents:event];
        return self;
    };
}

-(UIButton * _Nonnull (^)(id _Nonnull, SEL _Nonnull))f_addTargetEventTouchUpInside {
    return ^(id target, SEL sel) {
        [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}



//- (void)test {
//    NSLog(@"这是哪???");
//}

#pragma mark - EdgeInsets
- (UIButton * _Nonnull (^)(UIEdgeInsets))f_contentInsets {
    return ^(UIEdgeInsets inset) {
        self.contentEdgeInsets = inset;
        return self;
    };
}

-(UIButton * _Nonnull (^)(UIEdgeInsets))f_titleInsets {
    return ^(UIEdgeInsets inset) {
        self.titleEdgeInsets = inset;
        return self;
    };
}

-(UIButton * _Nonnull (^)(UIEdgeInsets))f_imageInsets {
    return ^(UIEdgeInsets inset) {
        self.imageEdgeInsets = inset;
        return self;
    };
}

#pragma mark - Delay点击
-(UIButton * _Nonnull (^)(CGFloat))f_delayTime {
    return ^(CGFloat seconds) {
        self.jp_acceptEventInterval = seconds;
        return self;
    };
}

/*
 UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 [button setBackgroundColor:[UIColor cyanColor]];
 [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 [button setTitle:<#titleStr#> forState:UIControlStateNormal];
 button.frame = CGRectMake(<#x#>, <#y#>, <#width#>, <#height#>);
 [button addTarget:self action:@selector(<#funcName#>) forControlEvents:UIControlEventTouchUpInside];
 */

@end
