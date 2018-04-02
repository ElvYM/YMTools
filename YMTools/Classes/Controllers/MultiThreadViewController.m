//
//  MultiThreadViewController.m
//  YMTools
//
//  Created by jike on 17/6/19.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "MultiThreadViewController.h"

@interface MultiThreadViewController ()

@end

@implementation MultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self longTimeTest];
//    [self groupThread];
    [self GCDGroupContainSubThread];
}

- (void)longTimeTest {
    // 1、创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    // 2、将任务添加到队列，并且指定同步执行
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"%@-0-%d",[NSThread currentThread],i);
        });
    }
    //结论:并发队列，同步执行，不开线程，顺序执行
    
    // 2、将任务添加到队列，并且指定异步执行
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@-1-%d",[NSThread currentThread],i);
        });
    }
    
    //结论：串行队列，异步执行，开启一条新的线程，按顺序执行
    
    //并发队列
    // 1. 创建并发队列
    dispatch_queue_t queueA = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    // 2. 将任务添加到队列, 并且指定同步执行
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queueA, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    //结论:并发队列，同步执行，不开线程，顺序执行
    
    //
    // 2. 将任务添加到队列, 并且指定同步执行
    for (int i = 0; i < 10; i++) {
        dispatch_async(queueA, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    //结论：开启足够多的线程，不按照顺序执行
}


/**
 //a,b,c,d 4个一步请求，如何判断a,b,c,d都完成执行？如果a,b,c,d顺序执行，改如何实现
 */
- (void)groupThread {
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    //1.通过GCD的group实现
//    NSString *url = @"http://lcatapi.lmboss.com/API/Home/GetIndex?&communityid=3";
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{ /*任务a */
        NSLog(@"a is begin");
        sleep(13);
        NSLog(@"a is done");
//        NSLog(@"a is begin");
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//            NSLog(@"a sub is done");
//            sleep(1);
//            NSLog(@"a is done");
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        }];
    });
    dispatch_group_async(group, queue, ^{ /*任务b */
        NSLog(@"b is begin");
        sleep(2);
        NSLog(@"b is done");
    });
    dispatch_group_async(group, queue, ^{ /*任务c */
        NSLog(@"c is begin");
        sleep(3);
        NSLog(@"c is done");
    });
    dispatch_group_async(group, queue, ^{ /*任务d */
        NSLog(@"d is begin");
        sleep(4);
        NSLog(@"d is done");
    });
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        // 在a、b、c、d异步执行完成后，会回调这里
        NSLog(@"all done");
    });
}

/**
 GCD群组任务中有异步子线程的情况下
 */
- (void)GCDGroupContainSubThread {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    // 请求一
    NSString *url = @"http://lcatapi.lmboss.com/API/Home/GetIndex?&communityid=3";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"a sub is done");
        
        //离开
        dispatch_group_leave(group);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {}];
    NSLog(@"a is done");
    
    dispatch_group_enter(group);
    //请求二
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"b sub is done");
        
        //离开
        dispatch_group_leave(group);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {}];
    NSLog(@"b is done");
    
    //
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //请求完毕后的处理
        NSLog(@"group done!");
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
