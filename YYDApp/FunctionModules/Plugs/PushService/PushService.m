//
//  PushService.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "PushService.h"
#import <JPUSHService.h>
#import <UIKit/UIKit.h>
#import "AppKeys.h"

@implementation PushService


/**
 *  注册推送服务
 */
+ (void)registerPushWithOptions:(NSDictionary *)launchOptions{
    
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:kJPushKey
                          channel:@"APPStore"
                 apsForProduction:kApsForProduction];
    
}

/**
 *  向服务端传送 deviceToken
 *
 *  @param deviceToken apns 返回的 deviceToken
 */
+ (void)registerDeviceToken:(NSData *)deviceToken{
    
    //如果不是极光 这一步可以保存 DeviceToken ，或者上传服务器
    [JPUSHService registerDeviceToken:deviceToken];
}



/**
 *  处理推送消息
 *
 *  @param userInfo 推送传递的消息
 */
+ (void)handleRemoteNotification:(NSDictionary *)userInfo{
    
    NSString *message = [userInfo description];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    //处理推送消息
    
    [JPUSHService handleRemoteNotification:userInfo];
}


+ (NSString *)registrationID{
     //如果不是极光 这一步可以上传 DeviceToken
    return [JPUSHService registrationID];
}

+ (void)removeBinding{
    
}



@end
