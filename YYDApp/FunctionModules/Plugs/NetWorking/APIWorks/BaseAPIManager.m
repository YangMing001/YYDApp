//
//  BaseAPIManager.m
//  NetWorkX
//
//  Created by YM on 16/7/4.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APILogger.h"
#import "APICache.h"
#import "APIServiceFactory.h"
#import <AFNetworking.h>
@interface BaseAPIManager ()

@property (nonatomic,strong,readwrite) id fetchedRawData;
@property (nonatomic,copy,readwrite) NSString *errorMessage;
@property (nonatomic,readwrite) APIManagerErrorType errorType;
@property (nonatomic,strong) NSMutableArray *requestIDList;
@property (nonatomic,strong) APICache *cache;

@end

@implementation BaseAPIManager

#pragma mark - Lift Cycle
- (instancetype)init{
    if (self = [super init]) {
        _delegate       = nil;
        _validator      = nil;
        _interceptor    = nil;
        _paramSource    = nil;
        _fetchedRawData = nil;
        _errorMessage   = nil;
        _errorType      = APIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(APIManagerInfo) ]) {
            self.child = (id <APIManagerInfo>)self;
        }else{
            NSAssert(NO, @"子类必须实现 APIManagerInfo 协议");
        }
    }
    return self;
}

- (void)dealloc{
    [self cancelAllRequests];
    self.requestIDList = nil;
}
#pragma mark - Delegate

#pragma mark - Event Response

#pragma mark - Publich Methods
- (NSInteger)loadData{
    NSDictionary *params    = [self.paramSource paramsForAPi:self];
    NSDictionary *fields    = [self.paramSource headerFieldsForAPi:self];
    NSInteger requestID     = [self loadDataWithParams:params headerFields:fields];
    return requestID;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params
                   headerFields:(NSDictionary *)headerFields{
    
    NSInteger requestID = 0;
    NSDictionary *apiParams = params;
    if ([self shouldCallApiWithParams:apiParams]) {
        if ([self validatorCallApiWithParams:apiParams]) {
            
            //缓存
            if ([self shouldCache] && [self hasCacheParams:params]) {
                return requestID;
            }
            // next
            
            if ([self isReachable]) {
                requestID = [[APIProxy shareInstance] callAPIWithParams:apiParams
                                                      serviceIdentifier:self.child.serviceType
                                                             methodName:self.child.methodName
                                                            requestType:self.child.requestType
                                                           headerFields:headerFields
                                                                success:^(APIURLResponse *response) {
                                                                    [self successOnCallingAPI:response];
                                                                }fail:^(APIURLResponse *response) {
                                                                    [self failedOnCallingAPI:response
                                                                               withErrorType:APIManagerErrorTypeDefault];
                                                                }];
                [self.requestIDList addObject:@(requestID)];
                NSMutableDictionary *tempParams = [apiParams mutableCopy];
                tempParams[kAPIManagerRequestID] = @(requestID);
                [self afterCallingAPIWithParams:params];
                return requestID;
            }else{
                [self failedOnCallingAPI:nil withErrorType:APIManagerErrorTypeNoNetWork];
                return requestID;
            }
        }else{
            [self failedOnCallingAPI:nil withErrorType:APIManagerErrorTypeParamsError];
            return requestID;
        }
    }
    return requestID;
}


- (void)cancelAllRequests{
    [[APIProxy shareInstance] cancelRequestByRequestIDList:self.requestIDList];
    [self.requestIDList removeAllObjects];
}

- (void)cancelRequestByRequsetID:(NSInteger)requestID{
    [self.requestIDList removeObject:@(requestID)];
    [[APIProxy shareInstance] cancelRequestByRequestID:requestID];
}

- (BOOL)shouldCache{
    return YES;
}

- (id)fetchDateWithReformer:(id<APIManagerCallBackDateReformer>)reformer{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        reformer = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}


#pragma mark - Private Methods

- (void)successOnCallingAPI:(APIURLResponse *)response
{
    self.fetchedRawData = response.responseData;
    [self removeRequestID:response.requestId];
    if ([self.validator manager:self isCorrectWithCallBackData:response.responseString]) {
        
        if ([self shouldCache] && !response.isCache) {
            // 缓存 。。。。。。。。
            [self.cache saveCacheWithData:response.responseData serviceIdentifier:self.child.serviceType methodName:self.child.methodName requestParams:response.requestParams];
        }
        
        [self beforPerformSuccessWithResponse:response];
        [self.delegate apiManagerCallBackDidSuccess:self];
        [self afterPerformSuccessWithResponse:response];
        
    }else{
        [self failedOnCallingAPI:response withErrorType:APIManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingAPI:(APIURLResponse *)response
             withErrorType:(APIManagerErrorType)errorType
{
    self.errorType = errorType;
    self.errorMessage = response.responseString;
    [self removeRequestID:response.requestId];
    [self beforPerformFailWithResponse:response];
    [self.delegate apiManagerCallBackDidFailed:self];
    [self afterPerformFailWithResponse:response];
}

- (BOOL)hasCacheParams:(NSDictionary *)params{
    
    NSString *serviceIdentifier = self.child.serviceType;
    NSString *methodName = self.child.methodName;
    NSData *result = [self.cache fetchCachedDataWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:params];
    
    if (result == nil) {
        return NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        APIURLResponse *response = [[APIURLResponse alloc] initWithData:result];
        response.requestParams = params;
        [APILogger logDebugInfoWithCachedResponse:response methodName:methodName serviceIdentifier:[[APIServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier]];
        [self successOnCallingAPI:response];
    });
    return YES;
}


- (void)removeRequestID:(NSInteger)requestID{
    [self.requestIDList removeObject:@(requestID)];
}
#pragma mark - method for interceptor
- (BOOL)shouldCallApiWithParams:(NSDictionary *)parmas
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        return [self.interceptor manager:self shouldCallAPIWithParams:parmas];
    }
    return YES;
}

- (BOOL)validatorCallApiWithParams:(NSDictionary *)parmas
{
    
    
    if (self != self.validator && [self.validator respondsToSelector:@selector(manager:isCorrectWithParamsData:)]) {
        return [self.validator manager:self isCorrectWithParamsData:parmas];
    }
    return YES;
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}

- (void)beforPerformSuccessWithResponse:(APIURLResponse *)response{
    self.errorType = APIManagerErrorTypeSuccess;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformSuccessWithResponse:)]) {
        [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
}

- (void)afterPerformSuccessWithResponse:(APIURLResponse *)response{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (void)beforPerformFailWithResponse:(APIURLResponse *)response{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
}

- (void)afterPerformFailWithResponse:(APIURLResponse *)response{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

#pragma mark - Getters and Setters
- (NSMutableArray *)requestIDList{
    if (!_requestIDList) {
        _requestIDList = [[NSMutableArray alloc] init];
    }
    return _requestIDList;
}

- (BOOL)isReachable{
    /** 网络的判断 */
    BOOL reachability = YES;
    
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
         reachability = YES;
    } else {
         reachability = [[AFNetworkReachabilityManager sharedManager] isReachable];
    }

    if (!reachability) {
        self.errorType = APIManagerErrorTypeNoNetWork;
    }
    return reachability;
}

- (BOOL)isLoading{
    return self.requestIDList.count;
}

- (APICache *)cache
{
    if (_cache == nil) {
        _cache = [APICache sharedInstance];
    }
    return _cache;
}
@end
