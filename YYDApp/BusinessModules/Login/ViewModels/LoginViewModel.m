//
//  LoginViewModel.m
//  YYDApp
//
//  Created by YM on 16/7/18.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()<APIManagerCallBackDelegate,APIManagerParamSourceDelegate>
@property (nonatomic,strong) LoginAPIManager *loginAPIManager;
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
        return [self loginSignal];
    }];
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
        [self.loginAPIManager loadData];
        [subscriber sendCompleted];
       return nil;
    }];
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
#pragma mark - API Call Back
- (void)apiManagerCallBackDidSuccess:(BaseAPIManager *)manager
{
    
}

- (void)apiManagerCallBackDidFailed:(BaseAPIManager *)manager
{
    
}

#pragma mark Getter And Setter
- (LoginAPIManager *)loginAPIManager{
    if(!_loginAPIManager){
        _loginAPIManager = [[LoginAPIManager alloc] init];
        _loginAPIManager.delegate = self;
        _loginAPIManager.paramSource = self;
    }
    return _loginAPIManager;
}

@end
