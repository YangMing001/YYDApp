//
//  YMMediator+LoginActions.m
//  YYDApp
//
//  Created by YM on 16/7/13.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "YMMediator+LoginActions.h"

NSString *const kMediatorTargetLogin = @"Login";

NSString *const kMediatorActionNativeFetchLoginVC = @"FetchViewControllerLogin";

@implementation YMMediator (LoginActions)


- (UIViewController *)MediatorViewControllerForLogin{
    UIViewController *vc = [self performTarget:kMediatorTargetLogin
                                        action:kMediatorActionNativeFetchLoginVC
                                        params:nil];
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }else{
        //异常
        return [[UIViewController alloc] init];
    }
}

@end
