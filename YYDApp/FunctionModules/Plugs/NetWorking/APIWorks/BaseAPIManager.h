//
//  BaseAPIManager.h
//  NetWorkX
//
//  Created by YM on 16/7/4.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIConfiguration.h"
#import "APIProxy.h"

@class BaseAPIManager;

static NSString *const kAPIManagerRequestID = @"kAPIRequestID";


typedef NS_ENUM(NSUInteger, APIManagerErrorType) {
    APIManagerErrorTypeDefault,     //没有产生过API请求，这个是manager的默认状态。
    APIManagerErrorTypeSuccess,     //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。

    APIManagerErrorTypeNoContent,   //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    APIManagerErrorTypeParamsError, //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。

    APIManagerErrorTypeTimeOut,     //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置
    APIManagerErrorTypeNoNetWork    //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};



@protocol APIManagerInfo <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (APIManagerRequsetType)requestType;

@optional

@end


/************************************************
        APIManagerCallBackDelegate
                回调协议
 ************************************************/

@protocol APIManagerCallBackDelegate <NSObject>

@required
- (void)apiManagerCallBackDidSuccess:(BaseAPIManager *)manager;
- (void)apiManagerCallBackDidFailed:(BaseAPIManager *)manager;

@end


/************************************************
        APIManagerCallBackDateReformer
                    DateReformer协议
 ************************************************/

@protocol APIManagerCallBackDateReformer <NSObject>

@required
- (id)manager:(BaseAPIManager *)manager reformData:(NSObject *)data;

@end


/************************************************
        APIManagerParamSourceDelegate
                参数源
 ************************************************/
@protocol APIManagerParamSourceDelegate <NSObject>

@required
- (NSDictionary *)paramsForAPi:(BaseAPIManager *)manager;

- (NSDictionary *)headerFieldsForAPi:(BaseAPIManager *)manager;

@end

/************************************************
        APIManagerValidator
                验证协议
 ************************************************/
@protocol APIManagerValidator <NSObject>

@required
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithCallBackData:(id)data;
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)data;

@end

/************************************************
        APIManagerInterceptor
                拦截器协议
 ************************************************/
@protocol APIManagerInterceptor <NSObject>

@optional
- (void)manager:(BaseAPIManager *)manager beforePerformSuccessWithResponse:(APIURLResponse *)response;

- (void)manager:(BaseAPIManager *)manager afterPerformSuccessWithResponse:(APIURLResponse *)response;

- (void)manager:(BaseAPIManager *)manager beforePerformFailWithResponse:(APIURLResponse *)response;

- (void)manager:(BaseAPIManager *)manager afterPerformFailWithResponse:(APIURLResponse *)response;

- (BOOL)manager:(BaseAPIManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(BaseAPIManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;



@end



/************************************************
                BaseAPIManager
************************************************/

@interface BaseAPIManager : NSObject

@property (nonatomic,weak) id<APIManagerParamSourceDelegate> paramSource;
@property (nonatomic,weak) id<APIManagerCallBackDelegate> delegate;
@property (nonatomic,weak) id<APIManagerValidator> validator;
@property (nonatomic,weak) id<APIManagerInterceptor> interceptor;

@property (nonatomic,weak) NSObject<APIManagerInfo> *child;


@property (nonatomic,copy,readonly) NSString *errorMessage;
@property (nonatomic,readonly) APIManagerErrorType errorType;

@property (nonatomic,assign,readonly) BOOL isReachable;
@property (nonatomic,assign,readonly) BOOL isLoading;

- (NSInteger)loadData;


- (void)cancelAllRequests;
- (void)cancelRequestByRequsetID:(NSInteger)requestID;

- (BOOL)shouldCache;
@end
