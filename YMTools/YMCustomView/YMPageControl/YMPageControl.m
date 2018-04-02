//
//  YMPageControl.m
//  LazyCat
//
//  Created by jike on 17/8/23.
//  Copyright © 2017年 zhanshu. All rights reserved.
//

#import "YMPageControl.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define SetColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface YMPageControl()
@property (strong, nonatomic)UIView *selectedView;
@end
@implementation YMPageControl
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 根据总页数创建pageControl

 @param totalCount totalCount
 */
-(void)setTotalCount:(NSInteger)totalCount {
    _totalCount = totalCount;
    if (_totalCount <= 1) {
        self.hidden = YES;
    }else {
        self.hidden = NO;
    }
    CGFloat space = 5;
    CGFloat width = 10;
    CGFloat height = 2;
    
    CGFloat startY = (ScreenWidth - (totalCount - 1) * (space + width) - width) / 2.0;
    for (int i = 0; i < totalCount; i++) {
        UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(startY + i * (space + width) , space, width, height)];
        pointView.backgroundColor = SetColor(255, 255, 255, 0.5);
        pointView.tag = 100 + i;
        if (i == 0) {
            pointView.backgroundColor = [UIColor whiteColor];
            _selectedView = pointView;
        }
        [self addSubview:pointView];
    }
}

-(void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    _selectedView.backgroundColor = [UIColor whiteColor];
    UIView *currentView = [self viewWithTag:100 + currentIndex];
    currentView.backgroundColor = SetColor(255, 255, 255, 0.5);
    _selectedView = currentView;
}


@end
