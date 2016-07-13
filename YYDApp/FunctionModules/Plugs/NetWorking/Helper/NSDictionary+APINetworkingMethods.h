//
//  NSDictionary+APINetworkingMethods.h
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (APINetworkingMethods)


- (NSString *)APIDicUrlParamsString;
- (NSString *)APIDicjsonString;
- (NSArray *)APIDicTransformedUrlParamsArray;
@end
