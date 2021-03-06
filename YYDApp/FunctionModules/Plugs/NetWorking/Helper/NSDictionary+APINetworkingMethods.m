//
//  NSDictionary+APINetworkingMethods.m
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "NSDictionary+APINetworkingMethods.h"
#import "NSArray+APINetworkingMethods.h"
@implementation NSDictionary (APINetworkingMethods)

- (NSString *)APIDicUrlParamsString{
    NSArray *sortedArray = [self APIDicTransformedUrlParamsArray];
    return [sortedArray APIArrayJsonString];
}
- (NSString *)APIDicjsonString{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSArray *)APIDicTransformedUrlParamsArray{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}

@end
