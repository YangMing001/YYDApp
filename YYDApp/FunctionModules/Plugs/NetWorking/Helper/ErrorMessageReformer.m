//
//  ErrorMessageReformer.m
//  YYDApp
//
//  Created by YM on 16/7/19.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "ErrorMessageReformer.h"

@implementation ErrorMessageReformer

- (id)manager:(BaseAPIManager *)manager reformData:(NSDictionary *)data{

    NSString *tempErrMessage = @"服务器异常";
    NSString *errorMessage = tempErrMessage;
    if (data) {
        errorMessage = data[@"error_description"]?:tempErrMessage;
    }
    return errorMessage;
}


@end
