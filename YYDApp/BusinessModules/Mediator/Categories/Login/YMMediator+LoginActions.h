//
//  YMMediator+LoginActions.h
//  YYDApp
//
//  Created by YM on 16/7/13.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "YMMediator.h"

@interface YMMediator (LoginActions)

- (UIViewController *)MediatorViewControllerForLogin;

- (void)MediatorGoLogin:(NSDictionary *)callBack;


@end
