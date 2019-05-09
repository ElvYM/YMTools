//
//  UILabel+Fast.m
//  YMTools
//
//  Created by Y on 2018/11/28.
//  Copyright © 2018 YM. All rights reserved.
//

#import "UILabel+Fast.h"
/*
 return ^(<#Class#> <#name#>) {
 
 return self;
 };
 */
@implementation UILabel (Fast)

+ (UILabel *)fas_make:(void(^)(UILabel *))block; {
    UILabel *label = [UILabel new];
    block(label);
    return label;
}

-(UILabel * _Nonnull (^)(CGRect))f_frame {
    return ^(CGRect rect) {
        self.frame = rect;
        return self;
    };
}

-(UILabel * _Nonnull (^)(UIColor * _Nonnull))f_bgColor  {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

-(UILabel * _Nonnull (^)(UIColor * _Nonnull))f_textColor {
    return ^(UIColor *color) {
        self.textColor = color;
        return self;
    };
}

-(UILabel * _Nonnull (^)(NSString * _Nonnull))f_text {
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}

#pragma mark - Font
-(UILabel * _Nonnull (^)(UIFont * _Nonnull))f_font {
    return ^(UIFont *font) {
        self.font = font;
        return self;
    };
}

-(UILabel * _Nonnull (^)(CGFloat))f_fontSize {
    return ^(CGFloat size) {
        self.font = [UIFont systemFontOfSize:size];
        return self;
    };
}

-(UILabel * _Nonnull (^)(CGFloat))f_boldFont {
    return ^(CGFloat size) {
        self.font = [UIFont boldSystemFontOfSize:size];
        return self;
    };
}

-(UILabel * _Nonnull (^)(NSString * _Nonnull, CGFloat))f_fontNameSize {
    return ^(NSString *name , CGFloat size) {
        self.font = [UIFont fontWithName:name size:size];
        return self;
    };
}

#pragma mark - textAlignment

-(UILabel * _Nonnull (^)(NSTextAlignment))f_textAlignment {
    return ^(NSTextAlignment textAlignment) {
        self.textAlignment = textAlignment;
        return self;
    };
}




@end
