//
//  YMWebViewUIDelegate.m
//  TJWebView
//
//  Created by YM on 16/7/12.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "YMWebViewUIDelegate.h"

@interface YMWebViewUIDelegate()

@end

@implementation YMWebViewUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentAlert:alert completion:nil];
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:(UIAlertActionStyleCancel)
                                            handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(false);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:(UIAlertActionStyleDestructive)
                                            handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(true);
    }]];
    
    [self presentAlert:alert completion:nil];
}


- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:prompt
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        completionHandler(textField.text);
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    
    [self presentAlert:alert completion:nil];
}

- (void)presentAlert:(UIAlertController *)alert completion:(void (^)(void))completion{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:alert
                         animated:YES
                       completion:completion];
}

@end
