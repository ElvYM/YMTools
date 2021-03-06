//
//  YMTabBarController.m
//  YMTools
//
//  Created by longxian on 2018/4/4.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "YMTabBarController.h"
#import "ViewController.h"
#import "MainNavViewController.h"
#import "ShowUIListViewController.h"

@interface YMTabBarController ()<UITabBarControllerDelegate>

@end

@implementation YMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor cyanColor].flatten;
    [self addTabarItems];
    [self addChildViewControllers];
    self.delegate = self;
}

- (void)addChildViewControllers
{
    UINavigationController *one = [[MainNavViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
     
    UINavigationController *two = [[MainNavViewController alloc] initWithRootViewController:[[ShowUIListViewController alloc] init]];
    
    UINavigationController *three = [[MainNavViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    UINavigationController *four = [[MainNavViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    UINavigationController *five = [[MainNavViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    self.viewControllers = @[one, two, three, five, four];
    
}
- (void)addTabarItems
{
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"测试",
                                                 CYLTabBarItemImage : @"tabBar_essence_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"UI模块",
                                                  CYLTabBarItemImage : @"tabBar_friendTrends_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_friendTrends_click_icon",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"实例",
                                                 CYLTabBarItemImage : @"tabBar_new_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_new_click_icon",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"分享",
                                                  CYLTabBarItemImage : @"tabBar_me_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_me_click_icon"
                                                  };
    NSDictionary *fifthTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"更多",
                                                 CYLTabBarItemImage : @"tabbar_discover",
                                                 CYLTabBarItemSelectedImage : @"tabbar_discover_highlighted"
                                                 };
    self.tabBarItemsAttributes = @[    firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       fifthTabBarItemsAttributes
                                       ];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
