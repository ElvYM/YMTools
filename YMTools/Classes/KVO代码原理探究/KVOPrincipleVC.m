//
//  KVOPrincipleVC.m
//  YMTools
//
//  Created by jike on 2018/1/8.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "KVOPrincipleVC.h"
// custom kvo
#import "NSObject+KVO.h"
@interface KVOPrincipleVC ()

@end

@implementation KVOPrincipleVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self customKvoTest];
    [self thePrincipleOfKVO];
}

#pragma mark - Custom KVO test
- (void)customKvoTest {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.titleLabel.text = @"KVO TEST";
    btn.backgroundColor = [UIColor cyanColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.p = [KVOPerson new];
    [self.p YM_addObserver:self forKey:NSStringFromSelector(@selector(cat)) withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        NSLog(@"%@.%@ is now: %@ | oldValue is %@", observedObject, observedKey, newValue,oldValue);
    }];
    self.p.cat = @"A_";
}

- (void)click {
    self.p.cat = [self.p.cat stringByAppendingString:@"A_"];
}

#pragma mark - thePrincipleOfKVO
- (void)thePrincipleOfKVO {
    self.p = [KVOPerson new];
    self.d = @"LeLe";
    self.c = @"Tom";
    
    //开始监听：第一个断点位置
    [self.p addObserver:self forKeyPath:@"aDog" options:(NSKeyValueObservingOptionNew) context:nil];
    [self.p addObserver:self forKeyPath:@"aCat" options:(NSKeyValueObservingOptionNew) context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到了 <%@> 的改变",keyPath);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //寄养狗
    [self.p careDog:self.d];
    
    //拥有猫
    self.p.cat = self.c;
    
    
}

-(void)dealloc {
    //移除KVO
    [self.p removeObserver:self forKeyPath:@"aDog"];
    [self.p removeObserver:self forKeyPath:@"aCat"];
    NSLog(@"KVOPrincipleDealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
