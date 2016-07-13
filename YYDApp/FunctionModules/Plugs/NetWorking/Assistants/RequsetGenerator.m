//
//  RequsetGenerator.m
//  NetWorkX
//
//  Created by YM on 16/7/4.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "RequsetGenerator.h"
#import <AFNetworking.h>
#import "APIService.h"
#import "APIServiceFactory.h"
#import "APILogger.h"
#import "NSURLRequest+APINetworkingMethods.h"
#import "APIConfiguration.h"
@interface RequsetGenerator ()

@property (nonatomic,strong) AFHTTPRequestSerializer *serializer;

@end

@implementation RequsetGenerator
#pragma mark - Lift Cycle

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static RequsetGenerator *generator = nil;
    dispatch_once(&onceToken, ^{
        generator = [[RequsetGenerator alloc] init];
    });
    return generator;
}

#pragma mark - Delegate

#pragma mark - Publich Methods


- (NSURLRequest *)generateRequestWithParams:(NSDictionary *)params
                          serviceIdentifier:(NSString *)identifier
                                 methodName:(NSString *)methodName
                                requestType:(NSString *)type
                               headerFields:(NSDictionary *)fields
{
    APIService *service = [[APIServiceFactory sharedInstance]
                           serviceWithIdentifier:identifier];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",service.apiBaseUrl,methodName];
    NSMutableURLRequest *request = [self.serializer requestWithMethod:type
                                                            URLString:urlString
                                                           parameters:params
                                                                error:NULL];
    if (fields) {
        [fields enumerateKeysAndObjectsUsingBlock:^(NSString  * _Nonnull  key, NSString   * _Nonnull obj, BOOL * _Nonnull stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }
    request.requestParams = params;
    [APILogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:params httpMethod:type];
    request.timeoutInterval = kAPIRequestTimeOut;
    return request;
}
#pragma mark - Private Methods

#pragma mark - Getters and Setters
- (AFHTTPRequestSerializer *)serializer{
    if (!_serializer) {
        _serializer = [AFHTTPRequestSerializer serializer];
    }
    return _serializer;
}
@end
