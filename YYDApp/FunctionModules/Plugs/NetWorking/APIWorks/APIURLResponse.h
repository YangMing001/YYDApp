//
//  APIURLResponse.h
//  NetWorkX
//
//  Created by YM on 16/7/4.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, APIResponseStatus) {
    APIResponseStatusSuccess,
    APIResponseStatusErrorTimeOut,
    APIResponseStatusErrorNoNetwork,
};

@interface APIURLResponse : NSObject

@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSString *responseString;
@property (nonatomic, copy, readonly) NSURLResponse *response;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, assign, readonly) BOOL isCache;
@property (nonatomic, copy) NSDictionary *requestParams;


@property (nonatomic,assign) APIResponseStatus status;

- (instancetype)initWithResponseString:(NSString *)responseString
                             requsetID:(NSInteger)requestID
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(APIResponseStatus)status;

- (instancetype)initWithResponseString:(NSString *)reponseString
                             requsetID:(NSInteger)requestID
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error;

- (instancetype)initWithData:(NSData *)data;

@end
