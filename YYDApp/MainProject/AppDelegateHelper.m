//
//  AppDelegateHelper.m
//  YYDApp
//
//  Created by YM on 16/7/15.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "AppDelegateHelper.h"
#import "TabBarVC.h"

@implementation AppDelegateHelper

#pragma mark - Public Methods

+ (UIViewController *)rootViewController{
    return [AppDelegateHelper tabbarVC];
}

#pragma mark - Private Methods
+ (UIViewController *)tabbarVC{
    return [TabBarVC new];
}

+ (UIViewController *)guideVC{
    return [UIViewController new];
}

@end
