//
//  WebViewController.m
//  YMTools
//
//  Created by longxian on 2018/3/27.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic, retain) UIWebView *webV; // webView
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"调起JS" style:UIBarButtonItemStyleDone target:self action:@selector(runJSFunction)];
    
    self.webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, MainScreenWidth, MainScreenHeight)];
    self.webV.delegate = self;
    [self.webV.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 64, 0)];
    [self.webV.scrollView setBounces:YES];
    self.webV.backgroundColor = [UIColor clearColor];
    self.webV.opaque = NO;
    [self.view addSubview:self.webV];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"WKWebViewText.html" ofType:nil];
    [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
}

// -MARK:OC调起JS方法
- (void)runJSFunction {
    NSString *js = @"tips('💊🐺🐩🐔')";//可以向js传参数
    //NSString *js = @"callJsAlert()";//无参数方法

    //第一种方法该方法会同步返回一个字符串，因此是一个同步方法，可能会阻塞UI。
//    [self.webV stringByEvaluatingJavaScriptFromString:js];
    
    
    // 第二种方法
    JSContext *context = [self.webV valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context evaluateScript:js];
}


-(void)webViewDidStartLoad:(UIWebView *)webView {
    
}

// -MARK:JS调用OC方法
-(void)webViewDidFinishLoad:(UIWebView *)webView {
#pragma webView下JS调用OC方法，并传参
    JSContext *jsContext = [self.webV valueForKeyPath:
                            @"documentView.webView.mainFrame.javaScriptContext"];
    /**
     calliOS方法
     */
    jsContext[@"calliOS"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (JSValue *obj in args) {
            NSLog(@"--%@", obj);
        }
    };
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
