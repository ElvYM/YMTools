//
//  UICollectionView+Fast.h
//  YMTools
//
//  Created by Y on 2018/12/3.
//  Copyright © 2018 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Fast)

//UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:<#(CGRect)#> collectionViewLayout:<#(nonnull UICollectionViewLayout *)#>]

@property (copy, nonatomic, readonly)UICollectionView *(^f_frame)(CGRect frame);
@property (copy, nonatomic, readonly)UICollectionView *(^f_delegate_datesource)(id delegate);
@property (copy, nonatomic, readonly)UICollectionView *(^f_showsVerticalScrollIndicator)(BOOL isShow);

//register
@property (copy, nonatomic, readonly)UICollectionView *(^f_registerClass)(Class name);
@property (copy, nonatomic, readonly)UICollectionView *(^f_registerNib)(Class name);
@property (copy, nonatomic, readonly)UICollectionView *(^f_registerClassAndIdenti)(Class name,NSString *identi);
@property (copy, nonatomic, readonly)UICollectionView *(^f_registerNibAndIdenti)(Class name,NSString *identi);
@property (copy, nonatomic, readonly)UICollectionView *(^f_registerHeader)(Class name,NSString *identi);
@property (copy, nonatomic, readonly)UICollectionView *(^f_registerFooter)(Class name,NSString *identi);


+ (UICollectionView *)fas_makeLayout:(UICollectionViewLayout *)layout :(void(^)(UICollectionView *make))block;



@end

NS_ASSUME_NONNULL_END
