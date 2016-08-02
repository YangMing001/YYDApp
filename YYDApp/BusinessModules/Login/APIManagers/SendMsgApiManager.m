//
//  SendMsgApiManager.m
//  YYDApp
//
//  Created by YM on 16/8/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "SendMsgApiManager.h"

@implementation SendMsgApiManager


- (NSString *)methodName{
    return @"v3/sms/code";
}

- (NSString *)serviceType{
    return  kAPIServiceYaoYD;
}

- (APIManagerRequsetType)requestType{
    return APIManagerRequsetTypePost;
}

- (BOOL)shouldCache{
    return NO;
}

@end
