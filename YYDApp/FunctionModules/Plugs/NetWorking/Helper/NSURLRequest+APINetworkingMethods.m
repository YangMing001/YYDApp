//
//  NSURLRequest+APINetworkingMethods.m
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "NSURLRequest+APINetworkingMethods.h"
#import <objc/runtime.h>

static void *AIFNetworkingRequestParams;
@implementation NSURLRequest (APINetworkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &AIFNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &AIFNetworkingRequestParams);
}

@end
