//
//  GetUserAPIManager.m
//  YYDApp
//
//  Created by YM on 16/8/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "GetUserAPIManager.h"

@implementation GetUserAPIManager

- (NSString *)methodName{
    return @"/v3/tenant/getuser";
}

- (NSString *)serviceType{
    return  kAPIServiceYaoYD;
}

- (APIManagerRequsetType)requestType{
    return APIManagerRequsetTypeGet;
}

- (BOOL)shouldCache{
    return NO;
}


@end
