//
//  CityAPIManager.m
//  YYDApp
//
//  Created by YM on 16/7/18.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "CityAPIManager.h"

@implementation CityAPIManager

- (NSString *)methodName{
    return @"api/open/subgyms";
}
- (NSString *)serviceType{
    return kAPIServiceYaoYD;
}
- (APIManagerRequsetType)requestType{
    return APIManagerRequsetTypeGet;
}

- (BOOL)shouldCache{
    return YES;
}


@end
