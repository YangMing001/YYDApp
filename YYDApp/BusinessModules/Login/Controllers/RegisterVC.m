//
//  RegisterVC.m
//  YYDApp
//
//  Created by YM on 16/8/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "RegisterVC.h"
#import <Masonry.h>
#import "CutDownButton.h"
#define kTopSpace  (20)
#define kRowHeight (30)

@interface RegisterVC ()

@property  (nonatomic,strong) UITextField *mobileTextField;
@property (nonatomic,strong) UITextField *verifyCodeTextField;
@property (nonatomic,strong) UIButton *sendMessageBtn;

@property (nonatomic,strong) UITextField *userPWTextField;
@property (nonatomic,strong) UITextField *verifyuserPWTextField;


@property (nonatomic,strong) CutDownButton *loginBtn;

@end

@implementation RegisterVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configAction];
}

- (void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.mobileTextField];
    
    [self.mobileTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(64 + kTopSpace);
        make.left.mas_offset(kTopSpace);
        make.right.mas_offset(- kTopSpace);
        make.height.mas_equalTo(kRowHeight);
    }];
    
    [self.view addSubview:self.verifyCodeTextField];
    [self.verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobileTextField.mas_bottom).offset(kTopSpace);
        make.left.mas_equalTo(self.mobileTextField.mas_left);
        make.height.mas_equalTo(self.mobileTextField.mas_height);
        make.width.mas_equalTo(self.mobileTextField.mas_width).multipliedBy(2.0/3.0);
    }];
    
    
    [self.view addSubview:self.sendMessageBtn];
    
    [self.sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyCodeTextField.mas_top);
        make.left.mas_equalTo(self.verifyCodeTextField.mas_right).offset(10);
        make.right.mas_equalTo(self.mobileTextField.mas_right);
        make.height.mas_equalTo(self.verifyCodeTextField.mas_height);
    }];
    
    
    [self.view addSubview:self.userPWTextField];
    [self.userPWTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sendMessageBtn.mas_bottom).offset(kTopSpace);
        make.left.mas_equalTo(self.verifyCodeTextField.mas_left);
        make.height.mas_equalTo(self.verifyCodeTextField.mas_height);
        make.right.mas_equalTo(self.sendMessageBtn.mas_right);
    }];
    
    [self.view addSubview:self.verifyuserPWTextField];
    [self.verifyuserPWTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userPWTextField.mas_bottom).offset(kTopSpace);
        make.left.mas_equalTo(self.userPWTextField.mas_left);
        make.right.mas_equalTo(self.userPWTextField.mas_right);
        make.height.mas_equalTo(self.userPWTextField.mas_height);
    }];
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyuserPWTextField.mas_bottom).offset(kTopSpace);
        make.left.mas_equalTo(self.verifyuserPWTextField.mas_left);
        make.height.mas_equalTo(self.verifyuserPWTextField.mas_height);
        make.right.mas_equalTo(self.verifyuserPWTextField.mas_right);
    }];
}

- (void)configAction{
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.fromType == FromTypeLogin) {
        self.navigationController.navigationBar.hidden = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.fromType == FromTypeLogin) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Getter And Setter

- (UITextField *)mobileTextField{
    if (!_mobileTextField) {
        _mobileTextField = [[UITextField alloc] init];
        _mobileTextField.backgroundColor = [UIColor redColor];
    }
    return _mobileTextField;
}

- (UITextField *)verifyCodeTextField{
    if (!_verifyCodeTextField) {
        _verifyCodeTextField = [[UITextField alloc] init];
        _verifyCodeTextField.backgroundColor = [UIColor redColor];
    }
    return _verifyCodeTextField;
}

- (UIButton *)sendMessageBtn{
    if (!_sendMessageBtn) {
        _sendMessageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _sendMessageBtn.backgroundColor = [UIColor redColor];
    }
    return _sendMessageBtn;
}

- (CutDownButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [CutDownButton buttonWithType:(UIButtonTypeCustom)];
        _loginBtn.backgroundColor = [UIColor redColor];
    }
    return _loginBtn;
}

- (UITextField *)userPWTextField{
    if (!_userPWTextField) {
        _userPWTextField = [[UITextField alloc] init];
        _userPWTextField.backgroundColor = [UIColor redColor];
    }
    return _userPWTextField;
}

- (UITextField *)verifyuserPWTextField{
    if (!_verifyuserPWTextField) {
        _verifyuserPWTextField = [[UITextField alloc] init];
        _verifyuserPWTextField.backgroundColor = [UIColor redColor];
    }
    return _verifyuserPWTextField;
}

@end
