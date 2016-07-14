//
//  PlugsManager.h
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushService.h"


@interface PlugsManager : NSObject

/**
 *  在 方法  application: didFinishLaunchingWithOptions: 中使用
 *  注册第三方KEy
 */
+ (void)registerForDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
