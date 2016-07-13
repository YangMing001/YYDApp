//
//  WebViewJSHandler.m
//  TJWebView
//
//  Created by YM on 16/7/13.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "WebViewJSHandler.h"

@implementation WebViewJSHandler

#pragma mark - JS方法列表

- (void)login{
    NSLog(@"login");
}

- (void)goLogin1:(id)data {
    NSLog(@"login data = %@",data);
}

- (void)changeTitle:(id)data callBack:(YMResponseCallback)callBack{
    NSLog(@"login data = %@",data);
    callBack(@"cdddeeed");
}





#pragma mark - Setter And Getter
- (UIViewController *)ymHelperUserVC{
    if (!_ymHelperUserVC) {
        _ymHelperUserVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _ymHelperUserVC;
}


@end
