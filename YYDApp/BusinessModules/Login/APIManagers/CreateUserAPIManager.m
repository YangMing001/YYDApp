//
//  CreateUserAPIManager.m
//  YYDApp
//
//  Created by YM on 16/8/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "CreateUserAPIManager.h"

@implementation CreateUserAPIManager

- (NSString *)methodName{
    return @"/v3/tenant/createuser";
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
