//
//  YMTabBarController.m
//  YMTools
//
//  Created by longxian on 2018/4/4.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "YMTabBarController.h"
#import "ViewController.h"


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
    UINavigationController *one = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    UINavigationController *two = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    UINavigationController *three = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    UINavigationController *four = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    UINavigationController *five = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    self.viewControllers = @[two, one, three, five, four];
    
}
- (void)addTabarItems
{
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"测试",
                                                 CYLTabBarItemImage : @"tabBar_essence_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"预演",
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
    self.tabBarItemsAttributes = @[    secondTabBarItemsAttributes,
                                       firstTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fifthTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
