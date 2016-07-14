//
//  YMMediator+PersonActions.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "YMMediator+PersonActions.h"

NSString *const kMediatorTargetPersonInfo = @"PersonInfo";

NSString *const kMediatorActionFetchPersonVC = @"FetchViewControllerPersonVC";

@implementation YMMediator (PersonActions)

- (UIViewController *)MediatorViewControllerForPersonVC{
    UIViewController *vc = [self performTarget:kMediatorTargetPersonInfo
                                        action:kMediatorActionFetchPersonVC
                                        params:nil];
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }else{
        //异常
        return [[UIViewController alloc] init];
    }

}

@end
