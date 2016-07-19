//
//  BaseAPIManager+errDescription.m
//  YYDApp
//
//  Created by YM on 16/7/19.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "BaseAPIManager+errDescription.h"

#import "ErrorMessageReformer.h"

@implementation BaseAPIManager (errDescription)

- (NSString *)errDescription{
    return [self fetchDataWithReformer:[ErrorMessageReformer new]];
}

@end
