//
//  NSURLSessionViewController.m
//  YMTools
//
//  Created by jike on 17/4/24.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "NSURLSessionViewController.h"

static NSString *urlStr = @"http://lcatapi.lmboss.com/API/Cart/GetShopcart?communityid=134&username=13166060308&shopuser=";

@interface NSURLSessionViewController ()<NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSessionDownloadTask * downloadTask;

@property (nonatomic, strong) NSData * resumData;

@property (nonatomic, strong) NSURLSession * session;

@property (weak, nonatomic) IBOutlet UIProgressView *proessView;
/** 创建文件句柄 */
@property (nonatomic, strong) NSFileHandle *handle;
/** 文件的总大小 */
@property (nonatomic, assign) NSInteger totalSize;
/** 当前下载数据大小 */
@property (nonatomic, assign) NSInteger currentSize;
/** 获得文件全路径 */
@property (nonatomic, strong) NSString *fullPath;
/** 创建Task */
@property (nonatomic, strong)  NSURLSessionDataTask *dataTask;
/** 创建会话对象 */
@end

@implementation NSURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self urlSessionGet];
//    [self urlSessionPost];
    [self urlSessionDownloadByWayDelegate];
}


/**
 get
 */
- (void)urlSessionGet {
    //确定请求路径
    NSURL *getUrl = [NSURL URLWithString:urlStr];
    
    // 创建NSURLSession对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 根据对象创建Tsak请求
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:getUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解析服务器返回的数据
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        //默认在子线程中解析数据
        NSLog(@"%@",[NSThread currentThread]);
    }];
    // 执行
    [dataTask resume];
    
    //[dataTask cancel];// 取消任务
    //[dataTask suspend];// 暂停任务
}


/**
 post
 */
- (void)urlSessionPost {
    NSURL *getUrl = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:getUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    //设置请求方法
    request.HTTPMethod = @"POST";
    
    //设置请求体
    request.HTTPBody = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    // 设置 请求超时
    //request.timeoutInterval = 10;
    
    // 创建task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    // 执行
    [dataTask resume];
}


/**
 NSURLSessionDownloadTask 大文件下载
 */
- (void)urlSessionDownloadByWayBlock {
    // 1.确定URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_03.png"];
    // 2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.创建Task
    /**
     downloadTaskWithRequest: Block方式
     注意:该方法内部已经实现了边接受数据边写入沙盒(tmp临时文件目录)的操作,
     需要剪切文件,把它移动到我们指定的位置。
     
     */
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 6.数据解析
        NSLog(@"%@---%@",location,[NSThread currentThread]);
        // 7.拼接文件全路径
        // 拼接文件后的本地名称:FileName @"123.png"或 [url lastPathComponent] 获取URL最后一个字节命名
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]];
        // 8.剪切文件
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
        NSLog(@"%@",fullPath);
    }];
    // 执行task
    [downloadTask resume];
}


/**
 遵守<NSURLSessionDownloadDelegate>协议，实现代理方法。可以在didWriteData(写数据)代理方法，监听下载进度
 */
- (void)urlSessionDownloadByWayDelegate {
    NSURL *url = [NSURL URLWithString:@"[http://120.25.226.186:32812/resources/images/minion_03.png"];
    // Configuration:配置信息,用默认的即可
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:[NSURLRequest requestWithURL:url]];
    [downloadTask resume];// 执行Task
}



#pragma mark - 断点下载
/*
 局限性:
 1.如果用户点击暂停之后退出程序，那么需要把恢复下载的数据写一份到沙盒，代码复杂度高
 2.如果用户在下载中途未保存恢复下载数据即退出程序，则不具备可操作性
 */
// 开始下载
- (IBAction)starBtnClick:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    self.downloadTask = [self.session downloadTaskWithRequest:[NSURLRequest requestWithURL:url]];
    [self.downloadTask resume];
}
// 暂停下载(是可以恢复的)
- (IBAction)suspendBtnClick:(id)sender {
    NSLog(@"+++++++++++++++++++暂停");
    [self.downloadTask suspend];
}
// 取消下载(注意)
// cancel:取消是不能恢复
// cancelByProducingResumeData:是可以恢复
- (IBAction)cancelBtnClick:(id)sender {
    NSLog(@"+++++++++++++++++++取消");
    //[self.downloadTask cancel];
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumData = resumeData;
    }];
}
// 继续下载
- (IBAction)goOnBtnClick:(id)sender {
    NSLog(@"+++++++++++++++++++继续下载");
    if (self.resumData) {
        // 恢复下载数据(文件保存信息,保存到那个字节) != 文件数据
        self.downloadTask = [self.session downloadTaskWithResumeData:self.resumData];
    }
    [self.downloadTask resume];
}

