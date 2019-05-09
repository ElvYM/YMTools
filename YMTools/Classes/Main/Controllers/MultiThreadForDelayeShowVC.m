//
//  MultiThreadForDelayeShowVC.m
//  YMTools
//
//  Created by jike on 2017/11/13.
//  Copyright © 2017年 YM. All rights reserved.
//
/*
 iOS开发系列--并行开发其实很容易
 http://i1.umei.cc/uploads/tu/201710/9999/dd46f2a627.jpg
 
 **线程同步:
 
 *1.************************************************** 1.NSLock
 #pragma mark 请求图片数据
 -(NSData *)requestData:(int )index{
 NSData *data;
 NSString *name;
 //加锁
 [_lock lock];
 if (_imageNames.count>0) {
 name=[_imageNames lastObject];
 [_imageNames removeObject:name];
 }
 //使用完解锁
 [_lock unlock];
 if(name){
 NSURL *url=[NSURL URLWithString:name];
 data=[NSData dataWithContentsOfURL:url];
 }
 return data;
 }
 
 2.************************************************** 2.@synchronized代码块
 -(NSData *)requestData:(int )index{
 NSData *data;
 NSString *name;
 //线程同步
 @synchronized(self){
 if (_imageNames.count>0) {
 name=[_imageNames lastObject];
 [NSThread sleepForTimeInterval:0.001f];
 [_imageNames removeObject:name];
 }
 }
 if(name){
 NSURL *url=[NSURL URLWithString:name];
 data=[NSData dataWithContentsOfURL:url];
 }
 return data;
 }
 
  3.************************************************** 3.GCD信号量
 详见demo，其他两种方法只是更新了requestData方法
 
 使用GCD解决资源抢占问题:信号量，dispatch_semaphore_t
 */
#import "MultiThreadForDelayeShowVC.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
#define IMAGE_COUNT 9
@interface MultiThreadForDelayeShowVC ()
{
    NSMutableArray *_imageViews;
    NSLock *_lock;
    dispatch_semaphore_t _semaphore;//定义一个信号量
}
@property (atomic,strong) NSMutableArray *imageNames;
@end

@implementation MultiThreadForDelayeShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}
#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING) + 64, ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
            
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<IMAGE_COUNT; i++) {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }
    
    /*初始化信号量
     参数是信号量初始值
     */
    _semaphore=dispatch_semaphore_create(1);
    
}

#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(int )index{
    UIImage *image=[UIImage imageWithData:data];
    UIImageView *imageView= _imageViews[index];
    imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    NSData *data;
    NSString *name;
    
    /*信号等待
     第二个参数：等待时间
     */
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_imageNames.count>0) {
        name=[_imageNames lastObject];
        [_imageNames removeObject:name];
    }
    //信号通知
    dispatch_semaphore_signal(_semaphore);
    
    
    if(name){
        NSURL *url=[NSURL URLWithString:name];
        data=[NSData dataWithContentsOfURL:url];
    }
    
    return data;
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    int i=[index integerValue];
    //请求数据
    NSData *data= [self requestData:i];
    //更新UI界面,此处调用了GCD主线程队列的方法
    dispatch_queue_t mainQueue= dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        [self updateImageWithData:data andIndex:i];
    });
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    int count=ROW_COUNT*COLUMN_COUNT;
    //    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //这里创建一个并发队列（使用全局并发队列也可以）
    dispatch_queue_t queue=dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i=0; i<count; i++) {
        dispatch_async(queue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
    }
}

@end


