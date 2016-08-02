//
//  RegisterViewModel.m
//  YYDApp
//
//  Created by YM on 16/8/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "RegisterViewModel.h"

@interface RegisterViewModel ()<APIManagerInterceptor>

@end

@implementation RegisterViewModel
- (instancetype)init{
    if (self = [super init]) {
        
        self.checkMobileApi.mobileNum = @"adafadfafa";
    }
    return self;
}





- (RACSignal *)sendMsgSignal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.checkMobileApi loadData];
        [subscriber sendCompleted];
        return nil;
    }];
}


#pragma mark - Getter And Setter
- (CheckMobileApiManager *)checkMobileApi{
    if (!_checkMobileApi) {
        _checkMobileApi = [[CheckMobileApiManager alloc] init];
    }
    return _checkMobileApi;
}

- (CreateUserAPIManager *)createUserAPI{
    if (_createUserAPI) {
        _createUserAPI = [[CreateUserAPIManager alloc] init];
    }
    return _createUserAPI;
}

- (SendMsgApiManager *)sendMsgApi{
    if (_sendMsgApi) {
        _sendMsgApi = [[SendMsgApiManager alloc] init];
    }
    return _sendMsgApi;
}



@end
