//
//  APICache.m
//  NetWorkX
//
//  Created by YM on 16/7/5.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "APICache.h"
#import "APICachedObject.h"
#import "APIConfiguration.h"
#import "NSDictionary+APINetworkingMethods.h"
@interface APICache()

@property (nonatomic,strong) NSCache *cache;

@end

@implementation APICache
#pragma mark - lift cycle
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static APICache *shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[APICache alloc] init];
    });
    return shareInstance;
}

#pragma mark - Publish Methods
- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary *)requestParams
{
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier
                                                            methodName:methodName
                                                         requsetParams:requestParams]];
}

- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams
{
    [self saveCacheWithData:cachedData key:[self keyWithServiceIdentifier:serviceIdentifier
                                                               methodName:methodName
                                                            requsetParams:requestParams]];
}

- (void)deleteCacheWithKey:(NSString *)key
{
    [self.cache removeObjectForKey:key];
}

- (void)clean
{
    [self.cache removeAllObjects];
}


#pragma mark - Private Methods
- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key
{
    APICachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject == nil) {
        cachedObject = [[APICachedObject alloc] init];
    }
    [cachedObject updateContent:cachedData];
    [self.cache setObject:cachedObject forKey:key];
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key
{
    APICachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        return nil;
    } else {
        return cachedObject.content;
    }
}

- (NSString *)keyWithServiceIdentifier:(NSString *)identifier
                            methodName:(NSString *)methodName
                         requsetParams:(NSDictionary *)requestParams{
    return [NSString stringWithFormat:@"%@%@%@",identifier,methodName,[requestParams APIDicUrlParamsString]];
    
}

#pragma mark - Getter and Setter

- (NSCache *)cache{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kAPICacheCountLimit;
    }
    return _cache;
}

@end
