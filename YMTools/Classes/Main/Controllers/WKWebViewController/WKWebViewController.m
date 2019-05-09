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

#import "JPVideoPlayerDetailViewController.h"

#import "VideoModle.h"

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
- (void)back {
        if ([_webView canGoBack]) {
            [_webView goBack];
        }
}
- (void)configUI {
//    self.navigationItem.rightBarButtonItem = ;
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"调起JS" style:UIBarButtonItemStyleDone target:self action:@selector(runJSFunction)],
                                                [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(back)]];;
    
    YWeak(self);
    
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
    
    // 添加JS调用OC的方法名
    [config.userContentController addScriptMessageHandler:weakself name:@"senderModel"];
    [config.userContentController addScriptMessageHandler:weakself name:@"calliOS"];
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    NSURL *path = nil;
    path = [[NSBundle mainBundle] URLForResource:@"WKWebViewText" withExtension:@"html"];
    /*
     https://www.panda.tv
     https://www.douyu.com
     http://www.yy.com
     https://www.pearvideo.com
     */
    
//    path = [NSURL URLWithString:@"http://passport.sunlands.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
    [self.view addSubview:self.webView];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    [self addObserve];
    
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
    
//    [self addAlphaView];
}


- (void)addAlphaView {
    UIView *view = [UIView new];
    view.backgroundColor = rgba(0, 0, 0, 0.3);
    view.frame = CGRectMake(0, 0, kWidth, kHeight);
    view.userInteractionEnabled = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    
}

- (void)addObserve {
    [_webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

// -MARK:OC调起JS方法
- (void)runJSFunction {
    NSString *js = @"tips(500)";//可以向js传参数
    NSString *value = @"this.flashvars";
    //NSString *js = @"callJsAlert()";//无参数方法
    
    // 调用静态网页tips()方法
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",response);
    }];
    
    //尝试获取视频网站视频并播放
    [self.webView evaluateJavaScript:value completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", response, error);
        NSString *responseStr = [NSString stringWithFormat:@"%@",response];
        NSArray *arr = [responseStr componentsSeparatedByString:@"\""];
        for (NSString *sub in arr) {
            if ([sub containsString:@"http://www"]) {
                responseStr = sub;
            }
        }
        if (responseStr.length == 0) {
            return ;
        }
        return;
        JPVideoPlayerDetailViewController *single = [JPVideoPlayerDetailViewController new];
//        single.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:single animated:YES];
        single.videoPath = responseStr;
    }];
}

// 响应并处理被JS调用的方法
- (void)calliOS:(id)parameter {
    //作类型判断
    if ([parameter isKindOfClass:[NSArray class]]) {
        NSLog(@"%@",parameter);
    }else if ([parameter isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@",parameter);
    }else {
        //do nothing
    }
}

// sd网站获取直播链接，并打开。
- (void)getH5UrlWithUrl:(NSURL *)url {
    // 跳转直播
    if ([url.relativeString containsString:@"http://open.talk-fun.com/play"])
    {
        NSLog(@"%@\nurl--%@",@"----H5_Url",url);
        [[UIApplication sharedApplication] openURL:url];
    }
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
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0.0;
        }];
    }
}

#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //这里可以通过name处理多组交互
    if ([message.name isEqualToString:@"senderModel"]) {
        //body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
        NSLog(@"%@",message.body);
    }else if ([message.name isEqualToString:@"calliOS"]) {
        [self calliOS:message.body];
    }
}
#pragma mark = WKNavigationDelegate
//在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    NSURL *url = navigationAction.request.URL;
    
    NSLog(@"\nname--%@\nurl--%@",hostname,url);
    
    [self getH5UrlWithUrl:url];
    
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
    
    NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
    [webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (YMIsEmpty(response)) {
            return ;
        }
        
        //截获到视频地址了
        NSLog(@"response == %@",response);
        JPVideoPlayerDetailViewController *single = [JPVideoPlayerDetailViewController new];
        single.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:single animated:YES];
        single.videoPath = response;
    }];
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
