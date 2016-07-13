//
//  YMWebViewNavDelegate.m
//  TJWebView
//
//  Created by YM on 16/7/13.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "YMWebViewNavDelegate.h"

@implementation YMWebViewNavDelegate

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView
didFailNavigation:(WKNavigation *)navigation
withError:(NSError *)error {
  
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    if (error) {
        [webView loadRequest:[self notFoundHtmlRequest]];
    }
}

- (NSURLRequest *)notFoundHtmlRequest{
    return nil;
}


@end
