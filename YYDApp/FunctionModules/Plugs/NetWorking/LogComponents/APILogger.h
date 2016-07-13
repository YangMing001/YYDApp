//
//  APILogger.h
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIService.h"
#import "APIURLResponse.h"
@interface APILogger : NSObject

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                        apiName:(NSString *)apiName
                        service:(APIService *)service
                  requestParams:(id)requestParams
                     httpMethod:(NSString *)httpMethod;


+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                   resposeString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;

+ (void)logDebugInfoWithCachedResponse:(APIURLResponse *)response
                            methodName:(NSString *)methodName
                     serviceIdentifier:(APIService *)service;

@end
