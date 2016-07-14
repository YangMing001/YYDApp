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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self setupRootVC];
    [self.window makeKeyAndVisible];
    
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

- (UIViewController *)setupRootVC{
    return [TabBarVC new];
}




@end