/**
 1.写数据(监听下载进度)
 session 会话对象
 downloadTask 下载任务
 bytesWritten 本次写入的数据大小
 totalBytesWritten 下载的数据总大小
 totalBytesExpectedToWrite 文件的总大小
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 获得文件的下载进度
    NSLog(@"%f",1.0 * totalBytesWritten/totalBytesExpectedToWrite);
}
/**
 2.当恢复下载的时候调用方法
 fileOffset 从什么地方下载
 expectedTotalBytes 文件的总大小
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"恢复下载--%s",__func__);
}
/**
 3.当下载完成的时候调用
 location 文件的临时存储路径
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"文件的临时存储路径--%@",location);
    
    // 1.拼接文件全路径
    // downloadTask.response.suggestedFilename 文件名称
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 2.剪切文件
    [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    NSLog(@"%@",fullPath);
}

#pragma mark -- NSURLSessionDataTask 断点下载 | 支持离线
/*
 NSURLSessionDataTask 实现大文件
 1.开始下载、暂停下载、取消下载、恢复下载
 2.支持后台下载|上传（离线 断点）
 3.在处理下载任务的时候可以直接把数据下载到磁盘
 4.下载的时候﻿是子线程异步处理，效率更高
 */
-(NSString *)fullPath {
    if (!_fullPath) {
        // 获得文件全路径
        // 拼接文件后的本地名称 FileName @"123.mp4" 或者 [url lastPathComponent] 获取URL最后一个字节命名
        _fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[urlStr lastPathComponent]];
    }
    return _fullPath;
}
-(NSURLSession *)session {
    if (!_session) {
        // 创建会话对象,设置代理
        /*
         Configuration:配置信息 [NSURLSessionConfiguration defaultSessionConfiguration]
         delegate:代理
         delegateQueue:设置代理方法在哪个线程中调用
         */
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
-(NSURLSessionDataTask *)dataTask {
    if (!_dataTask) {
        // 1.确定url
        NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
        
        // 2.创建请求对象
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // 3 设置请求头信息,告诉服务器请求那一部分数据
        self.currentSize = [self getFileSize];
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        // 4.创建Task
        _dataTask = [self.session dataTaskWithRequest:request];
    }
    return _dataTask;
}
-(NSInteger)getFileSize {
    // 获得指定文件路径对应文件的数据大小
    NSDictionary *fileInfoDict = [[NSFileManager defaultManager]attributesOfItemAtPath:self.fullPath error:nil];
    NSLog(@"%@",fileInfoDict);
    NSInteger currentSize = [fileInfoDict[@"NSFileSize"] integerValue];
    
    return currentSize;
}

#pragma mark - NSURLSessionDataDelegate
// 1.接收到服务器的响应 它默认会取消该请求
/**
 session 会话对象
 dataTask 请求任务
 response 响应头信息
 completionHandler 回调 传给系统
 expectedContentLength 本次请求的数据大小
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 获得文件的总大小
    self.totalSize = response.expectedContentLength + self.currentSize;
    
    if (self.currentSize == 0) {
        // 创建空的文件
        [[NSFileManager defaultManager]createFileAtPath:self.fullPath contents:nil attributes:nil];
    }
    // 创建文件句柄
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
    
    // 移动指针(每接收到服务器的响应，就移动指针指向文件末尾)
    [self.handle seekToEndOfFile];
    
    /*
     NSURLSessionResponseCancel = 0,取消 默认
     NSURLSessionResponseAllow = 1,接收
     NSURLSessionResponseBecomeDownload = 2,变成下载任务
     NSURLSessionResponseBecomeStream 变成流
     */
    completionHandler(NSURLSessionResponseAllow);
}
// 2.接收到服务器返回的数据 调用多次
/**
 session 会话对象
 dataTask 请求任务
 data 本次下载的数据
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    // 写入数据到文件
    [self.handle writeData:data];
    
    // 计算文件的下载进度
    self.currentSize += data.length;
    NSLog(@"%f",1.0 * self.currentSize / self.totalSize);
    
    self.proessView.progress = 1.0 * self.currentSize / self.totalSize;
}
// 3.请求完成 或者 失败的时候调用
/**
 session  会话对象
 dataTask 请求任务
 error    错误信息
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 关闭文件句柄（创建句柄,要记得在完成方法里 关闭句柄置空）
    [self.handle closeFile];
    self.handle = nil;
    NSLog(@"%@",self.fullPath);
}
// 4.清理工作
/**
 NSURLSession,如果设置代理的话会有一个强引用不会被释放掉,当不用Session的时候，
 一定要调用finishTasksAndInvalidate 和 invalidateAndCancel 释放掉.
 */
-(void)dealloc {
    //finishTasksAndInvalidate
    [self.session invalidateAndCancel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
