//
//  CheckMobileApiManager.m
//  YYDApp
//
//  Created by YM on 16/8/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "CheckMobileApiManager.h"

@implementation CheckMobileApiManager

#pragma Mark - info
- (NSString *)methodName{
    return  [NSString stringWithFormat:@"%@/%@",@"tenant/checkMobile",self.mobileNum];
}

- (NSString *)serviceType{
    return  kAPIServiceYaoYD;
}

- (APIManagerRequsetType)requestType{
    return APIManagerRequsetTypeGet;
}

@end
