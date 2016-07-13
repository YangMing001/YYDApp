//
//  TJWebVC.h
//  TJWebView
//
//  Created by YM on 16/7/12.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>



@interface TJWebVC : UIViewController

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;

@property (nonatomic,copy) NSString *requestUrl;

@end
