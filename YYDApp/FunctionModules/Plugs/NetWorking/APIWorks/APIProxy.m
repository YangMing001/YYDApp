//
//  APIProxy.m
//  NetWorkX
//
//  Created by YM on 16/7/4.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "APIProxy.h"
#import "RequsetGenerator.h"
#import "APILogger.h"
#import <AFNetworking.h>
@interface APIProxy()

@property (nonatomic,strong) NSMutableDictionary *dispatchTable;
@property (nonatomic,assign) NSInteger recordedRequestID;


@end
@implementation APIProxy

#pragma mark - Lift Cycle

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static APIProxy *proxy = nil;
    dispatch_once(&onceToken, ^{
        proxy = [[APIProxy alloc] init];
    });
    return proxy;
}



#pragma mark - Delegate

#pragma mark - Public Methods


- (NSInteger)callAPIWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)serviceIdentifier
                    methodName:(NSString *)methodName
                   requestType:(NSInteger)type
                  headerFields:(NSDictionary *)fields
                       success:(APIProxyCallBack)success
                          fail:(APIProxyCallBack)fail
{
    NSURLRequest *request = [[RequsetGenerator shareInstance]
                             generateRequestWithParams:params
                             serviceIdentifier:serviceIdentifier
                             methodName:methodName
                             requestType:[self requestTypeByType:type]
                             headerFields:fields];
    NSInteger requestID = [self callApiWithRequest:request success:success fail:fail];
    return requestID ;
    
}

- (void)cancelRequestByRequestID:(NSInteger)requestID{
    NSURLSessionTask *task = self.dispatchTable[@(requestID)];
    [task cancel];
    [self.dispatchTable removeObjectForKey:@(requestID)];
}

- (void)cancelRequestByRequestIDList:(NSArray *)requestIDList{
    for (NSNumber * requestID in requestIDList) {
        [self cancelRequestByRequestID:[requestID integerValue]];
    }
}

#pragma mark - Private Methods
/**起飞*/
- (NSInteger )callApiWithRequest:(NSURLRequest *)request
                         success:(APIProxyCallBack)success
                            fail:(APIProxyCallBack)fail
{
    NSInteger requestID = [self generateRequestID];
    //request 发送
    NSURLSessionDataTask *task = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSURLSessionDataTask *storedTask = self.dispatchTable[@(requestID)];
        
        if (storedTask == nil) {
            return ;
        }else{
            [self.dispatchTable removeObjectForKey:@(requestID)];
        }
        
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!error) {
         
            [APILogger logDebugInfoWithResponse:(NSHTTPURLResponse *)response resposeString:responseString request:request error:NULL ];
            
            APIURLResponse *response = [[APIURLResponse alloc]
                                        initWithResponseString:responseString
                                        requsetID:requestID
                                        request:request
                                        responseData:data
                                        status:APIResponseStatusSuccess];
            success?success(response):nil;
        }else{
              [APILogger logDebugInfoWithResponse:(NSHTTPURLResponse *)response resposeString:responseString request:request error:error ];
            APIURLResponse *response = [[APIURLResponse alloc]
                                        initWithResponseString:responseString
                                        requsetID:requestID
                                        request:request
                                        responseData:data
                                        error:error];
            fail?fail(response):nil;
        }
    }];
    self.dispatchTable[@(requestID)] = task;
    [task resume];
    return requestID;
}


- (void)callUploadAPIWithRequset{
    
}

- (NSString *)requestTypeByType:(APIManagerRequsetType)type{
    NSArray *requestOperations =  @[@"GET",@"POST",@"PUT",@"DELETE"];
    NSString *requestOperation = requestOperations[type];
    return requestOperation;
}


#pragma mark - Getters and Setters
- (NSMutableDictionary *)dispatchTable{
    if(!_dispatchTable){
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (NSInteger )generateRequestID{
    if (!_recordedRequestID) {
        _recordedRequestID = 1;
    }else{
        if (_recordedRequestID == NSIntegerMax) {
            _recordedRequestID = 1;
        }else{
            _recordedRequestID = _recordedRequestID  + 1;
        }
    }
    return _recordedRequestID;
}


@end
