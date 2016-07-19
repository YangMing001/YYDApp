//
//  CityListViewModel.m
//  YYDApp
//
//  Created by YM on 16/7/18.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "CityListViewModel.h"
@interface CityListViewModel()<APIManagerParamSourceDelegate,APIManagerInterceptor,APIManagerValidator>
{
    NSInteger currentPage;
}

@property (nonatomic,strong,readwrite) NSArray *dataArray;


@end

@implementation CityListViewModel


- (NSDictionary *)paramsForAPi:(BaseAPIManager *)manager{
    
    return @{@"activity_id"     : @"1",
             @"city_id"         : @"310100",
             @"district_id"     : @"",
             @"facility_id"     : @"",
             @"location_lat"    : @"31.87548038",
             @"location_lon"    : @"120.55615425",
             @"page"            : @"0",
             @"size"            : @"1",
             @"sort"            : @""
             };
    
}

- (NSDictionary *)headerFieldsForAPi:(BaseAPIManager *)manager{
    return  nil;
}

- (void)manager:(BaseAPIManager *)manager beforePerformSuccessWithResponse:(APIURLResponse *)response{
    
}

- (void)manager:(BaseAPIManager *)manager beforePerformFailWithResponse:(APIURLResponse *)response{
}

- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithCallBackData:(id)data{
    return YES;
}
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return YES;
}




- (void)loadMore{
    [self.cityAPIManager loadData];
}

- (void)refresh{
    [self.cityAPIManager loadData];

}


- (CityAPIManager *)cityAPIManager{
    if (!_cityAPIManager) {
        _cityAPIManager = [[CityAPIManager alloc] init];
        _cityAPIManager.paramSource = self;
        _cityAPIManager.interceptor = self;

    }
    return _cityAPIManager;
}

@end
