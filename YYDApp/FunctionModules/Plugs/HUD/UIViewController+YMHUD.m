//
//  UIViewController+YMHUD.m
//  YYDApp
//
//  Created by YM on 16/8/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "UIViewController+YMHUD.h"
#import <MBProgressHUD.h>

@implementation UIViewController (YMHUD)

- (void)showHUD{
    [self showRefreshHUD:nil];
}

- (void)hideHUD{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    });
    
}


- (void)showFastToastHUD:(NSString *)msg{
    [self showTextHUD:msg duration:2];
}

#pragma mark - Private Mothed

/**
 *  显示文字 HUD
 *
 *  @param msg 文字
 */
- (void)showTextHUD:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = msg;
        
    });
    
}

/**
 *  显示 刷新 HUD
 *
 *  @param msg 文字
 */
- (void)showRefreshHUD:(NSString *)msg{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = msg;
        
    });
    
}

- (void)showTextHUD:(NSString *)msg duration:(NSTimeInterval)duration{
    [self showTextHUD:msg];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration
                                                              * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
    });
}



@end
