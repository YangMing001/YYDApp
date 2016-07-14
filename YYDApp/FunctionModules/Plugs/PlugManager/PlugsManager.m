//
//  PlugsManager.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "PlugsManager.h"
#import <JPUSHService.h>
#import <UIKit/UIKit.h>
#import "AppKeys.h"


@implementation PlugsManager

+ (void)registerForDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    // step 1 注册推送
    [PushService registerPushWithOptions:launchOptions];
}



@end
