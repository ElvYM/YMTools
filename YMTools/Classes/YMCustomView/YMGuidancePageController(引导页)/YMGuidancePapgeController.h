//
//  YMGuidancePapgeController.h
//  YMTools
//
//  Created by longxian on 2018/7/11.
//  Copyright © 2018年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGuidancePageCell.h"

typedef void(^CellHandler)(YMGuidancePageCell *cell, NSIndexPath *indexPath);
typedef void(^FinishHandler)(UIButton *finishBtn);

@interface YMGuidancePapgeController : UIViewController

-(instancetype)initWithPagesCount:(NSInteger)count CellHandler:(CellHandler)cellHandler FinishHandler:(FinishHandler)finishHandler;

@property (strong, nonatomic, readonly) UIPageControl *pageControl;
@property (strong, nonatomic, readonly) UICollectionView *collectionView;
@property (assign, nonatomic, readonly) NSInteger count;

@end
