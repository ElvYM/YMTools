//
//  YMPageControl.h
//  LazyCat
//
//  Created by jike on 17/8/23.
//  Copyright © 2017年 zhanshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMPageControl : UIView
/**
 the total count
 */
@property (assign, nonatomic)NSInteger totalCount;

/**
 set the currentIndex
 */
@property (assign, nonatomic)NSInteger currentIndex;

@end
