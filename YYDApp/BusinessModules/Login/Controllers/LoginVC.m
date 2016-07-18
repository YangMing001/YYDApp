//
//  LoginVC.m
//  YYDApp
//
//  Created by YM on 16/7/15.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "LoginVC.h"
#import "RegiestVC.h"
#import <Masonry.h>
#import "LoginViewModel.h"
#import <ReactiveCocoa.h>

@interface LoginVC ()<APIManagerCallBackDelegate>

@property (nonatomic,strong) UITextField *userNameTextField;
@property (nonatomic,strong) UITextField *userPWTextField;

@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *goRegBtn;


@property (nonatomic,strong) LoginViewModel *loginVM;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    [self prepareAction];
    [self layoutUI];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark -  APIManagerInterceptor Delegate

- (void)apiManagerCallBackDidFailed:(BaseAPIManager *)manager{
    //菊花停止

    //manager.errorMessage;
}

- (void)apiManagerCallBackDidSuccess:(BaseAPIManager *)manager{
    //菊花停止
    //
}

#pragma mark - Event
- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goRge{
    [self.navigationController pushViewController:[RegiestVC new] animated:YES];
}

#pragma mark - Private Method
/**
 *  准备UI
 */
- (void)prepareUI{
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.userPWTextField];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.goRegBtn];
}


- (void)prepareAction{
    @weakify(self);
    RAC(self.loginVM,userName) = self.userNameTextField.rac_textSignal;
    RAC(self.loginVM,userPW) = self.userPWTextField.rac_textSignal;
    
    RAC(self.userNameTextField,backgroundColor) = [self.loginVM.userNameSignal map:^id(NSNumber *userNameValid) {
        return [userNameValid boolValue]?[UIColor whiteColor]:[UIColor yellowColor];
    }];
    
    RAC(self.userPWTextField,backgroundColor) = [self.loginVM.userPWSignal map:^id(NSNumber *userPWValid) {
        return [userPWValid boolValue]?[UIColor whiteColor]:[UIColor yellowColor];
    }];

    RAC(self.submitBtn,enabled) = self.loginVM.enabelLoginSignal;
  
    [[self.submitBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        //转菊花
        @strongify(self);
        [self.loginVM.loginCommand execute:@2];
    }];
    self.loginVM.loginAPIManager.delegate = self;
    
}

- (void)layoutUI{
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.closeBtn.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    [self.userPWTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTextField.mas_bottom).offset(20);
        make.left.mas_equalTo(self.userNameTextField.mas_left);
        make.right.mas_equalTo(self.userNameTextField.mas_right);
        make.height.mas_equalTo(self.userNameTextField.mas_height);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userPWTextField.mas_bottom).offset(20);
        make.left.mas_equalTo(self.userPWTextField.mas_left);
        make.right.mas_equalTo(self.userPWTextField.mas_right);
        make.height.mas_equalTo(self.userPWTextField.mas_height);
    }];
    
    [self.goRegBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.submitBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(self.submitBtn.mas_left);
        make.right.mas_equalTo(self.submitBtn.mas_right);
        make.height.mas_equalTo(self.submitBtn.mas_height);
    }];
}



#pragma mark - Getter and Setter
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_closeBtn setBackgroundColor:[UIColor redColor]];
        [_closeBtn setTitle:@"X" forState:(UIControlStateNormal)];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeBtn;
}

- (UIButton *)goRegBtn{
    if (!_goRegBtn) {
        _goRegBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_goRegBtn setBackgroundColor:[UIColor redColor]];
        [_goRegBtn setTitle:@"去注册" forState:(UIControlStateNormal)];
        [_goRegBtn addTarget:self action:@selector(goRge) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _goRegBtn;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_submitBtn setBackgroundColor:[UIColor redColor]];
        [_submitBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    }
    return _submitBtn;
}

- (UITextField *)userNameTextField{
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField.backgroundColor = [UIColor whiteColor];
        _userNameTextField.placeholder = @"请输入用户名";
    }
    return _userNameTextField;
}

- (UITextField *)userPWTextField{
    if (!_userPWTextField) {
        _userPWTextField = [[UITextField alloc] init];
        _userPWTextField.backgroundColor = [UIColor whiteColor];
        _userPWTextField.placeholder = @"请输入密码";
    }
    return _userPWTextField;
}

- (LoginViewModel *)loginVM{
    if (!_loginVM) {
        _loginVM = [LoginViewModel new];
    }
    return _loginVM;
}


- (void)dealloc{
    
}
@end
