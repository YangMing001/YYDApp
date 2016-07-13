//
//  APIServiceFactory.m
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "APIServiceFactory.h"

#import "YaoYDService.h"

 NSString *const kAPIServiceYaoYD = @"kAPIServiceYaoYD";

@interface APIServiceFactory ()

@property (nonatomic,strong) NSCache *serviceStorage;

@end

@implementation APIServiceFactory
#pragma mark - Lift Cycle
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static APIServiceFactory *factory = nil;
    dispatch_once(&onceToken, ^{
        factory = [[APIServiceFactory alloc] init];
    });
    return factory;
}

#pragma mark - Public Methods
- (APIService<APIServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier{
    if (![self.serviceStorage objectForKey:identifier]) {
        [self.serviceStorage setObject:[self newServiceWithIdentifier:identifier] forKey:identifier];
    }
    return [self.serviceStorage objectForKey:identifier];
}

#pragma mark - Private Methods
- (APIService<APIServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier{
    if ([identifier isEqualToString:kAPIServiceYaoYD]) {
        return [[YaoYDService alloc] init];
    }
    return nil;
}

#pragma mark - Getters and Setters
- (NSCache *)serviceStorage{
    if (!_serviceStorage) {
        _serviceStorage = [[NSCache alloc] init];
        _serviceStorage.countLimit = 5;
    }
    return _serviceStorage;
}
@end
