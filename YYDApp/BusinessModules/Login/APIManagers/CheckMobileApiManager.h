//
//  CheckMobileApiManager.h
//  YYDApp
//
//  Created by YM on 16/8/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "BaseAPIManager.h"

@interface CheckMobileApiManager : BaseAPIManager<APIManagerInfo>

@property (nonatomic,copy) NSString *mobileNum;

@end
