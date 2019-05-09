//
//  FBKVOViewController.m
//  YMTools
//
//  Created by jike on 2017/12/8.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "FBKVOViewController.h"
#import "Person.h"
@interface FBKVOViewController ()
@property (strong, nonatomic)FBKVOController * kvoController;
@property (strong, nonatomic)Person * person;
@end

@implementation FBKVOViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configFBKVO];
}

#pragma mark - private methods
- (void)configFBKVO {
    _person = [[Person alloc] init];
    _person.age = 0;
    
    // create KVO controller instance
    _kvoController = [FBKVOController controllerWithObserver:self];
    
    // handle clock change, including initial value
    [_kvoController observe:_person keyPath:@"age" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"change:%@",change);
    }];
}

#pragma mark - UITableViewDelegate

#pragma mark - CustomDelegate

#pragma mark - event response

- (IBAction)buttonClick:(UIButton *)sender {
    _person.age++;
}
#pragma mark - getters and setters
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
