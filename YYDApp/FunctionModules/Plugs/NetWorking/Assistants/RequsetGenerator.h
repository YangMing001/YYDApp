//
//  RequsetGenerator.h
//  NetWorkX
//
//  Created by YM on 16/7/4.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequsetGenerator : NSObject

+ (instancetype)shareInstance;


- (NSURLRequest *)generateRequestWithParams:(NSDictionary *)params
                          serviceIdentifier:(NSString *)identifier
                                 methodName:(NSString *)methodName
                                requestType:(NSString *)type
                               headerFields:(NSDictionary *)fields;


@end
