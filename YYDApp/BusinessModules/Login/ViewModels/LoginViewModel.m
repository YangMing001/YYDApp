//
//  LoginViewModel.m
//  YYDApp
//
//  Created by YM on 16/7/18.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()<APIManagerParamSourceDelegate,APIManagerInterceptor,APIManagerValidator>
{
    NSInteger lastRequestID;
}
@end

@implementation LoginViewModel


- (instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    @weakify(self);
    
    self.userNameSignal = [[RACObserve(self, userName)
                            map:^id(NSString *text) {
                                @strongify(self);
                                return @([self isValidUserName:text]);
                            }] distinctUntilChanged];
    
    self.userPWSignal = [[RACObserve(self, userPW)
                            map:^id(NSString *text) {
                                @strongify(self);
                                return @([self isValidUserPW:text]);
                            }] distinctUntilChanged];
    
    self.enabelLoginSignal = [RACSignal combineLatest:@[self.userNameSignal,self.userPWSignal]
                                               reduce:^id(NSNumber *userNameValid,NSNumber *userPWValid){
        return @([userNameValid boolValue]&&[userPWValid boolValue]);
    }];
    
    self.loginCommand = [[RACCommand alloc] initWithEnabled:self.enabelLoginSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        return  [self loginSignal]  ;
    }] ;
}

#pragma mark - Private
- (BOOL)isValidUserName:(NSString *)userName{
    if (userName.length > 4) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidUserPW:(NSString *)userPW{
    if (userPW.length > 2) {
        return YES;
    }
    return NO;
}

- (RACSignal *)loginSignal{
    
   return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
       //cancel 最后一次的 request
       [self.loginAPIManager cancelRequestByRequsetID:lastRequestID];
       
       //存储一下 最后一次的 request ID
       lastRequestID = [self.loginAPIManager loadData];
       
       
       
       [subscriber sendCompleted];
       return nil;
    }];
}

- (RACSignal *)ccSignal{

    
    return [self rac_signalForSelector:@selector(manager:afterPerformFailWithResponse:) fromProtocol:@protocol(APIManagerInterceptor)]  ;
    

}

#pragma mark - Params Delegate
- (NSDictionary *)paramsForAPi:(BaseAPIManager *)manager
{
    return  @{@"username"  : self.userName,
              @"password"  : self.userPW,
              @"grant_type": @"password"};
}

- (NSDictionary *)headerFieldsForAPi:(BaseAPIManager *)manager
{
   return @{@"Authorization":@"Basic MzUzYjMwMmM0NDU3NGY1NjUwNDU2ODdlNTM0ZTdkNmE6Mjg2OTI0Njk3ZTYxNWE2NzJhNjQ2YTQ5MzU0NTY0NmM="};
}

#pragma mark -APIManagerInterceptor 
- (void)manager:(BaseAPIManager *)manager beforePerformSuccessWithResponse:(APIURLResponse *)response{
    //保存用户信息
}
- (void)manager:(BaseAPIManager *)manager afterPerformSuccessWithResponse:(APIURLResponse *)response{
    //
}

- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithCallBackData:(id)data{
    return ((NSDictionary *)data)[@"access_token"];
}
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return YES;
}




#pragma mark Getter And Setter
- (LoginAPIManager *)loginAPIManager{
    if(!_loginAPIManager){
        _loginAPIManager = [[LoginAPIManager alloc] init];
        _loginAPIManager.paramSource = self;
        _loginAPIManager.interceptor = self;
        _loginAPIManager.validator = self;
    }
    return _loginAPIManager;
}

-(void)dealloc{
    [self.loginAPIManager cancelAllRequests];
}

@end
