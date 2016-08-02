//
//  TokenAPIManager.m
//  YYDApp
//
//  Created by YM on 16/8/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "TokenAPIManager.h"

@implementation TokenAPIManager

- (NSString *)methodName{
    return nil;
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
