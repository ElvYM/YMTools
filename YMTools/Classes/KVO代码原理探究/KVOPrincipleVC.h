//
//  KVOPrincipleVC.h
//  YMTools
//
//  Created by jike on 2018/1/8.
//  Copyright © 2018年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVOPerson.h"
@interface KVOPrincipleVC : UIViewController
//人
@property (strong, nonatomic)KVOPerson * p;

//狗
@property (strong, nonatomic)NSString * d;

//猫
@property (strong, nonatomic)NSString * c;
@end
