//
//  APIProxy.h
//  NetWorkX
//
//  Created by YM on 16/7/4.
//  Copyright © 2016年 YM. All rights reserved.
//

/**
 *  主要作用：
 *  生成 Request ID
 *  发送 请求
 */

#import <Foundation/Foundation.h>
#import "APIURLResponse.h"
#import "APIConfiguration.h"

typedef void(^APIProxyCallBack)(APIURLResponse *response);

@interface APIProxy : NSObject

+ (instancetype)shareInstance;



- (NSInteger)callAPIWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)serviceIdentifier
                    methodName:(NSString *)methodName
                   requestType:(NSInteger)type
                  headerFields:(NSDictionary *)fields
                       success:(APIProxyCallBack)success
                          fail:(APIProxyCallBack)fail;


- (void)cancelRequestByRequestID:(NSInteger)requestID;
- (void)cancelRequestByRequestIDList:(NSArray *)requestIDList;

@end
