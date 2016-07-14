//
//  APPViewControllerIntercepter.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "APPViewControllerIntercepter.h"
#import <Aspects.h>
#import <UIKit/UIKit.h>


@implementation APPViewControllerIntercepter

+ (void)load
{
    [super load];
    [APPViewControllerIntercepter sharedInstance];
    
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static APPViewControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APPViewControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    if (self = [super init]) {
        //在这里做方法拦截
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                                  withOptions:(AspectPositionAfter)
                                   usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            
                                       [self viewWillAppear:animated viewController:[aspectInfo instance]];
                                   } error:NULL];
        
    }
    return self;
}

#pragma mark - Fake Methods

- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController
{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"[%@ viewWillAppear:%@]", [viewController class], animated ? @"YES" : @"NO");
}

@end
