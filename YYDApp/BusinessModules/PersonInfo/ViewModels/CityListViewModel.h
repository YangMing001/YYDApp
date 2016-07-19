//
//  CityListViewModel.h
//  YYDApp
//
//  Created by YM on 16/7/18.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityAPIManager.h"

@interface CityListViewModel : NSObject

@property (nonatomic,strong) CityAPIManager *cityAPIManager;

@property (nonatomic,strong,readonly) NSArray *dataArray;


- (void)loadMore;

- (void)refresh;
@end
