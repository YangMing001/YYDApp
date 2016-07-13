//
//  APIService.m
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "APIService.h"

@implementation APIService

- (instancetype)init{
    if (self = [super init]) {
        if ([self conformsToProtocol:@protocol(APIServiceProtocol) ]) {
            self.child = (id<APIServiceProtocol>)self;
        }
    }
    return self;
}

- (NSString *)apiBaseUrl{
    
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}


@end
