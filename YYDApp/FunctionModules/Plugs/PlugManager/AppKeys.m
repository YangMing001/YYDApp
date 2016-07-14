//
//  AppKeys.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "AppKeys.h"



#define PAT

#ifdef  PAT

NSString *kJPushKey = @"88ad2ee679d0fe8922c3919a";

BOOL  kApsForProduction = YES;

#else


NSString *const kJPushKey = @"88ad2ee679d0fe8922c3919a";

BOOL const kApsForProduction = NO;

#endif
@implementation AppKeys

@end
