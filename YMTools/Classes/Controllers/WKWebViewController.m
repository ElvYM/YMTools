//
//  WKWebViewController.m
//  YMTools
//
//  Created by jike on 2018/1/5.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (strong, nonatomic)WKWebView * webView;

@property (strong, nonatomic)UIProgressView * progressView;
@end

@implementation WKWebViewController



#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - private methods
- (void)commonInit {
    
}

- (void)configUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"调起JS" style:UIBarButtonItemStyleDone target:self action:@selector(runJSFunction)];
    
    YMWeakSelf(self);
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    //初始化偏好设置属性：preferences
    config.preferences = [WKPreferences new];
    //The minimum font size in points default is 0;
    config.preferences.minimumFontSize = 10;
    //是否支持JavaScript
    config.preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    // 自适应屏幕宽度js
//    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    [userContentController addUserScript:wkUserScript];
    
    //通过JS与webView内容交互
    config.userContentController = [WKUserContentController new];
    // 注入JS对象名称senderModel，当JS通过senderModel来调用时，我们可以在WKScriptMessageHandler代理中接收到
    
    [config.userContentController addScriptMessageHandler:weakself name:@"senderModel"];
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    NSURL *path = nil;
    path = [[NSBundle mainBundle] URLForResource:@"WKWebViewText" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
    [self.view addSubview:self.webView];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    [self addObserve];
    
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
    
}


- (void)addObserve {
    [_webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

// -MARK:OC调起JS方法
- (void)runJSFunction {
    NSString *js = @"tips('💊🐺🐩🐔')";//可以向js传参数
    //NSString *js = @"callJsAlert()";//无参数方法
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", response, error);
        NSLog(@"call js alert by native");
    }];
}

- (void)calliOS {
    
}

#pragma mark - CustomDelegate
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loading"])
    {
        NSLog(@"loading");
        
    } else if ([keyPath isEqualToString:@"title"])
    {
        self.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        NSLog(@"progress: %f", self.webView.estimatedProgress);
//        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading)
    {
        [UIView animateWithDuration:0.5 animations:^{
//            self.progressView.alpha = 0.0;
        }];
    }
}

#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //这里可以通过name处理多组交互
    if ([message.name isEqualToString:@"senderModel"]) {
        //body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
        NSLog(@"%@",message.body);
    }
}
#pragma mark = WKNavigationDelegate
//在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    NSURL *url = navigationAction.request.URL;
    
    NSLog(@"\nname--%@\nurl--%@",hostname,url);
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        && [url.relativeString containsString:@"http:"]) {
        // 对于跨域，需要手动跳转
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:navigationAction.request.URL]];
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyAllow);
        
    } else {
        self.progressView.alpha = 1.0;
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//在响应完成时，调用的方法。如果设置为不允许响应，web内容就不会传过来
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//接收到服务器跳转请求之后调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"title:%@",webView.title);
    
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    
}

#pragma mark WKUIDelegate

//alert 警告框
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"调用alert提示框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"alert message:%@",message);
    
}

//confirm 确认框
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:@"调用confirm提示框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"confirm message:%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:@"调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}
#pragma mark - event response    

- (void)ocLog {
    NSLog(@"oclog~~~");
}

#pragma mark - getters and setters

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
