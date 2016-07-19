//
//  APIURLResponse.m
//  NetWorkX
//
//  Created by YM on 16/7/4.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "APIURLResponse.h"
#import "NSURLRequest+APINetworkingMethods.h"
@interface APIURLResponse ()

@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, copy, readwrite) NSString *responseString;
@property (nonatomic, copy, readwrite) NSURLResponse *response;
@property (nonatomic, assign, readwrite) BOOL isCache;
@property (nonatomic, copy, readwrite) id content;

@end

@implementation APIURLResponse


- (instancetype)initWithResponseString:(NSString *)responseString
                             requsetID:(NSInteger)requestID
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(APIResponseStatus)status
{
    if (self = [super init]) {
        self.responseString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.request = request;
        self.requestId = requestID;
        self.responseData = responseData;
        self.status = status;
        self.isCache = NO;
        self.requestParams = request.requestParams;
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString
                             requsetID:(NSInteger)requestID
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error
{
    if (self = [super init]) {
        self.responseString = responseString;
        self.request = request;
        self.requestId = requestID;
        self.responseData = responseData;
        self.status = [self responseStatusWithError:error];
        self.isCache = NO;
        self.requestParams = request.requestParams;
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data{
    if (self = [super init]) {

        self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
         self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
 
    }
    return self;
}


- (APIResponseStatus)responseStatusWithError:(NSError *)error{
    if (error) {
        APIResponseStatus result = APIResponseStatusErrorNoNetwork;
        if (error.code == NSURLErrorTimedOut) {
            result = APIResponseStatusErrorTimeOut;
        }
        return result;
    }else {
        return APIResponseStatusSuccess;
    }
}
@end
