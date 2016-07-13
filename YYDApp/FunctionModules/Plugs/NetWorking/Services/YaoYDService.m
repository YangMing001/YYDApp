//
//  YaoYDService.m
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "YaoYDService.h"

@implementation YaoYDService

#pragma mark - Protocal----------
- (BOOL)isOnline{
    return NO;
}

- (NSString *)onlineApiBaseUrl{
    return @"https://platform-api.1yd.me/";
}

- (NSString *)offlineApiBaseUrl{
    return @"http://platform-api.release.1yd.me/";
}


@end
