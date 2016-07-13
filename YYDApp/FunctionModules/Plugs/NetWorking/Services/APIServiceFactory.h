//
//  APIServiceFactory.h
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIService.h"
@interface APIServiceFactory : NSObject

+ (instancetype)sharedInstance;

- (APIService<APIServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
