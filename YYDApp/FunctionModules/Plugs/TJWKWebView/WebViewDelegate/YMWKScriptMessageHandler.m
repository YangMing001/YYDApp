//
//  YMWKScriptMessageHandler.m
//  TJWebView
//
//  Created by YM on 16/7/13.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "YMWKScriptMessageHandler.h"

@implementation YMWKScriptMessageHandler

//处理Message
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
