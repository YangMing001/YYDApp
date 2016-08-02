//
//  RegisterViewModel.h
//  YYDApp
//
//  Created by YM on 16/8/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa.h>
#import "CheckMobileApiManager.h"
#import "SendMsgApiManager.h"
#import "CreateUserAPIManager.h"

@interface RegisterViewModel : NSObject


@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *verifyCode;
@property (nonatomic,copy) NSString *userPW;
@property (nonatomic,copy) NSString *reUserPW;

@property (nonatomic,strong) CheckMobileApiManager *checkMobileApi;
@property (nonatomic,strong) SendMsgApiManager *sendMsgApi;
@property (nonatomic,strong) CreateUserAPIManager *createUserAPI;


#pragma mark - Siganl 信号量

@property (nonatomic,strong) RACSignal *enabelSendMsgSignal;
@property (nonatomic,strong) RACSignal *enabelCreateSignal;
@property (nonatomic,strong) RACSignal *enabelCheckSignal;



@property (nonatomic,strong) RACSignal *userNameSignal;
@property (nonatomic,strong) RACSignal *verifyCodeSignal;
@property (nonatomic,strong) RACSignal *userPWSignal;
@property (nonatomic,strong) RACSignal *reUserPWSignal;


#pragma mark - command 命令
@property (nonatomic,strong) RACCommand *createCommand;
@property (nonatomic,strong) RACCommand *sendMsgCommand;
@property (nonatomic,strong) RACCommand *checkCommand;



@end
