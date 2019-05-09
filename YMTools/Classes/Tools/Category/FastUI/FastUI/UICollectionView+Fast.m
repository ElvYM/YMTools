//
//  UICollectionView+Fast.m
//  YMTools
//
//  Created by Y on 2018/12/3.
//  Copyright © 2018 YM. All rights reserved.
//

#import "UICollectionView+Fast.h"

@implementation UICollectionView (Fast)
//+ (UICollectionView *)fas_new:(void(^)(UICollectionView *make))block {
//    UIView *view = [UIView new];
//    block(view);
//    return view;
//}


+ (UICollectionView *)fas_makeLayout:(UICollectionViewLayout *)layout :(void(^)(UICollectionView *make))block {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    block(collectionView);
    return collectionView;
}



-(UICollectionView * _Nonnull (^)(CGRect))f_frame {
    return ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}
-(UICollectionView * _Nonnull (^)(id))f_delegate_datesource {
    return ^(id delegate) {
        self.delegate = delegate;
        self.dataSource = delegate;
        return self;
    };
}

-(UICollectionView * _Nonnull (^)(BOOL))f_showsVerticalScrollIndicator {
    return ^(BOOL isShow) {
        self.showsVerticalScrollIndicator = isShow;
        return self;
    };
}

#pragma mark - register
-(UICollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained))f_registerClass {
    return ^(Class name) {
        [self registerClass:[name class] forCellWithReuseIdentifier:NSStringFromClass(name)];
        return self;
    };
}

-(UICollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained))f_registerNib {
    return ^(Class name) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(name) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(name)];
        return self;
    };
}

-(UICollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))f_registerClassAndIdenti {
    return ^(Class name, NSString *identi) {
        [self registerClass:[name class] forCellWithReuseIdentifier:identi];
        return self;
    };
}

-(UICollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))f_registerNibAndIdenti {
    return ^(Class name,NSString *identi) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(name) bundle:nil] forCellWithReuseIdentifier:identi];
        return self;
    };
}

-(UICollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))f_registerHeader {
    return ^(Class name, NSString *identi) {
        [self registerClass:name forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identi];
        return self;
    };
}

-(UICollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))f_registerFooter {
    return ^(Class name, NSString *identi) {
        [self registerClass:name forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identi];
        return self;
    };
}

@end
