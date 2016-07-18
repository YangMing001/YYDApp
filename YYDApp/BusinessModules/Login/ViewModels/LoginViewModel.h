//
//  LoginViewModel.h
//  YYDApp
//
//  Created by YM on 16/7/18.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginAPIManager.h"
#import <ReactiveCocoa.h>

@interface LoginViewModel : NSObject

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userPW;

@property (nonatomic,strong) LoginAPIManager *loginAPIManager;


#pragma mark - Siganl 信号量

@property (nonatomic,strong) RACSignal *enabelLoginSignal;


@property (nonatomic,strong) RACSignal *userNameSignal;
@property (nonatomic,strong) RACSignal *userPWSignal;

#pragma mark - command 命令
@property (nonatomic,strong) RACCommand *loginCommand;

@end
