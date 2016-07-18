//
//  TargetLogin.m
//  YYDApp
//
//  Created by YM on 16/7/15.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "TargetLogin.h"
#import "LoginVC.h"
#import "APPNavigationController.h"
@implementation TargetLogin


- (NSDictionary *)ActionGoLogin:(NSDictionary *)callBack{
    LoginVC *vc = [LoginVC new];
    
    APPNavigationController *nav = [[APPNavigationController alloc] initWithRootViewController:vc];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    return nil;
    
}

@end
