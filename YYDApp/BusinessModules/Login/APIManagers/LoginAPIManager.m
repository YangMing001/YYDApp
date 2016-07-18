//
//  LoginAPIManager.m
//  YYDApp
//
//  Created by YM on 16/7/18.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "LoginAPIManager.h"

@implementation LoginAPIManager


#pragma Mark - info
- (NSString *)methodName{
    return  @"oauth/token";
}
- (NSString *)serviceType{
    return  kAPIServiceYaoYD;
}
- (APIManagerRequsetType)requestType{
    return APIManagerRequsetTypePost;
}
@end
