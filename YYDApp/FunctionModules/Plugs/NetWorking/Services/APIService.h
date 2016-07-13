//
//  APIService.h
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

//所有 Service 的派生类都要符合这个协议
@protocol APIServiceProtocol <NSObject>

@property (nonatomic,readonly) BOOL isOnline;

@property (nonatomic,readonly) NSString *offlineApiBaseUrl;
@property (nonatomic,readonly) NSString *onlineApiBaseUrl;

@end


@interface APIService : NSObject

@property (nonatomic,copy,readonly) NSString *apiBaseUrl;

@property (nonatomic,weak) id<APIServiceProtocol> child;

@end
