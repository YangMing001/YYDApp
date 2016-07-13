//
//  TJWebVC.m
//  TJWebView
//
//  Created by YM on 16/7/12.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "TJWebVC.h"
#import "WKWebViewJavascriptBridge.h"
#import "YMWebViewUIDelegate.h"
#import "YMWKScriptMessageHandler.h"
#import "YMWebViewNavDelegate.h"
#import "YMWebViewHelper.h"

NSString * const kEstimatedProgress = @"estimatedProgress";

@interface TJWebVC ()<WKNavigationDelegate,WKUIDelegate>



@property (nonatomic,strong) WKWebViewConfiguration *webViewConfiguration;
@property (nonatomic,strong) YMWebViewUIDelegate *UIDelegate;
@property (nonatomic,strong) YMWKScriptMessageHandler *messageHandler;
@property (nonatomic,strong) YMWebViewNavDelegate *navDelegate;
@property (nonatomic,strong) WKWebViewJavascriptBridge *jsBridge;

@property (nonatomic,strong) YMWebViewHelper *helper;

@property (nonatomic,copy) NSString *lastUrl;


@end

@implementation TJWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configAction];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.webView loadRequest:[self lastRequest]];
}

- (void)dealloc{
    NSLog(@"%s Dealloc ---",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.webView removeObserver:self forKeyPath:kEstimatedProgress];
}

#pragma mark - UI
/**
 *  配置UI
 */
- (void)configUI{
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    self.webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.progressView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-2, CGRectGetWidth(self.view.frame), 2);
    
}

- (void)configAction{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successLogin) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succeccLogout) name:@"logout" object:nil];
    
    [self.webView addObserver:self
                   forKeyPath:kEstimatedProgress
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    
    
    //注册 JS
    for (NSString *jsName in [self.helper.ymHelperMethodDic allKeys]) {
    
        __weak typeof(self) weakSelf = self;
        [self.jsBridge registerHandler:jsName
                               handler:^(id data, WVJBResponseCallback responseCallback) {
                                   __strong typeof(weakSelf) strongSelf = weakSelf;
                                   [strongSelf.helper
                                    ymHelperHandleName:jsName
                                    data:data
                                    callBack:responseCallback];
                               }];

    }
}


#pragma mark - KVO
- (void)successLogin{
}
- (void)succeccLogout{
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:kEstimatedProgress]) {
        
        if (object == self.webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            
            if(self.webView.estimatedProgress >= 1.0f) {
                
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}


#pragma mark - Delegate



#pragma mark - Event

#pragma mark - Private
- (NSURLRequest *)lastRequest{
    
    NSString *urlString = self.lastUrl?:@"ExampleApp.html";
    NSURL *url;
    if (![urlString hasPrefix:@"http"]) {
        urlString = [[NSBundle mainBundle] pathForResource:urlString ofType:@""];
        url = [NSURL fileURLWithPath:urlString];
    }else{
        url = [NSURL URLWithString:urlString];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}
#pragma mark - Getter and Setter

- (WKWebViewConfiguration *)webViewConfiguration{
    if (!_webViewConfiguration) {
        _webViewConfiguration = [[WKWebViewConfiguration alloc] init];

//配置原生JS处理 需要 前端配合
//        [_webViewConfiguration.userContentController addScriptMessageHandler:self.messageHandler
//          name:@""];
        
    }
    return _webViewConfiguration;
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero
                                      configuration:self.webViewConfiguration];
        
        _webView.UIDelegate = self.UIDelegate;
    }
    return _webView;
}

- (YMWebViewUIDelegate *)UIDelegate{
    if (!_UIDelegate) {
        _UIDelegate = [[YMWebViewUIDelegate alloc] init];
    }
    return _UIDelegate;
}

- (YMWebViewNavDelegate *)navDelegate{
    if (!_navDelegate) {
        _navDelegate = [[YMWebViewNavDelegate alloc] init];
    }
    return _navDelegate;
}

- (YMWKScriptMessageHandler *)messageHandler{
    if (!_messageHandler) {
        _messageHandler = [[YMWKScriptMessageHandler alloc] init];
    }
    return _messageHandler;
}

- (WKWebViewJavascriptBridge *)jsBridge{
    if (!_jsBridge) {
        _jsBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
        [_jsBridge setWebViewDelegate:self.navDelegate];
//        [WKWebViewJavascriptBridge enableLogging];
    }
    return _jsBridge;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView                   = [[UIProgressView alloc] init];
        _progressView.backgroundColor   = [UIColor whiteColor];
        _progressView.tintColor         = [UIColor blueColor];
    }
    return _progressView;
}

- (YMWebViewHelper *)helper{
    if (!_helper) {
        _helper = [YMWebViewHelper new];
        _helper.ymHelperCurrentVC = self;
    }
    return _helper;
}

- (void)setRequestUrl:(NSString *)requestUrl{
    _requestUrl = requestUrl;
    _lastUrl = _requestUrl;
}


@end
