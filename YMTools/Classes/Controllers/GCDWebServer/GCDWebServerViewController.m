//
//  GCDWebServerViewController.m
//  YMTools
//
//  Created by longxian on 2018/5/3.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "GCDWebServerViewController.h"
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>

//GCDWebUploader
#import <GCDWebUploader.h>

@interface GCDWebServerViewController ()

@end

@implementation GCDWebServerViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    

}

#pragma mark - private methods

/**
 实现一个简单的Http服务器
 */
- (void)test_buildTheGCDServer {
    GCDWebServer *webServer = [GCDWebServer new];
    [webServer addDefaultHandlerForMethod: @"GET" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        NSString *html = @"<html><body>欢迎访问 <b>im.ym@foxmail.com</b></body></html>";
        
        return [GCDWebServerDataResponse responseWithHTML:html];
    }];
    
    [webServer startWithPort:6565 bonjourName:@"GCD Web Server"];
    NSLog(@"服务器启动成功，请使用浏览器访问:%@",webServer.serverURL);
}

- (void)test_asynHttpServer {
    GCDWebServer *webServer = [GCDWebServer new];
    
    [webServer addDefaultHandlerForMethod:@"GET" requestClass:[GCDWebServerRequest class] asyncProcessBlock:^(__kindof GCDWebServerRequest * _Nonnull request, GCDWebServerCompletionBlock  _Nonnull completionBlock) {
        
        NSString *html = @"<html><body>欢迎访问 <b>im.ym@foxmail.com</b></body></html>";
        
        if (completionBlock) {
            completionBlock([GCDWebServerDataResponse responseWithHTML:html]);
        }
    }];
    
    
    [webServer startWithPort:6565 bonjourName:@"GCD Web Server"];
    NSLog(@"服务器启动成功，请使用浏览器访问:%@",webServer.serverURL);
}


/**
 form表单，可做登录或身份验证
 */
- (void)test_formHtmlHttpServer {
    GCDWebServer *webServer = [GCDWebServer new];
    
    //处理get请求：/（返回一个提交表单）
    [webServer addDefaultHandlerForMethod: @"GET" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        NSString *html = @"<html><body>"
        "<form name=\"input\" action=\"/\" method=\"post\" "
        "enctype=\"application/x-www-form-urlencoded\"> "
        "用户名: <input type=\"text\" name=\"username\">"
        "<input type=\"submit\" value=\"提交\">"
        "</form>"
        "</body></html>";
        
        return [GCDWebServerDataResponse responseWithHTML:html];
    }];
    
    //处理post请求：/（获取提交的表单数据，并返回结果）
//    [webServer addDefaultHandlerForMethod: @"POST" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
//
//        NSString *html = @"<html><body>"
//        "<form name=\"input\" action=\"/\" method=\"post\" "
//        "enctype=\"application/x-www-form-urlencoded\"> "
//        "用户名: <input type=\"text\" name=\"username\">"
//        "<input type=\"submit\" value=\"提交\">"
//        "</form>"
//        "</body></html>";
//
//        return [GCDWebServerDataResponse responseWithHTML:html];
//    }];
    
    [webServer startWithPort:6565 bonjourName:@"GCD Web Server"];
    NSLog(@"服务器启动成功，请使用浏览器访问:%@",webServer.serverURL);
}

#pragma mark - WebServerDEMO


#pragma mark - UITableViewDelegate

#pragma mark - CustomDelegate

#pragma mark - event response

#pragma mark - getters and setters
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
