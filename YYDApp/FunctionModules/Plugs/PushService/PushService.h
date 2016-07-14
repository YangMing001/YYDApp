//
//  PushService.h
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  推送 服务处理(目的更好的替换)
 */
@interface PushService : NSObject

/**
 *  注册推送服务
 */
+ (void)registerPushWithOptions:(NSDictionary *)launchOptions;


/**
 *  向服务端传送 deviceToken
 *
 *  @param deviceToken apns 返回的 deviceToken
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;


/**
 *  处理推送消息
 *
 *  @param userInfo 推送传递的消息
 */
+ (void)handleRemoteNotification:(NSDictionary *)userInfo;


/**
 *  获取推送服务本机的唯一标示
 *
 *  @return 推送唯一标示
 */
+ (NSString *)registrationID;

/**
 *  解除推送绑定
 */
+ (void)removeBinding;


@end
