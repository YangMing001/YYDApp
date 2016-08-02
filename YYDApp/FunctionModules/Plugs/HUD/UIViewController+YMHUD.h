//
//  UIViewController+YMHUD.h
//  YYDApp
//
//  Created by YM on 16/8/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YMHUD)

- (void)showHUD;

- (void)hideHUD;

- (void)showFastToastHUD:(NSString *)msg;

@end
