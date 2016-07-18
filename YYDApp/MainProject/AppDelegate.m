//
//  AppDelegate.m
//  YYDApp
//
//  Created by YM on 16/7/13.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarVC.h"
#import "PlugsManager.h"
#import "AppDelegateHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //step 1 设置 Window、RootViewController

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [AppDelegateHelper rootViewController];
    [self.window makeKeyAndVisible];
    
    //step 2 注册第三方信息
    [PlugsManager registerForDidFinishLaunchingWithOptions:launchOptions];
    

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [PushService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [PushService handleRemoteNotification:userInfo];
}

#pragma mark - Private Methods




@end
