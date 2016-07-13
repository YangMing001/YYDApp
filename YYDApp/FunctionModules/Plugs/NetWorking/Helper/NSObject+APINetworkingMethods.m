//
//  NSObject+APINetworkingMethods.m
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "NSObject+APINetworkingMethods.h"

@implementation NSObject (APINetworkingMethods)

- (id)apiDefaultValue:(id)defaultData{
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
    
    if ([self apiIsEmptyObject]) {
        return defaultData;
    }
    
    return self;
}
- (BOOL)apiIsEmptyObject{
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
