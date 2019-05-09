//
//  iPhoneXConst.h
//  LazyCat
//
//  Created by longxian on 2018/3/15.
//  Copyright © 2018年 zhanshu. All rights reserved.
//

#ifndef iPhoneXConst_h
#define iPhoneXConst_h


//iPhone X Const
// status bar height.


#define  kStatusBarHeight      (IS_iPhoneX ? 44.f : 20.f)


// Navigation bar height.


#define  kNavigationBarHeight  44.f


// Navigation Safe Top Margin

#define kNavigationSafeTopMargin (IS_iPhoneX ? 44.f : 0.f)

// Tabbar height.


#define  kTabbarHeight         (IS_iPhoneX ? (49.f+34.f) : 49.f)


// Tabbar safe bottom margin.


#define  kTabbarSafeBottomMargin         (IS_iPhoneX ? 34.f : 0.f)


// Status bar & navigation bar height.


#define  kStatusBarAndNavigationBarHeight  (IS_iPhoneX ? 88.f : 64.f)


#define kTabbarHeight49 49.f

//判断是否iPhone X

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


// iOS11弃用了automaticallyAdjustsScrollViewInsets属性，取而代之的是UIScrollView新增了contentInsetAdjustmentBehavior属性。所以要区分开来
#define adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)


#endif /* iPhoneXConst_h */
